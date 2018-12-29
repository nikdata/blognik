---
title: "I Need More Power"
authors: ["nikagarwal"]
date: "2018-03-24"
draft: FALSE
---

Recently at work, I was in a meeting in which another group was building their business case to have access to increased computing power. They wanted access to a [spark](https://spark.apache.org) cluster, have their data loaded into a [Hive](https://hive.apache.org), and wanted to leverage significant computing power to do clustering analysis. Typically, I'm not a big fan of teams saying they need more power. Why? That's the exact same question I want to ask them too. For many tasks at work, I don't believe any group needs to have insane power to prototype solutions. Generally speaking, I think heavy power usage should be done when a group is trying to operationalize their models. What I want to share today is how I approached my communication with this group to help them understand the role of increased power and their potential alternatives. Remember, in a business setting, everything that is done should be done with the mindset of how the action(s) can improve the overall business in terms of revenue and profit.

## What are you trying to achieve?

This is such a simple question to answer that I'm always amazed as to how many groups fail to answer this question successfully. The vast majority of the time, the real answer for these groups is that they are simply doing **exploratory data analysis** (EDA) - not modeling. Remember, when a model is constructed, it has a response variable - a variable that the model is trying to explain/predict. During an EDA, the goal is simply to understand what each variable (regardless of it being a predictor or response) is 'saying'.

## Clustering is not modeling

I know there will be several folks that will disagree with me on this. However, clustering is not *predictive* modeling. Rather, clustering is an arithmetic method of grouping observations. The trick to clustering is to know that each cluster value is absolutely meaningless without doing an EDA on each cluster. I'll probably write more about clustering later, but the point stands that when a clustering analysis is done, it's critical that an analyst take the time to understand each cluster so that each one can be explained properly.

## Are you sampling?

I find that many folks that are not well versed in statistics feel that having **all** the data are necessary to develop meaningful conclusions. Reality is that you don't need "all the data". Rather, if you *know* what you're doing, sampling is efficient, meaningful, and ideal. However, in order for sampling to be effective, you really need to understand the context of the problem that you are trying to solve. Randomly sampling noise will result in noisy samples. In the case of this meeting, the folks were trying to determine error code relationships to each other. What they forgot is that error codes, at least on the machines we work with, vary from model year to model year. So why look at four years' worth of data (which also means four different model years?).

## What about the cost?

Unsurprisingly, the group was not even aware of costs. They had heard that our team was prototyping new technologies such as Spark, Data Bricks, C3, etc. However, everything in business has a cost and when you spend any money (whether it's modeling, using the newest piece of technology, etc.), you are expected to deliver some kind of ROI (Return On Investment). Unlike in school, where you can build countless models until you get the best model, in business, a model you build that is good enough is ok. You don't necessarily need the best performing model. For instance, if you showed me two models for classification (assume multi-class) and one model was a random forest with 92% accuracy and an XGBoost model with 96% accuracy, my first question would be how much does each model cost? The cost is associated with not only developing the model, but also implementing it. If you told me that the implementation of the random forest model can be done in minutes and only cost $100 whereas the XGBoost may take hours to implement and require an investment in new hardware, I'd probably scoff. In the end, I need to know the ROI and my ROI could be as little as 1 week or 2 years - depending on what we're doing.

In terms of this group, we asked about ROI and what a new piece of technology could provide. Ultimately, they had no idea and they wanted more computing power since their laptops couldn't handle the data. Little did they know that they could have use the database itself (it's a Netezza appliance) to do clustering and get an idea - without having to download the data into their computer and run it through RStudio.

## That's a wrap folks

In the end, our team denied this group's request for more computing power. The reasons below are the exact reasons why they were denied:
* requestor not able to identify clear business objective
* requestor constructing models without clear understanding
* requestor using extraneous data without justified reasons
* requestor asking for service with no clearly defined ROI (return on investment)

All this returns to the same point everyone tells you about in class: know the business objective. In some roles at companies, the job is just to push the boundaries and crunch lots of data. Such is not the case at our company and that's ok. We're not a full-blown tech company like Stack Exchange, Apple, Google, SAP, etc. Rather, we're a heavy equipment manufacturer with limited funds. That's why, it's critical for us to first answer the why before we go into the how.
