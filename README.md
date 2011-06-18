Fast Scrolling in Tweetie with UITableView
==========================================

Scrolling is the primary method of interaction on the iPhone. It has to be fast. It has to be fast. More than a few developers have asked me how I do it in Tweetie, so I figured I would share a really fast and really clean technique people can adopt in their own apps.

The Solution
------------

Cutting to the chase, here’s the secret: One custom view per table cell, and do your own drawing. Sounds simple? That’s because it is. It’s actually simpler than dealing with a ton of subviews of labels and images, and it’s about a bzillion times faster (according to my informal tests).

Why it’s Fast
-------------

Much like on Mac OS X, there are two drawing systems on the iPhone. One is CoreGraphics, the other is `CoreAnimation`. `CoreGraphics` does drawing on the CPU, `CoreAnimation` does drawing on whatever it thinks is fastest - most likely the GPU.

The GPU on the iPhone hates blending, that’s why Apple recommends that you keep as many of your views opaque as possible. Sometimes you have no choice - if you have a label over an image you are forced to make the label transparent otherwise you get a big ugly block around your text.

What’s a developer to do? Pre-blend of course… with CoreGraphics into your own view. If you blend your stuff together into a single static view on demand (e.g. when a table view moves a cell onscreen), it’s a little bit more expensive for the first frame, but every frame after that CoreAnimation is just dealing with one big, opaque texture… which it loves. It’s more than just the blending too. If you think about what is happening in terms of overdraw, having one big view per table cell is a big win because CoreAnimation will only touch a single given pixel on the screen once rather than multiple times (potentially, depending on how much overlap your old view hierarchy had).

The Code
--------

I put together a small example project showing off this technique. It’s a simple scrolling list of cells with some text but draws the text using two different fonts, much like the Address Book Contacts list on the iPhone (regular and bold fonts). The technique is extensible to pretty much any style cell you need - I use the same thing in Tweetie and draw the chat bubble, text, and avatar all together into a single view.

There is one handy class that you can use for everything, see: ABTableViewCell.h and ABTableViewCell.m in the full example project here: FastScrolling.zip.

It doesn’t help that Apple doesn’t have any good examples on how to get good scrolling performance. The one table view example I checked (a while ago, it may have been updated) was absolutely horrible in terms of scrolling performance. Horrible.

If you wanted to know why Tweetie is so fast, now you do. It’s an incredibly simple technique and should be very easy to adopt.

Update: It looks like Apple has in fact updated the example code. Check out the fifth example in their TableViewSuite.
