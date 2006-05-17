From: Holger Macht <hmacht@suse.de>
Subject: Re: kernel vs user power management
Date: Wed, 17 May 2006 11:14:40 +0200
Message-ID: <20060517091440.GA9901@linux-ersb.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB679B59B@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:39865 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932497AbWEQJPH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 May 2006 05:15:07 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB679B59B@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: thoenig@suse.de, linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org, Andi Kleen <ak@suse.de>

On Wed 17. May - 00:20:12, Brown, Len wrote:
>  
> >> >> I'm happy to see that clock throttling is not enabled by
> >> >> default in recent SuSE release, at least on my laptop
> >> >> which supports P-states.
> >> >> 
> >> >> I'd like to see no option to enable clock-throttling on
> >> >> systems that support real p-states.
> >> >
> >> >Yes, this is reasonable, indeen. Will do that. With p-states in this
> >> >context, you mean cpufreq here?
> >> 
> >> throttling is always T-states.
> >> cpufreq is usually p-states, but in the case of p4clockmod,
> >> it is T-states also.  As I mentioned above, cpufreq is doing
> >> you a dis-service by hiding the difference from you
> >> and really need to be enhanced to know (and export)
> >> the difference.
> >
> >Yes, this would be good, indeed. But what else drivers are currently
> >affected? It's only p4clockmod I know of.
> >
> >> 
> >> >> It is useful only for workloads which have an infinite
> >> >> amount of non-idle computing which you don't care how
> >> >> slow it computes.  For the vast majority of workloads
> >> >> it just slows down the machine and delays the processor
> >> >> from getting into idle where it can save a non-linear
> >> >> amount of power.  Further, there exist today systems which
> >> >> will consume MORE power in deep C-states when throttled
> >> >> vs. when not throttled.
> 
> I installed SL10.1 today on a P3M laptop (Dell D600)
> and it defaults to the "Powersave" scheme which includes
> "Dynamic Frequency Scaling" (ondemand), so that is good.
> 
> However, by defaulit "Allow Throttling" is CHECKED
> and Max %  is set to 50%.
> 
> Exactly what does this mean?
> I looked in /proc/acpi/processor/*/throttling and the
> laptop is still in T0.

It means that the powersaved throttles your CPU if there is no load and
dethrottles if there is load. It's that way already for several years and
I only got a report about performance loss on SMP systems, so we don't do
throttling by default on those systems.

> Is there an easy way for me to modify the kernel to
> convince the powersaved application that the system
> does not support throttling?  I'm thinking that we've
> given user-space too much rope and it has proceeded
> to hang itself.

I'm currently working on a solution to allow throttling only on systems
which don't support CPUfreq. At the point this thread came up, or a few
days later as we talked about it, I completely agreed with you. But at
that time we already had RC1 in regard to SUSE Linux 10.1, so there was no
possibility anymore to change such a default behaviour. For the unstable
powersave realeases, there will come up some changes soon, though.


Regards,
	Holger
