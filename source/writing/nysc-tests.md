---
title: Rx tees up tests.
date: 2017-03-18
---

If you write code for mobile, by now you've heard of Reactive programming ("Rx" for short). I won't explain the pattern in detail here, you'll find more capable instruction elsewhere.[^evangelists] Instead, I want to demonstrate one of its less discussed "second order" benefits: you'll write more testable code simply by adopting it.

Let's walk through a feature built with Rx to see how it tees up your tests. Our example is drawn from an iOS app I recently built for New York Sports Club,[^nysc] which offers a bunch of classes its members can reserve in advance.  Here's the view they use to reserve a class: 

<br/>
![“reserve class view”](http://screenshots.brent.is/anZpqjSLOl.png)
<br/>

We'll just focus on the most complicated part of that view, the "reserve" button. Sure it *looks* simple, but its appearance and behavior can change, even as the customer views it:

- when the reservation deadline passes, disable it.
- ditto if the class fills up.
- if they've *already* reserved the class, cancel the reservation.
- *except* if it's too late to cancel, then disable it.
- ...and so on, you get the idea: many potential states!

Ensuring the button is always correct, then, is a function of updating it whenever any of those circumstances change. A function that Rx gives us, literally, in [`combineLatest`](http://reactivex.io/documentation/operators/combinelatest.html): 

```swift
// pseudocode, for brevity
Rx.combineLatest(changingCircumstances) { (latestCircumstances) in
  theButtonView.render(latestCircumstances)
}
```

Now, *which* circumstances?		
To use this function, which so closely mirrors to how we naturally frame the solution, Rx encourages us to identify *each and every* variable that influences our button. For example, we should disable it when the reservation deadline passes, so we’ll need two distinct variables for comparison: the reservation deadline and the current time, as it passes.

```swift
let time = // updates every 30 seconds, for example
let deadlineChanges = // might change, occasionally
Rx.combineLatest(time, deadlineChanges) { (now, deadline) in
  let deadlineLapsed: Bool = (now > deadline)
  theButtonView.render(deadlineLapsed)
}
```

*How* we implement those variables is less important here than the fact that we *can* (using Rx’s powerful Observable type), and so we *do*. Why? These are the same variables we need to write tests! We have to factor out these dependencies in any approach, but we get them “for free” with Rx as a natural byproduct of working to use its functional operators.

With all our feature's dependencies in-hand, we need only expose them to our tests for manipulation during test runs.[^gist] And the result is powerful: we can quickly verify all of our feature's potential states in a single test. Here’s a run of the UX test I wrote for this feature:

<br/>
<video preload controls>
  <source src="https://screenshots.brent.is/4MJEqKcOw9.mp4" />
</video>
<br/>

It's hard to overstate how reassuring it is to watch your code quickly and correctly handle all expected circumstances. If you crave that assurance too, try the Reactive pattern. It guides you to write testable code.



[^evangelists]: I learned Reactive Programming from @ashfurrow's many [articles](https://ashfurrow.com/blog) and [talks](https://ashfurrow.com/speaking) on the pattern, @andrestaltz's [intro gist](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754) (yes, a gist, but a *very good one*) and [egghead tutorials](https://egghead.io/instructors/andre-staltz), @kzaher's thorough RxSwift [docs](https://github.com/ReactiveX/RxSwift/tree/fab323650e0c3489e08f65dc30689c4a36ec7470/Documentation) (complete with [Swift playground](https://github.com/ReactiveX/RxSwift/tree/fab323650e0c3489e08f65dc30689c4a36ec7470/Rx.playground)), and Artsy's generously open-sourced [iOS apps](https://github.com/artsy).


[^nysc]: [Kettle](https://kettlenyc.com/) hired me to work alongside their product, design, and server engineering teams as part of their extensive brand work for the club. Check out their [case study!](https://kettlenyc.com/case-studies/nysc)

[^gist]: How you go about this depends on your platform, language, architecture, testing tools, etc. I'll maintain code snippets relevant to our iOS example [elsewhere](https://gist.github.com/brenthargrave/ebd6324dcfc3a02f6bdfaf4e6aaf3699).