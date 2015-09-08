From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 0/5] ACPI probing infrastructure
Date: Tue, 8 Sep 2015 16:38:50 +0200
Message-ID: <55EEF2FA.3050009@semihalf.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
 <55ED3599.5090508@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36443 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbbIHOiz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2015 10:38:55 -0400
Received: by lanb10 with SMTP id b10so70122789lan.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2015 07:38:54 -0700 (PDT)
In-Reply-To: <55ED3599.5090508@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07.09.2015 08:58, Tomasz Nowicki wrote:
> Hi Marc,
>
> On 04.09.2015 19:06, Marc Zyngier wrote:
>> IRQ controllers and timers are the two types of device the kernel
>> requires before being able to use the device driver model.
>>
>> ACPI so far lacks a proper probing infrastructure similar to the one
>> we have with DT, where we're able to declare IRQ chips and
>> clocksources inside the driver code, and let the core code pick it up
>> and call us back on a match. This leads to all kind of really ugly
>> hacks all over the arm64 code and even in the ACPI layer.
>>
>> It turns out that providing such a probing infrastructure is rather
>> easy, and provides a much deserved cleanup in both the arch code, the
>> GIC driver, and the architected timer driver.
>>
>> I'm sure there is some more code to be deleted, and one can only
>> wonder why this wasn't done before the arm64 code was initially merged
>> (the diffstat says it all...).
>>
>> Patches are against v4.2, and a branch is available at
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>> acpi/device-probing
>>
>> Marc Zyngier (5):
>>    acpi: Add basic device probing infrastructure
>>    irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
>>    irqchip/gic: Convert the GIC driver to ACPI probing
>>    clocksource/acpi: Add probing infrastructure for ACPI-based
>>      clocksources
>>    clocksource/arm_arch_timer: Convert to ACPI probing
>>
>>   arch/arm64/include/asm/acpi.h        |  1 -
>>   arch/arm64/include/asm/irq.h         | 13 -------
>>   arch/arm64/kernel/acpi.c             | 25 -------------
>>   arch/arm64/kernel/time.c             |  6 ----
>>   drivers/acpi/scan.c                  | 41 +++++++++++++++++++++
>>   drivers/clocksource/arm_arch_timer.c | 10 +-----
>>   drivers/clocksource/clksrc-of.c      |  4 +++
>>   drivers/irqchip/irq-gic.c            | 69
>> ++++++++++++++++++------------------
>>   drivers/irqchip/irqchip.c            |  5 ++-
>>   include/asm-generic/vmlinux.lds.h    | 11 ++++++
>>   include/linux/acpi.h                 | 56 +++++++++++++++++++++++++++++
>>   include/linux/acpi_irq.h             | 10 ------
>>   include/linux/clocksource.h          |  6 ----
>>   include/linux/irqchip.h              | 16 +++++++++
>>   include/linux/irqchip/arm-gic-acpi.h | 31 ----------------
>>   15 files changed, 166 insertions(+), 138 deletions(-)
>>   delete mode 100644 include/linux/acpi_irq.h
>>   delete mode 100644 include/linux/irqchip/arm-gic-acpi.h
>>
>
> Thanks for cleaning this up!
>
> For the whole series:
> Acked-by: Tomasz Nowicki <tn@semihalf.com>

s/Acked-by/Reviewed-by

Tomasz
