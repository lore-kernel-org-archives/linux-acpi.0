From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc5 -rc5-mm1: kacpid continuously generating 4% CPU load on HPC nx6325 w/ SUSE 10.1
Date: Wed, 6 Sep 2006 21:00:38 +0200
Message-ID: <200609062100.39166.rjw@sisk.pl>
References: <200609031123.02237.rjw@sisk.pl> <200609052224.58749.rjw@sisk.pl> <44FEE0F5.9090404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41107 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751204AbWIFS5p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 14:57:45 -0400
In-Reply-To: <44FEE0F5.9090404@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Yu Luming <luming.yu@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Seyfried <seife@suse.de>

On Wednesday, 6 September 2006 16:53, Alexey Starikovskiy wrote:
> There is an infinite loop in thermal GPE handler of these HP machines,
> which could only be interrupted by thermal device poll. In this loop handler
> sends Notify() to thermal zone, which, if executed, will cause the needed poll.
> Problem is that this Notify() will be queued in the same kacpid workqueue,
> which executes loop of the handler, so it has no chance to run -- we have a dead lock.
> SUSE sets all thermal zones into polling mode, thus breaking the above
> loop every 2-3 seconds or so (polling interval). At this moment all queued notifies
> for thermal zone are free to run, and you see your 4% of cpu usage by kacpid.
> There are several attempts to remove the above deadlock by either having a pool of threads (up to 10),
> stealing work from single kacpid workqueue thread (Peters' patch), or executing notify()
> events on separate kernel thread (my patch).
> Peters' patch is already shipped in Ubuntu 6.06 kernel, mine was removed from -rc2 after
> it broke Linus' Compaq n620c, which has slightly different loop in DSDT (global locks this time).
> Peters' patch seems dangerous as it tampers with workqueue interface and solves the problem by brute force methods,
> while mine had problem of possibly creating a classical fork DoS atack and creating threads during work of
> suspend/resume -thus breaking it.
> I just did one more attempt to solve this problem -- there is already patch to not defer execution of global lock
> release (thus removing it from dead lock scenario of n620c), so the only dead lock could happen between execution of
> Notify and whatever is on kacpid workqueue. Creation of second workqueue for notifies seems to solve problem with my
> nx6125, while not breaking suspend and not creating threads dynamically.
> 
> Hope that explanation is usefull,

Sure it is, thanks a lot!

Could you please tell me where I can find your patch so I can test it here?

Rafael


> Rafael J. Wysocki wrote:
> > On Tuesday, 5 September 2006 18:19, Alexey Starikovskiy wrote:
> >> Please try a patch from #5534 bug report, it seems you have the same deadlock as all other HP users.
> > 
> > Well, could you please tell me which comments are you referring to?
> > 
> > The fans seem to work correctly on this box.
> > 
> > Greetings,
> > Rafael
> > 
> > 
> >> Rafael J. Wysocki wrote:
> >>> On Tuesday, 5 September 2006 08:47, Yu Luming wrote:
> >>>> On Sunday 03 September 2006 17:23, Rafael J. Wysocki wrote:
> >>>>> Hi,
> >>>>>
> >>>>>  I'm having a strange issue with the 2.6.18-rc5 and -rc5-mm1 kernels and
> >>>>>  SUSE 10.1 on HPC nx6325 that kacpid is generating 4% of CPU load (on one
> >>>>> core) in a continuous manner.
> >>>> Please try to unload thermal module.
> >>> albercik:~ # rmmod thermal
> >>>
> >>> [hanging? On another console:]
> >>> albercik:~ # ps ax
> >>> ...
> >>> 4864 pts/0    D+     0:00 rmmod thermal
> >>> ...
> >>>
> >>>>>  It sometimes helps if powersaved is restarted, but only for a short time.
> >>>>>  However, after restarting powersaved the kacpid-generated load sometimes
> >>>>> jumps to 100% (on one core) and stays on this level.
> >>>>>
> >>>>>  At the same time the battery is never reported to be 100% full (it stops
> >>>>> at ~98% full and loading) and when I tried to unload the battery module,
> >>>>> rmmod ended up in the D state.
> >>>> what do you mean by "in the D state"?
> >>> TASK_UNINTERRUPTIBLE (like above).
> >>>
> >>> Greetings,
> >>> Rafael
> >>>
> >>>
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
