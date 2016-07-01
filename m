From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Fri, 1 Jul 2016 16:00:34 +0200
Message-ID: <57767782.6020509@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <5351858.jEb0qfTvrF@vostro.rjw.lan>
 <2f0e60e1-f429-2bd3-5f26-fd6199e64f34@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36415 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcGAOAh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 10:00:37 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so27880778wma.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jul 2016 07:00:36 -0700 (PDT)
In-Reply-To: <2435381.sM3CFAEXNR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Fu Wei <fu.wei@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Leo

On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:

[ ... ]

>> GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
>> ACPI spec, I think it can stay in drivers/acpi/ from this point
>> of view, am I right?
>
> The question is not "Can it?", but "Does it need to?".
>
> It is in the spec, but still there's only one architecture needing it=
=2E
>
> There is no way to test it on any other architecture and no reason to=
 build it
> for any other architecture, so why does it need to be located in driv=
ers/acpi/ ?

Hi Rafael,

what is the problem of having it in drivers/acpi ?

There are cpufreq-dt, speedstep*, tegra124-* in drivers/cpufreq.

clocksource-probe which is DT based with different drivers using it in=20
drivers/clocksource with a pletore of different archs.

Cstate code which is only used by x86 is in drivers/acpi, it is only=20
used by x86/ia64 and it isn't a problem. There is a small chunk in=20
arch/x86/kernel/acpi and it doesn't facilitate the comprehension of the=
=20
code.

IMHO, having all ACPI code in the same directory will encourage the=20
consolidation.



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
