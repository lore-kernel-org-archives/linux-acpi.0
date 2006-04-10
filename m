From: Holger Macht <hmacht@suse.de>
Subject: Re: kernel vs user power management
Date: Mon, 10 Apr 2006 10:35:45 +0200
Message-ID: <20060410083544.GB20070@homac.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB622B275@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-laptop-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB622B275@hdsmsx411.amr.corp.intel.com>
Sender: linux-laptop-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: thoenig@suse.de, linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org, Andi Kleen <ak@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Sat 08. Apr - 23:06:54, Brown, Len wrote:
> >On Sat 08. Apr - 02:42:12, Brown, Len wrote:
> >> Timo, Holger,
> >> Andi pointed me to your FOSDEM Linux Power Management presentation:
> >> 
> >> http://en.opensuse.org/FOSDEM2006
> >> 
> >> http://files.opensuse.org/opensuse/en/b/b5/One_step_opendesign.pdf
> >> 
> >> And I'm glad to see you working on Linux Power Management.
> >> 
> >> But I'm a little concerned that user-space and the kernel are
> >> a little out of sync on a few things.
> >> 
> >> I'm happy to see that the userspace p-state governor
> >> is no longer enabled by default on SuSE systems.
> >> While it was passable on servers with steady-state
> >> workloads, it was very bad for laptops where the
> >> machine spends a lot of time idle, but has short
> >> bursts of processing need which userspace could
> >> not detect.  These laptops would spend virtually
> >> all their time in Pn when using the userspace governor.
> >
> >To be honest, this observation suprises me a little bit. We did some
> >measurements with userspace agains ondemand governor some time 
> >ago and did not notice any big differences in the results between them.
> >Well, these tests are about 1 1/2 years ago, though, and there went some 
> >changes into the kernel until now ;-)
> 
> Yes, measurements show that ondemand as improved
> considerably since its initial implementation.
> It continues to improve today, though there is now smaller room for improvement.
> 
> Also, the other important thing to meausre here is *response time* --
> not throughput.  This will expose the benefits of switching quickly
> via ondemand vs. slowly via userspace.
> This is particularly important on interarctive workloads.
> 
> No, you'll not notice much, if any,  difference for course grain things
> like doing a kernel build or running a steady-state server workload.

Agreed.

