From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Fri, 7 Sep 2012 16:34:30 +0530
Message-ID: <CAP245DXTdw4MxcHOS2EUgvaQv6RnH0NWvks3RhE8ORR1Zx7qbw@mail.gmail.com>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46400 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2IGLEb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 07:04:31 -0400
Received: by vbbff1 with SMTP id ff1so3039740vbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 04:04:30 -0700 (PDT)
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Sep 7, 2012 at 3:49 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
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

Feel free to add my Reviewed-by for this series.

/Amit
