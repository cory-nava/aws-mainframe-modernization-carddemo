AI x safety net benefits happy hour in SF this Thursday
First, our AI squad at Propel is in San Francisco this week and we’re having an informal happy hour with others who are working on / thinking about / tinkering with applications of AI to safety net benefits (SNAP, Medicaid, WIC etc.)

If you’re in the Bay and interested, reach out to me! (You can reply here or ping me another way.)

(As a reminder, also just announced AI Residency.)

Thanks for reading Dave Guarino's Occasional Newsletter! Subscribe for free to receive new posts and support my work.

Type your email...
Subscribe
A legacy systems moonshot: AI for characterization test generation
Here is a moonshot for you.

We appear to have a large capability breakthrough in modern AI/LLM capabilities for generating software code. And not just generation of lines of code but also agentic capabilities where an AI can do things like run a piece of code and look at the output in the terminal, or even click around a web browser (in web apps.)

We also have a long-standing stuck equilibrium in government technology: that of The $VENDOR_NAME Problem.

(Many people call it this with that variable filled in. I tend not to, and try to avoid the phrase because I'm not sure that it can be blamed on a particular vendor, but rather is the emergent system equilibrium that is incentivized by a bunch of actors with particular constraints interacting in an iterated fashion.)

In short, this problem can be described as something like this:

A government system is built by one of a handful of large technology vendors who do the projects as a professional services contract

The building of the technology is primarily costed out by hours multiplied by hourly rates for employees

Over time, the government agency finds that changes to that system are increasingly costly and time-intensive

Everyone is angry about this, but no one has a clear approach to changing it.

Jumping to a radically different approach carries lots of risks, especially from a signaling perspective in the sense that taking an unorthodox approach and failing can be higher perceived risk than taking the normal approach everybody else takes, and complaining that you get the same bad outcome. (Again, worth emphasizing, I don't blame any individual actor for these actions as they're fairly rational and sensible.)

But here's the moonshot idea: one of the few very strong approaches I'm aware of to reducing the cost of change in existing software systems is creating significant automated test coverage of how the system works today.

Crucially, this test coverage does not describe how the policy works, or how leadership thinks the system works.

It is literally a tautological, empirical description of "hey, when you poke at the system in this way, it does this."

More specifically, this kind of automated test is often called a characterization test: it's merely describing how the system actually works.

And the reason this works is that the primary safety concern around making changes is that you might have unintended side effects.

The default path for this is manually doing quality assurance testing: an actual person clicks around and makes sure that the newly changed system doesn't do anything unexpected or undesirable.

But of course that's a terribly time-intensive activity. And costly if you’re paying that person by the hour.

So if you have automated tests that can run and describe how the system works, and if they cover enough of how people actually use the system, then when you make a change you can run this test suite in something closer to minutes than days or weeks, which would be the human process, and then you know if anything broke.

All this is to say that while there's been a lot of excitement about AI coding tools, the number one thing I see posted online is creation of greenfield apps.

I myself am more curious about whether these coding capabilities could be used to create this kind of large characterization test suite for a system that currently people are terrified of changing.

If we break this down into sub-capabilities, I think my mind goes more towards the agentic coding tools because some of the things you really want here from a process perspective are as follows:

1. Generating some reasonable user case/scenario, and generating test code to simulate it (maybe with a pre-task of setting up a way of running such a minimal test)

2. Being able to capture what comes out or what happens when you run that test case

3. Being able to add back on what you captured to the original test case to say, "Hey, right now if you do X then Y happens. Let's write that in stone in an automated test case."

I honestly have not seen much prior art here in AI/LLM discussion. (Entirely possible because this is not the sort of thing that makes for your average high engagement Twitter video!) I would love pointers to anyone doing work like this.

What would make for a good target legacy system to try this on here?

1. There are some large or old systems, even ones that have been retired, where the source code is available online. Not in actual use means not risky at all. (Though of course you might drift from reality taking this approach.)

2. It could be a government technology system where there is in fact a lot of change needed, but not much funding.

For example, I spent some time working with states on unemployment insurance during the pandemic, and structurally there is no federal standing funding match for technology changes to those systems.

This is dissimilar from, for example, SNAP or Medicaid, where there is a federal match on funding for IT systems and changes. Though SNAP as well may become more of a target area given that recent legislation changes the share that the federal government pays for system changes from 50% down to 25% in a few years. The rest of the money must come from state budgets.

There's not much risk in this approach here because you're generating tests.

The real risk comes from the changes you might make in response to the tests.

But depending on how you want to approach this, you could keep on doing manual QA and see to what extent the generated test coverage actually covers the same as what a human does in QA. Consistently getting 100%? Maybe you can start getting bolder.

Do I think this would work today?

I'd probably put it at something like 30-40%, depending on the specific system chosen as the target, the team implementing this experiment, and the current capabilities today.

I'm not aware of any prior art in this area. If you are aware of tools or teams doing this kind of thing, please do let me know!