> 
> >Nevertheless, we adjust the sampling rate in any case and 
> >currently set it to 333 milliseconds (that's configurable).
> >We noticed if we use the
> >default ondemand setting, the ondemand governor increases the frequency
> >too often although there is not much to do which is also not 
> >helpful.
> 
> I have not observed the ondemand governor today switching up
> more often than is helpful.
> 
> I speak for intel hardware, of course.
> It might be that other hardware, which can not switch up and down
> very quickly, not not benefit from ondemand and may be better
> suited to userspace.

Ok. But to decrease this value of 333 milliseconds should be a good idea
in any case.

> 
> >But 333 milliseconds is maybe a bit too high, it's taken because 
> >of historical reasons.
> >This value _was_ the default interval of our main event loop.
> >I think I will lower it a bit.
> 
> Go ahead and tune userspace to work optimally on systems that can't run ondemand.
> Systems that are able to run ondemand should not be running userspace
> at all.

They don't at the moment.

> 
> >Furthermore, we had some problems on multiprocessor systems in the past
> >(about 1/2 year ago) with the ondemand governor. After some time the
> >system was running (even some hours or even days) the machine locked up
> >hard.  Thus, we set the userspace governor by default on those systems
> >where we never experienced such problems. At the moment I did 
> >only get one similar report where the root cause is not clear.
> 
> It is important that this failure be root caused and this
> doubt be put behind us.  Got a bug URL?

See Andi's mail. I didn't know that this is already fixed.

> 
> >So I stick to the
> >ondemand governor in any case in newer releases. And such lockups are
> >really hard to reproduce and to debug.
> >
> >Another argument was that speedstep_ich was not yet ready for ondemand
> >which it is now IIRC.
> 
> speedstep-centrino and acpi-cpufreq support real p-states and can
> can support ondemand.  (indeed, these two drivers need to be merged into a single driver)
> 
> While older systems will use speedstep-ich, I don't expect to see much
> use for it on modern systems.  p4clockmod is just t-states,
> and one could argue that it should not exist at all.

Yes, we do not use or load p4clockmod it in any case because of that.

> 
> I don't know if the amd-specific drivers would work or not.
> Last I heard their latency was too high, but maybe they've
> fixed that.
> 
> There is a cpufreq architecture issue here here, of course.
> the drivers make all the different states look the same
> to the governors.  But P-states and T-states are not the same,
> they are very different.

Yes, of course.

> 
> >> The next step is to delete the userspace governor
> >> as a valid governor selection entirely.  If somebody
> >> really wants manual control, they can still set the
> >> limits within which "ondemand" will stay.
> >
> >In current code, I always try to use the ondemand governor at 
> >first and if that fails we automatically switch to the userspace
> >implementation at runtime.
> >
> >This way has the advantage that we always get a working cpu
> >frequency scaling support.. But it also has one big disadvantage, we do
> >not get reports about not working ondemand governor so maybe 
> >we simply did fot notice the improvements in this area. For our stable 
> >releases, I will keep the current inplementation. For the unstable one,
> >I will disable the
> >autoswitching code and if it still works good then for a few 
> >month, I will remove the userspace implementation completely.
> >It should not hurt to let
> >the code in for some time and remove the visible configuration option,
> >just to have fallback under strange circumstances.  Would this 
> >be ok with you?
> 
> I think you'll need to keep the userspace backup scheme for systems
> which have switching latency too high to load and run ondemand.
> 
> However, systems which can run ondemand, should never run userspace,
> and providing userspace as an option on such systems is probably
> not the right knob to present to administrators on those boxes.

Well, then could change that configuration option we have currently
(CPUFREQ_CONTROL="") to a secret one. Not showing it in the configuration
file, but it can still be put in if someone knows it or we tell him.

> 
> >> I'm happy to see that clock throttling is not enabled by
> >> default in recent SuSE release, at least on my laptop
> >> which supports P-states.
> >> 
> >> I'd like to see no option to enable clock-throttling on
> >> systems that support real p-states.
> >
> >Yes, this is reasonable, indeen. Will do that. With p-states in this
> >context, you mean cpufreq here?
> 
> throttling is always T-states.
> cpufreq is usually p-states, but in the case of p4clockmod,
> it is T-states also.  As I mentioned above, cpufreq is doing
> you a dis-service by hiding the difference from you
> and really need to be enhanced to know (and export)
> the difference.

Yes, this would be good, indeed. But what else drivers are currently
affected? It's only p4clockmod I know of.

> 
> >> It is useful only for workloads which have an infinite
> >> amount of non-idle computing which you don't care how
> >> slow it computes.  For the vast majority of workloads
> >> it just slows down the machine and delays the processor
> >> from getting into idle where it can save a non-linear
> >> amount of power.  Further, there exist today systems which
> >> will consume MORE power in deep C-states when throttled
> >> vs. when not throttled.
> >> 
> >> The other major topic is the user/kernel interface
> >> for power management policy.  there needs to be in-kernel
> >> state for this, else the device drivers will have no low-latency
> >> way to get the answer to the simple policy question of how 
> >they should
> >> optimize for performance vs power at any given instant when they
> >> recognize their device is idle..  this state should be controlled
> >> by user space, but I think it is most practical for it to
> >> be kernel resident.
> >
> >I'm not sure if I completely understand what you mean here. Do you mean
> >the so called "runtime device power management"?
> 
> yes.
> 
> >If so, I fully agree with you. But I do not set a specific 
> >policy in the powersave code explicitely for that feature.
> >If the policy information
> >will go into the kernel, I will use and set this one, of course.
> 
> okay, great.
> Yes, the kernel folks have known for years that this has to be done.
> Hopefully progress will be made soon...
> 
> thanks,
> -Len

Regards,
	Holger
