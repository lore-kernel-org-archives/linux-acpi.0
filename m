From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT support in arm_arch_timer
Date: Thu, 30 Jun 2016 15:27:39 +0200
Message-ID: <2435381.sM3CFAEXNR@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org> <5351858.jEb0qfTvrF@vostro.rjw.lan> <2f0e60e1-f429-2bd3-5f26-fd6199e64f34@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59608 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751987AbcF3NXL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jun 2016 09:23:11 -0400
In-Reply-To: <2f0e60e1-f429-2bd3-5f26-fd6199e64f34@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Fu Wei <fu.wei@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Suravee

On Thursday, June 30, 2016 10:10:02 AM Hanjun Guo wrote:
> Hi Rafael,
> 
> On 2016/6/30 9:37, Rafael J. Wysocki wrote:
> > On Thursday, June 30, 2016 09:29:59 AM Fu Wei wrote:
> >> Hi Rafael,
> >>
> >> On 30 June 2016 at 05:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>> On Wed, Jun 29, 2016 at 8:15 PM,  <fu.wei@linaro.org> wrote:
> >>>> From: Fu Wei <fu.wei@linaro.org>
> >>>>
> >>>> This patchset:
> >>>>     (1)Preparation for adding GTDT support in arm_arch_timer
> >>>>         1. Move some enums and marcos to header file
> >>>>         2. Add a new enum for spi type.
> >>>>         3. Improve printk relevant code
> >>>>
> >>>>     (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
> >>>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
> >>>>     memory-mapped timer and SBSA Generic Watchdog timer.
> >>>>     This driver can help to simplify all the relevant timer drivers,
> >>>>     and separate all the ACPI GTDT knowledge from them.
> >>>>
> >>>>     (3)Simplify ACPI code for arm_arch_timer
> >>>>
> >>>>     (4)Add GTDT support for ARM memory-mapped timer
> >>>
> >>> GTDT is ARM-specific AFAICS.
> >>
> >> yes, you are right, it is.
> >>
> >>>
> >>> If so, why do we need that code to reside in drivers/acpi/ ?
> >>
> >> Although  the GTDT is just for ARM64, but this driver is parsing one
> >> of ACPI table,
> >> I think that could be treated as ACPI driver.  Do I miss something? :-)
> >
> > Yes, you are.  Nobody except for ARM64 will ever need it.
> 
> GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> ACPI spec, I think it can stay in drivers/acpi/ from this point
> of view, am I right?

The question is not "Can it?", but "Does it need to?".

It is in the spec, but still there's only one architecture needing it.

There is no way to test it on any other architecture and no reason to build it
for any other architecture, so why does it need to be located in drivers/acpi/ ?

Thanks,
Rafael

