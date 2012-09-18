From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Tue, 18 Sep 2012 10:52:13 +0100
Message-ID: <20120918095212.GA23259@e102568-lin.cambridge.arm.com>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
 <201209080017.17418.rjw@sisk.pl>
 <5056D96C.5040904@linaro.org>
 <201209172250.33157.rjw@sisk.pl>
 <50579784.4090000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35318 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab2IRJwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Sep 2012 05:52:20 -0400
In-Reply-To: <50579784.4090000@linaro.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "len.brown@intel.com >> Len Brown" <len.brown@intel.com>

On Mon, Sep 17, 2012 at 10:35:00PM +0100, Daniel Lezcano wrote:
> On 09/17/2012 10:50 PM, Rafael J. Wysocki wrote:
> > On Monday, September 17, 2012, Daniel Lezcano wrote:
> >> On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
> >>> On Friday, September 07, 2012, Daniel Lezcano wrote:

[...]

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

Well, I guess the question is about *where* the array of states should
belong. With the current approach we end up having an array of states
in the cpuidle_driver, but also array(s) of states in platform code and we
override the newly added pointer in cpuidle_device to point to those
array(s) for CPUs whose idle states differ from the ones registered (and
copied) in the driver.

Data is NOT duplicated but now I understand Rafael's remark.

If we have a driver per-[set of cpus] (that is impossible with the
current framework as you higlighted) code would be cleaner since
all idle states data would live in cpuidle_driver(s), not possibly in
platform code. Then the problem becomes: what cpuidle_driver should be
used and how to choose that at run-time within the governors.

> 
> The single registration mechanism introduced by Deepthi is kept and we
> have a way to specify different idle states for different cpus.
> 
> > In that case it would be good to have one array of states per set, but the
> > patch doesn't seem to do that, does it?
> 
> Yes, this is what does the patch.

The patch adds a pointer to idle states in cpuidle_device, the platform driver
defines the array(s).

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
> Sorry, I did not suggest that. I am wondering how several cpuidle
> drivers can co-exist together in the state of the code. Maybe I
> misunderstood your idea.
> 
> The patchset I sent is pretty simple and do not duplicate the array states.
> 
> That would be nice if Len could react to this patchset (4/6,5/6, and
> 6/6). Cc'ing him to its intel address.

As the idle infrastructure stands I do not see how multiple cpuidle drivers
can co-exist, that's the problem, and Daniel already mentioned that.

Lorenzo

