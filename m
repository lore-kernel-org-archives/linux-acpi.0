From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI
 MADT
Date: Thu, 21 May 2015 22:19:54 +0800
Message-ID: <555DE98A.2000909@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org> <alpine.DEB.2.11.1505202157190.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33942 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbbEUOUA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 10:20:00 -0400
Received: by pabru16 with SMTP id ru16so106943421pab.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2015 07:20:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1505202157190.4225@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 04:02, Thomas Gleixner wrote:
> On Mon, 18 May 2015, Hanjun Guo wrote:
>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>> index 65d6b93..855ead9 100644
>> --- a/drivers/acpi/irq.c
>> +++ b/drivers/acpi/irq.c
>> @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
>>   	if (acpi_disabled)
>>   		return;
>>
>> +	if (acpi_gic_version_init())
>> +		return;
>
> This looks just wrong. acpi_irqchip_init() is a generic ACPI function
> and now you stick a GIC specific callback into it?

=46or now, acpi_irqchip_init() just introduced for GIC init, not for
APIC init for x86, and I don't see the usage in the near future.

>
> What calls acpi_irqchip_init?

I renamed it as acpi_irq_init() in the later patch, which
is called in irqchip_init() in drivers/irqchip/irqchip.c
to init irqchip when DT is not available.

This is not a nice way, but the kernel should stay functional
for each patch goes in, so I separate the patch to smaller one
for easy review under that rule, does it make sense?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
