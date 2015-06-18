From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 05/11] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
Date: Fri, 19 Jun 2015 07:25:33 +0800
Message-ID: <5583536D.80205@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-6-git-send-email-hanjun.guo@linaro.org> <55786556.1020404@arm.com> <55798B9D.5050409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34675 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbFRXZl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 19:25:41 -0400
Received: by pabvl15 with SMTP id vl15so25002549pab.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jun 2015 16:25:41 -0700 (PDT)
In-Reply-To: <55798B9D.5050409@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 06/11/2015 09:22 PM, Hanjun Guo wrote:
> On 06/11/2015 12:27 AM, Marc Zyngier wrote:
>> On 18/05/15 13:59, Hanjun Guo wrote:
>>> Introduce acpi_irq_domain for GICv2 core domain instead of referring
>>> to the irq_default_domain, based on that, pass gsi as the argument and
>>> get the gsi in gic_irq_domain_alloc() to add stacked irqdomain support
>>> for ACPI based GICv2 init.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   drivers/acpi/gsi.c                   | 28 +++++++++++++---------------
>>>   drivers/irqchip/irq-gic.c            | 32
>>> +++++++++++++++++---------------
>>>   include/linux/irqchip/arm-gic-acpi.h |  2 ++
>>>   3 files changed, 32 insertions(+), 30 deletions(-)
>>>
[...]
>>>
>>>   enum acpi_irq_model_id acpi_irq_model;
>>> +/* ACPI core domian pointing to GICv2/3 core domain */
>>> +struct irq_domain *acpi_irq_domain __read_mostly;
>>
>> How is a single domain pointer going to work when you will have several
>> domains (GICv2m, ITS)?
>
> This acpi_irq_domain is the core domain which is the parent domain
> of GICv2m or ITS.
>
> acpi_irq_domain points to GICv2 or GICv3 domain when the GIC
> is initialized.
>
>> Crucially, how are you going to perform the
>> matching of a device with its irq domain?
>
> since every ITS will have a domain, and there is a mapping
> from device id to ITS ID in IORT table, then we can match the
> device with the ITS irq domain, does it make sense?

Sorry, I misunderstood the question here, I thought "its" here
means ITS (interrupt translation service), but actually I think
you mean how to match a device to the device's irq domain.

So the stacked irq domain will be:

     acpi_irq_domain == gicv2 or gicv3 core domain
                    ^
                    |   (parent)
                    |
        ITS domain or GIv2m domain
                    ^
                    |
                    |
            MSI chip irq domain

Since there is one GICD supported for now, so there will be only
one irqdomain created for all the wired hardware irqs for PPI, SGI
and SPI, and PPI, SGI and SPI will have unique hardware irq number
(GSI), so we can match the device to the acpi_irq_domain with unique
GSI and it will works. If there will be multi GICD in the future, this
will still works to follow the solution for x86 of ACPI (mutil IOAPICs).

MSI will match itself (device id) to its MSI irqdomain and it will
handled by core code (dynamicly allocated hw irq number), so all
the interrupts will be handled probably in ACPI way.

Thanks
Hanjun
