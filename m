From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RESEND PATCH v4 0/5] acpi, clocksource: add GTDT and ARM
 memory-mapped timer support
Date: Fri, 18 Mar 2016 14:37:41 +0100
Message-ID: <56EC04A5.2030106@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36271 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933069AbcCRNhq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 09:37:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id l124so31503884wmf.1
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2016 06:37:45 -0700 (PDT)
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

On 03/18/2016 09:00 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>      (1)Move some enums and marcos to header file for arm_arch_timer,
>      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_time=
r.c
>
>      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>      memory-mapped timer and SBSA Generic Watchdog timer.
>      This driver can help to simplify all the relevant timer drivers,
>      and separate all the ACPI GTDT knowledge from them.
>
>      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>      (4)Add memory-mapped timer support in arm_arch_timer.c
>
> RESEND:
>     -- Corrected Cc list: added missing mailing lists

Hi Fu Wei,

the whole series is lacking to encapsulate the ACPI code.

I believe Marc Zyngier did a first effort to make the ACPI self=20
contained and this series ignore that.

Please rework the series in the direction no acpi gtdt structure appear=
s=20
in the driver.

Thanks

   -- Daniel



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
