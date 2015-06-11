From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 06/11] ACPI / gsi: Add gsi_mutex to synchronize acpi_register_gsi()/acpi_unregister_gsi()
Date: Thu, 11 Jun 2015 21:16:24 +0800
Message-ID: <55798A28.3080000@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-7-git-send-email-hanjun.guo@linaro.org> <55785E8D.1000909@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36821 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbFKNQr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 09:16:47 -0400
Received: by pabqy3 with SMTP id qy3so3951370pab.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2015 06:16:46 -0700 (PDT)
In-Reply-To: <55785E8D.1000909@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 06/10/2015 11:58 PM, Marc Zyngier wrote:
> On 18/05/15 13:59, Hanjun Guo wrote:
>> Add a mutex for acpi_register_gsi()/acpi_unregister_gsi() to avoid
>> concurrency issues.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/gsi.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
>> index 55b5f31..ab0dcb4 100644
>> --- a/drivers/acpi/gsi.c
>> +++ b/drivers/acpi/gsi.c
>> @@ -16,6 +16,7 @@
>>   enum acpi_irq_model_id acpi_irq_model;
>>   /* ACPI core domian pointing to GICv2/3 core domain */
>>   struct irq_domain *acpi_irq_domain __read_mostly;
>> +static DEFINE_MUTEX(gsi_mutex);
>>
>>   static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>>   {
>> @@ -73,20 +74,24 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>>   	int irq;
>>   	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
>>
>> +	mutex_lock(&gsi_mutex);
>>   	irq = irq_find_mapping(acpi_irq_domain, gsi);
>>   	if (irq > 0)
>> -		return irq;
>> +		goto out;
>>
>>   	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
>>   				    &gsi);
>>   	if (irq <= 0)
>> -		return -EINVAL;
>> +		goto out;
>>
>>   	/* Set irq type if specified and different than the current one */
>>   	if (irq_type != IRQ_TYPE_NONE &&
>>   		irq_type != irq_get_trigger_type(irq))
>>   		irq_set_irq_type(irq, irq_type);
>> -	return irq;
>> +
>> +out:
>> +	mutex_unlock(&gsi_mutex);
>> +	return irq > 0 ? irq : -EINVAL;
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_register_gsi);
>>
>> @@ -96,8 +101,12 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>>    */
>>   void acpi_unregister_gsi(u32 gsi)
>>   {
>> -	int irq = irq_find_mapping(acpi_irq_domain, gsi);
>> +	int irq;
>> +
>> +	mutex_lock(&gsi_mutex);
>> +	irq = irq_find_mapping(acpi_irq_domain, gsi);
>>
>>   	irq_dispose_mapping(irq);
>> +	mutex_unlock(&gsi_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>>
>
> Can you point out why we need this locking? The rest of the kernel seems
> to live without it pretty well. And if we really have an issue, I'd

Hmm, I'm not so sure, I will look deep into that and come back later.

> prefer seeing it fixed in the core code rather than in something that is
> very much firmware-specific.

I agree if there are real issues.

Thanks
Hanjun
