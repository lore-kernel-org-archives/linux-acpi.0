From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Mon, 17 Sep 2012 22:50:32 +0200
Message-ID: <201209172250.33157.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209080017.17418.rjw@sisk.pl> <5056D96C.5040904@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58464 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab2IQUoF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Sep 2012 16:44:05 -0400
In-Reply-To: <5056D96C.5040904@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Monday, September 17, 2012, Daniel Lezcano wrote:
> On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
> > On Friday, September 07, 2012, Daniel Lezcano wrote:
> >> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
> >>         cpuidle: Single/Global registration of idle states
> >>
> >> we have a single registration for the cpuidle states which makes
> >> sense. But now two new architectures are coming: tegra3 and big.LITTLE.
> >>
> >> These architectures have different cpus with different caracteristics
> >> for power saving. High load => powerfull processors, idle => small processors.
> >>
> >> That implies different cpu latencies.
> >>
> >> This patchset keeps the current behavior as introduced by Deepthi without
> >> breaking the drivers and add the possibility to specify a per cpu states.
> >>
> >>  * Tested on intel core 2 duo T9500
> >>  * Tested on vexpress by Lorenzo Pieralsi
> >>  * Tested on tegra3 by Peter De Schrijver
> >>
> >> Daniel Lezcano (6):
> >>   acpi : move the acpi_idle_driver variable declaration
> >>   acpi : move cpuidle_device field out of the acpi_processor_power
> >>     structure
> >>   acpi : remove pointless cpuidle device state_count init
> > 
> > I've posted comments about patches [1-3/6] already.  In short, I don't like
> > [1/6], [2/6] would require some more work IMO and I'm not sure about the
> > validity of the observation that [3/6] is based on.
> > 
> > Yes, I agree that the ACPI processor driver as a whole might be cleaner
> > and it probably would be good to spend some time on cleaning it up, but
> > not necessarily in a hurry.
> > 
> > Unfortunately, I also don't agree with the approach used by the remaining
> > patches, which is to try to use a separate array of states for each
> > individual CPU core.  This way we end up with quite some duplicated data
> > if the CPU cores in question actually happen to be identical.
> 
> Actually, there is a single array of states which is defined with the
> cpuidle_driver. A pointer to this array from the cpuidle_device
> structure is added and used from the cpuidle core.
> 
> If the cpu cores are identical, this pointer will refer to the same array.

OK, but what if there are two (or more) sets of cores, where all cores in one
set are identical, but two cores from different sets differ?

In that case it would be good to have one array of states per set, but the
patch doesn't seem to do that, does it?

> Maybe I misunderstood you remark but there is no data duplication, that
> was the purpose of this approach to just add a pointer to point to a
> single array when the core are identical and to a different array when
> the cores are different (set by the driver). Furthermore, this patch
> allows to support multiple cpu latencies without impacting the existing
> drivers.

Well that's required. :-)

> > What about using a separate cpuidle driver for every kind of different CPUs in
> > the system (e.g. one driver for "big" CPUs and the other for "little" ones)?
> > 
> > Have you considered this approach already?
> 
> No, what would be the benefit of this approach ?

Uniform handling of all the CPUs of the same kind without data duplication
and less code complexity, I think.

> We will need to switch
> the driver each time we switch the cluster (assuming all it is the bL
> switcher in place and not the scheduler). IMHO, that could be suboptimal
> because we will have to (un)register the driver, register the devices,
> pull all the sysfs and notifications mechanisms. The cpuidle core is not
> designed for that.

I don't seem to understand how things are supposed to work, then.

What _exactly_ do you mean by "the bL switcher", for instance?

Rafael
