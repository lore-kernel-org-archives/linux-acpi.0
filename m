From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/3] ACPI, clocksource: add GTDT and ARM memory-mapped
 timer support
Date: Wed, 16 Dec 2015 17:32:01 +0100
Message-ID: <56719201.2020801@linaro.org>
References: <1449034984-12075-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35389 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592AbbLPQb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2015 11:31:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so46544035wml.0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Dec 2015 08:31:59 -0800 (PST)
In-Reply-To: <1449034984-12075-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, hanjun.guo@linaro.org, davem@davemloft.net, jeffrey.t.kirsher@intel.com, richardcochran@gmail.com
Cc: arnd@arndb.de, wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, robherring2@gmail.com, Marc Zyngier <Marc.Zyngier@arm.com>


Marc,

can you have a look ?

Thanks

   -- Daniel

On 12/02/2015 06:43 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>      (1)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>      memory-mapped timer and SBSA Generic Watchdog timer.
>      This driver can help to simplify all the relevant timer drivers,
>      and separate all the ACPI GTDT knowledge from them.
>
>      (2)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>      (3)Add memory-mapped timer support in arm_arch_timer.c
>
> The SBSA Generic Watchdog info parsing support have been tested with
> a upstreaming SBSA Generic Watchdog driver:
> https://lkml.org/lkml/2015/10/27/466
> on the following platforms:
>      (1)ARM Foundation v8 model
>      (2)AMD Seattle platform
>
> ARM memory-mapped timer support of this patchset has been tested
> on the following platforms:
>      (1)ARM Foundation v8 model
>
> Changelog:
> v2: Rebase to latest kernel version(4.4-rc3).
>      Fix the bug about the config problem,
>      use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c
>
> v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/5=
53
>
> Fu Wei (3):
>    ACPI: add GTDT table parse driver into ACPI driver
>    clocksource: simplify ACPI code in arm_arch_timer.c
>    clocksource: add memory-mapped timer support in arm_arch_timer.c
>
>   drivers/acpi/Kconfig                 |   9 +
>   drivers/acpi/Makefile                |   1 +
>   drivers/acpi/gtdt.c                  | 367 ++++++++++++++++++++++++=
+++++++++++
>   drivers/clocksource/arm_arch_timer.c | 178 +++++++++++++----
>   include/clocksource/arm_arch_timer.h |  19 ++
>   include/linux/acpi.h                 |  17 ++
>   6 files changed, 555 insertions(+), 36 deletions(-)
>   create mode 100644 drivers/acpi/gtdt.c
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
