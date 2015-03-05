From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v9 16/21] irqchip: Add GICv2 specific ACPI boot support
Date: Thu, 5 Mar 2015 17:06:34 +0800
Message-ID: <54F81C9A.6040502@huawei.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-17-git-send-email-hanjun.guo@linaro.org> <5921774.hkUTDjxi3A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:38487 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbCEJHE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 04:07:04 -0500
In-Reply-To: <5921774.hkUTDjxi3A@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>

On 2015/3/5 6:50, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 04:39:56 PM Hanjun Guo wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> ACPI kernel uses MADT table for proper GIC initialization. It needs to
>> parse GIC related subtables, collect CPU interface and distributor
>> addresses and call driver initialization function (which is hardware
>> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>>
>> NOTE: This commit allow to initialize GICv1/2 basic functionality.
>> While now simple GICv2 init call is used, any further GIC features
>> require generic infrastructure for proper ACPI irqchip initialization.
>> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
>> extension, GICv3/4 and its ITS are considered as next steps.
[...]
>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>> index 0fe2f71..5855240 100644
>> --- a/drivers/irqchip/irqchip.c
>> +++ b/drivers/irqchip/irqchip.c
>> @@ -8,6 +8,7 @@
>>   * warranty of any kind, whether express or implied.
>>   */
>>  
>> +#include <linux/acpi.h>
>>  #include <linux/init.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/irqchip.h>
>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
>>  void __init irqchip_init(void)
>>  {
>>  	of_irq_init(__irqchip_of_table);
>> +
>> +	acpi_irq_init();
>>  }
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index c03d8d1..e27117a 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -557,6 +557,20 @@ static inline int acpi_device_modalias(struct device *dev,
>>  
>>  #endif	/* !CONFIG_ACPI */
>>  
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
>> +static inline void acpi_irq_init(void)
>> +{
>> +	/*
>> +	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
>> +	 * Proper irqchip infrastructure will be implemented along with
>> +	 * incoming  GICv2m|GICv3|ITS bits.
>> +	 */
>> +	acpi_gic_init();
>> +}
>> +#else
>> +static inline void acpi_irq_init(void) { }
>> +#endif
> I don't want this in a common header.

This is because of irqchip_init(void) in drivers/irqchip/irqchip.c
will be called by PowerPC too, so we need to put it in a common
head file, I will discuss with Tomasz to see if we have any further
solution.

Thanks
Hanjun

