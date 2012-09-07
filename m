From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Sat, 8 Sep 2012 00:17:17 +0200
Message-ID: <201209080017.17418.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42989 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab2IGWK6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 18:10:58 -0400
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Friday, September 07, 2012, Daniel Lezcano wrote:
> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
>         cpuidle: Single/Global registration of idle states
> 
> we have a single registration for the cpuidle states which makes
> sense. But now two new architectures are coming: tegra3 and big.LITTLE.
> 
> These architectures have different cpus with different caracteristics
> for power saving. High load => powerfull processors, idle => small processors.
> 
> That implies different cpu latencies.
> 
> This patchset keeps the current behavior as introduced by Deepthi without
> breaking the drivers and add the possibility to specify a per cpu states.
> 
>  * Tested on intel core 2 duo T9500
>  * Tested on vexpress by Lorenzo Pieralsi
>  * Tested on tegra3 by Peter De Schrijver
> 
> Daniel Lezcano (6):
>   acpi : move the acpi_idle_driver variable declaration
>   acpi : move cpuidle_device field out of the acpi_processor_power
>     structure
>   acpi : remove pointless cpuidle device state_count init

I've posted comments about patches [1-3/6] already.  In short, I don't like
[1/6], [2/6] would require some more work IMO and I'm not sure about the
validity of the observation that [3/6] is based on.

Yes, I agree that the ACPI processor driver as a whole might be cleaner
and it probably would be good to spend some time on cleaning it up, but
not necessarily in a hurry.

Unfortunately, I also don't agree with the approach used by the remaining
patches, which is to try to use a separate array of states for each
individual CPU core.  This way we end up with quite some duplicated data
if the CPU cores in question actually happen to be identical.

What about using a separate cpuidle driver for every kind of different CPUs in
the system (e.g. one driver for "big" CPUs and the other for "little" ones)?

Have you considered this approach already?

>   cpuidle : add a pointer for cpuidle_state in the cpuidle_device
>   cpuidle : use per cpuidle device cpu states
>   cpuidle : add cpuidle_register_states function
> 
>  drivers/acpi/processor_driver.c    |    2 +-
>  drivers/acpi/processor_idle.c      |   27 +++++++++++++++-------
>  drivers/cpuidle/cpuidle.c          |   42 ++++++++++++++++++++++++++++-------
>  drivers/cpuidle/governors/ladder.c |   22 +++++++++---------
>  drivers/cpuidle/governors/menu.c   |    8 +++---
>  drivers/cpuidle/sysfs.c            |    3 +-
>  include/acpi/processor.h           |    3 --
>  include/linux/cpuidle.h            |   11 ++++++--
>  8 files changed, 76 insertions(+), 42 deletions(-)

Thanks,
Rafael
