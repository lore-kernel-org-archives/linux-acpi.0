From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Tue, 18 Sep 2012 23:10:57 +0200
Message-ID: <201209182310.57276.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <50579784.4090000@linaro.org> <20120918095212.GA23259@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60643 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186Ab2IRVEb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 17:04:31 -0400
In-Reply-To: <20120918095212.GA23259@e102568-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "len.brown@intel.com >> Len Brown" <len.brown@intel.com>

On Tuesday, September 18, 2012, Lorenzo Pieralisi wrote:
> On Mon, Sep 17, 2012 at 10:35:00PM +0100, Daniel Lezcano wrote:
> > On 09/17/2012 10:50 PM, Rafael J. Wysocki wrote:
> > > On Monday, September 17, 2012, Daniel Lezcano wrote:
> > >> On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
> > >>> On Friday, September 07, 2012, Daniel Lezcano wrote:
> 
> [...]
> 
> > >>> Unfortunately, I also don't agree with the approach used by the remaining
> > >>> patches, which is to try to use a separate array of states for each
> > >>> individual CPU core.  This way we end up with quite some duplicated data
> > >>> if the CPU cores in question actually happen to be identical.
> > >>
> > >> Actually, there is a single array of states which is defined with the
> > >> cpuidle_driver. A pointer to this array from the cpuidle_device
> > >> structure is added and used from the cpuidle core.
> > >>
> > >> If the cpu cores are identical, this pointer will refer to the same array.
> > > 
> > > OK, but what if there are two (or more) sets of cores, where all cores in one
> > > set are identical, but two cores from different sets differ?
> > 
> > A second array is defined and registered for these cores with the
> > cpuidle_register_states function.
> > 
> > Let's pick an example with the big.LITTLE architecture.
> > 
> > There are two A7 and two A15, resulting in the code on 4 cpuidle_device
> > structure (eg. dev_A7_1, dev_A7_2, dev_A15_1, dev_A15_2). Then the
> > driver registers a different cpu states array for the A7s and the A15s
> > 
> > At the end,
> > 
> > dev_A7_1->states points to the array states 1
> > dev_A7_2->states points to the array states 1
> > 
> > dev_A15_1->states points to the array states 2
> > dev_A15_2->states points to the array states 2
> > 
> > It is similar with Tegra3.
> > 
> > I think Peter and Lorenzo already wrote a driver based on this approach.
> > Peter, Lorenzo any comments ?
> 
> Well, I guess the question is about *where* the array of states should
> belong. With the current approach we end up having an array of states
> in the cpuidle_driver, but also array(s) of states in platform code and we
> override the newly added pointer in cpuidle_device to point to those
> array(s) for CPUs whose idle states differ from the ones registered (and
> copied) in the driver.
> 
> Data is NOT duplicated but now I understand Rafael's remark.
> 
> If we have a driver per-[set of cpus] (that is impossible with the
> current framework as you higlighted) code would be cleaner since
> all idle states data would live in cpuidle_driver(s), not possibly in
> platform code. Then the problem becomes: what cpuidle_driver should be
> used and how to choose that at run-time within the governors.

For that to work, the cpuidle core would have to be modified so that it didn't
make the "there may be only on driver in the system" assumption and there would
have to be a way to associate the given CPU core with the matching driver.

Thanks,
Rafael
