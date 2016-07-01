From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT support in arm_arch_timer
Date: Fri, 01 Jul 2016 23:01:57 +0200
Message-ID: <1643662.QIDsTbCMZg@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org> <2435381.sM3CFAEXNR@vostro.rjw.lan> <57767782.6020509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63177 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751911AbcGAU51 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 16:57:27 -0400
In-Reply-To: <57767782.6020509@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Fu Wei <fu.wei@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Suravee Suthikulanit <Surave>

On Friday, July 01, 2016 04:00:34 PM Daniel Lezcano wrote:
> On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:
> 
> [ ... ]
> 
> >> GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> >> ACPI spec, I think it can stay in drivers/acpi/ from this point
> >> of view, am I right?
> >
> > The question is not "Can it?", but "Does it need to?".
> >
> > It is in the spec, but still there's only one architecture needing it.
> >
> > There is no way to test it on any other architecture and no reason to build it
> > for any other architecture, so why does it need to be located in drivers/acpi/ ?
> 
> Hi Rafael,
> 
> what is the problem of having it in drivers/acpi ?

There's no reason for it to be there.

> There are cpufreq-dt, speedstep*, tegra124-* in drivers/cpufreq.

Yes, they are, but for a reason.  Having them in there makes it easier to
rework and clean up the core.

> clocksource-probe which is DT based with different drivers using it in 
> drivers/clocksource with a pletore of different archs.

So maybe the GTDT code should be there too?

> Cstate code which is only used by x86 is in drivers/acpi, it is only 
> used by x86/ia64 and it isn't a problem.

It is a problem.  drivers/acpi/ is not the right place for arch-specific code.

> There is a small chunk in arch/x86/kernel/acpi and it doesn't facilitate the
> comprehension of the code.
> 
> IMHO, having all ACPI code in the same directory will encourage the 
> consolidation.

The consolidation of what exactly?

In particular, how does the GTDT code in drivers/acpi/ help to consolidate
anything?

Thanks,
Rafael

