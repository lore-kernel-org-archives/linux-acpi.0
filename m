From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Tue, 18 Sep 2012 23:05:14 +0200
Message-ID: <201209182305.14261.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209172250.33157.rjw@sisk.pl> <50579784.4090000@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60628 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189Ab2IRU7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 16:59:02 -0400
In-Reply-To: <50579784.4090000@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com, "len.brown@intel.com >> Len Brown" <len.brown@intel.com>

On Monday, September 17, 2012, Daniel Lezcano wrote:
> On 09/17/2012 10:50 PM, Rafael J. Wysocki wrote:
> > On Monday, September 17, 2012, Daniel Lezcano wrote:
> >> On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
> >>> On Friday, September 07, 2012, Daniel Lezcano wrote:
> >>>> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
> >>>>         cpuidle: Single/Global registration of idle states
> >>>>
> >>>> we have a single registration for the cpuidle states which makes
> >>>> sense. But now two new architectures are coming: tegra3 and big.LITTLE.
> >>>>
> >>>> These architectures have different cpus with different caracteristics
> >>>> for power saving. High load => powerfull processors, idle => small processors.
> >>>>
> >>>> That implies different cpu latencies.
> >>>>
> >>>> This patchset keeps the current behavior as introduced by Deepthi without
> >>>> breaking the drivers and add the possibility to specify a per cpu states.
> >>>>
> >>>>  * Tested on intel core 2 duo T9500
> >>>>  * Tested on vexpress by Lorenzo Pieralsi
> >>>>  * Tested on tegra3 by Peter De Schrijver
> >>>>
> >>>> Daniel Lezcano (6):
> >>>>   acpi : move the acpi_idle_driver variable declaration
> >>>>   acpi : move cpuidle_device field out of the acpi_processor_power
> >>>>     structure
> >>>>   acpi : remove pointless cpuidle device state_count init
> >>>
> >>> I've posted comments about patches [1-3/6] already.  In short, I don't like
> >>> [1/6], [2/6] would require some more work IMO and I'm not sure about the
> >>> validity of the observation that [3/6] is based on.
> >>>
> >>> Yes, I agree that the ACPI processor driver as a whole might be cleaner
> >>> and it probably would be good to spend some time on cleaning it up, but
> >>> not necessarily in a hurry.
> >>>
> >>> Unfortunately, I also don't agree with the approach used by the remaining
> >>> patches, which is to try to use a separate array of states for each
> >>> individual CPU core.  This way we end up with quite some duplicated data
> >>> if the CPU cores in question actually happen to be identical.
> >>
> >> Actually, there is a single array of states which is defined with the
> >> cpuidle_driver. A pointer to this array from the cpuidle_device
> >> structure is added and used from the cpuidle core.
> >>
> >> If the cpu cores are identical, this pointer will refer to the same array.
> > 
> > OK, but what if there are two (or more) sets of cores, where all cores in one
> > set are identical, but two cores from different sets differ?
> 
> A second array is defined and registered for these cores with the
> cpuidle_register_states function.
> 
> Let's pick an example with the big.LITTLE architecture.
> 
> There are two A7 and two A15, resulting in the code on 4 cpuidle_device
> structure (eg. dev_A7_1, dev_A7_2, dev_A15_1, dev_A15_2). Then the
> driver registers a different cpu states array for the A7s and the A15s
> 
> At the end,
> 
> dev_A7_1->states points to the array states 1
> dev_A7_2->states points to the array states 1
> 
> dev_A15_1->states points to the array states 2
> dev_A15_2->states points to the array states 2
> 
> It is similar with Tegra3.
> 
> I think Peter and Lorenzo already wrote a driver based on this approach.
> Peter, Lorenzo any comments ?
> 
> The single registration mechanism introduced by Deepthi is kept and we
> have a way to specify different idle states for different cpus.
> 
> > In that case it would be good to have one array of states per set, but the
> > patch doesn't seem to do that, does it?
> 
> Yes, this is what does the patch.

OK

Now, if you look at struct cpuidle_driver, it is not much more than the
array of struct cpuidle_state objects.  Yes, there are more fields in there,
but they are all secondary.

This means that by adding a new array of states you effectively add a different
cpuidle driver for those CPU cores.

> >> Maybe I misunderstood you remark but there is no data duplication, that
> >> was the purpose of this approach to just add a pointer to point to a
> >> single array when the core are identical and to a different array when
> >> the cores are different (set by the driver). Furthermore, this patch
> >> allows to support multiple cpu latencies without impacting the existing
> >> drivers.
> > 
> > Well that's required. :-)
> 
> Yes :)
> 
> >>> What about using a separate cpuidle driver for every kind of different CPUs in
> >>> the system (e.g. one driver for "big" CPUs and the other for "little" ones)?
> >>>
> >>> Have you considered this approach already?
> >>
> >> No, what would be the benefit of this approach ?
> > 
> > Uniform handling of all the CPUs of the same kind without data duplication
> > and less code complexity, I think.
> > 
> >> We will need to switch
> >> the driver each time we switch the cluster (assuming all it is the bL
> >> switcher in place and not the scheduler). IMHO, that could be suboptimal
> >> because we will have to (un)register the driver, register the devices,
> >> pull all the sysfs and notifications mechanisms. The cpuidle core is not
> >> designed for that.
> > 
> > I don't seem to understand how things are supposed to work, then.
> 
> Sorry, I did not suggest that.

No, but that's what happened, actually. :-)

I didn't realize that you wanted to address the "bL switcher" use case and now
the changes make more sense to me than before, but still I'd prefer this to be
done a bit differently.

> I am wondering how several cpuidle drivers can co-exist together in the state
> of the code. Maybe I misunderstood your idea.

Well, we have the assumption that there will be only one cpuidle driver in the
system, but I don't think it would be a big deal to change that.

> The patchset I sent is pretty simple and do not duplicate the array states.
> 
> That would be nice if Len could react to this patchset (4/6,5/6, and
> 6/6). Cc'ing him to its intel address.

Well, I'm afraid you'll need to deal with me instead. :-)

> > What _exactly_ do you mean by "the bL switcher", for instance?
> 
> The switcher is in charge of migrating tasks from the A7 to A15 (and
> vice versa) depending on the system load and make the one cluster up and
> visible while the other is not visible [1].
> 
> 
> [1] www.arm.com/files/downloads/big.LITTLE_Final.pdf

Yeah.  So for that use case I'd just add a secondary_states pointer to
struct cpuidle_driver containing the address of an array of states for
"secondary" CPU cores.  It probably would need its own counterparts of
state_count and safe_state_index.

Next, I'd add a "secondary" flag to struct cpuidle_device which, when set,
would indicate that for this particular CPU the core should use the states
from the "secondary_states" array.

However, for the use case in which all cores are normally visible to the
scheduler, I'd just go for making it possible to use more than one cpuidle
driver at a time.

We do that for all other kinds of devices already.  Consider Ethernet, for
one example.  There is no reason to have a single Ethernet driver trying to
handle all of the adapters in the system, if they are different.  If they
are identical, then yes, one driver should handle all of them, but if they
are different, we use different drivers.

I don't see why CPU cores should be treated in any special way in that respect
(except for the "bL switcher" use case with is kind of unusual).

Thanks,
Rafael
