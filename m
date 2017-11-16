From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Fri, 17 Nov 2017 00:34:17 +0100
Message-ID: <4875746.ro5yELCUiR@aspire.rjw.lan>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org> <7bfe82ba-0063-0b58-de06-ac534eef36e9@arm.com> <c45d5fc9-e613-bafd-cc06-60ccccd03019@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48081 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965845AbdKPXec (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Nov 2017 18:34:32 -0500
In-Reply-To: <c45d5fc9-e613-bafd-cc06-60ccccd03019@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Timur Tabi <timur@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>

On Thursday, November 16, 2017 6:50:51 PM CET Prakash, Prashanth wrote:
> Hey Sudeep,
> 
> On 11/16/2017 7:52 AM, Sudeep Holla wrote:
> >
> > On 15/11/17 18:37, Rafael J. Wysocki wrote:
> >> On Wed, Nov 15, 2017 at 7:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>
> >>> On 15/11/17 15:33, Timur Tabi wrote:
> >>>> On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>>> I still prefer this as debugfs and not as sysfs ABI. We already have
> >>>>> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
> >>>>> I don't want this to end up in the same way after few years. CPUIdle
> >>>>> sysfs should be only sysfs ABI for these, adding an alternative is
> >>>>> inviting troubles for future especially if some user-space starts using
> >>>>> it and we will be stuck with that. Moreover with more h/w controlled
> >>>>> idle we may not provide accurate data sooner.
> >>>>>
> >>>>> Sorry for the noise, I will shup up now ;). Since this may be last
> >>>>> chance to make some noise, I am trying it. I completely understand that
> >>>>> this is just my opinion and am fine if others thinks it's good to make
> >>>>> this sysfs ABI.
> >>>> Unfortunately, I think Prashanth really needs a specific requirement
> >>>> rather than opinions.
> >>> I completely understand that. So for I haven't got a solid reason as
> >>> why debugfs is not sufficient? If it becomes so popular in future, we
> >>> can discuss and then make it sysfs ABI with more thoughts/discussions.
> >> Well, the recent discussions regarding tracepoints indicate that the
> >> ABI rule is not really about where the stuff is located in the
> >> directory structure. :-)
> >>
> > Agreed.
> >
> >> The main question to me is whether or not the information exposed is
> >> more suitable for debugfs or for sysfs, considering all of the
> >> limitations (like one value per file rule in sysfs etc).
> >>
> > I was thinking of keeping it simple and just one file for all the stats
> > like we have /sys/kernel/debug/clk/clk_summary
> >
> > It looks somethings like below:
> >    clock       enable_cnt  prepare_cnt    rate   accuracy   phase
> > ----------------------------------------------------------------------
> >  juno:uartclk         1            2     7273800       0      0
> > ...
> >
> >
> >> Of course, debugfs means that the users of, say, Android will not be
> >> able to access this information, but should that really influence
> >> decisions at the technical level?
> >>
> > That's the idea. IIUC, this is basically useful in the initial days of
> > development to tune your idle parameters and for idle characterization.
> > I am not sure(and hope) that this will be consumed by some application
> > and acted upon dynamically. It's more like collect data, analyze, tune,
> > repeat and rinse until happy with the tuning.
> >
> > Prashanth/Timur, please correct me if that's not the case. Understanding
> > how the data is used is essential here.
> 
> One of the use case is definitely initial idle characterization. With the whole
> hierarchy it does open up some additional use cases even after the initial
> characterization depending on how high/deep the hierarchy is.
> 
> It is sometimes interesting to see how higher level idle states are getting utilized
> for different workloads and tweaking some thread-placement may help make
> a workload run more efficiently w.r.t power. Similarly how autopromotable states
> are used with different workloads.
> 
> For the above use cases, the hierarchical view is very important, so we need a
> way to represent the dependency b/w CPU, cluster and any other higher levels.
> That's why the existing ACPI sysfs hierarchy was so nice. I haven't though about a
> lot about how to represent  the above on a single debugfs file yet.

That doesn't have to be one file, but you can use one file per Processor
Container or Processor object, for example.  That already would be fewer
files than in sysfs. :-)

Thanks,
Rafael

