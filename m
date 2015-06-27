From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 6/9] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
Date: Sat, 27 Jun 2015 11:52:14 +0800
Message-ID: <558E1DEE.3090900@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org> <1434703572-26221-7-git-send-email-hanjun.guo@linaro.org> <20150622172014.GB26129@red-moon> <5589772A.8070708@linaro.org> <20150623173845.GC31466@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36164 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbbF0DwX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2015 23:52:23 -0400
Received: by paceq1 with SMTP id eq1so77522662pac.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2015 20:52:23 -0700 (PDT)
In-Reply-To: <20150623173845.GC31466@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Wei Huang <wei@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 06/24/2015 01:38 AM, Lorenzo Pieralisi wrote:
> On Tue, Jun 23, 2015 at 04:11:38PM +0100, Hanjun Guo wrote:
>
> [...]
>
>>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>>> index 8fc67bc..d1b2131 100644
>>>> --- a/drivers/irqchip/irq-gic.c
>>>> +++ b/drivers/irqchip/irq-gic.c
>>>> @@ -851,15 +851,22 @@ static struct notifier_block gic_cpu_notifier = {
>>>>    static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>>    				unsigned int nr_irqs, void *arg)
>>>>    {
>>>> -	int i, ret;
>>>> +	int i;
>>>>    	irq_hw_number_t hwirq;
>>>> -	unsigned int type = IRQ_TYPE_NONE;
>>>> -	struct of_phandle_args *irq_data = arg;
>>>>
>>>> -	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
>>>> -				   irq_data->args_count, &hwirq, &type);
>>>> -	if (ret)
>>>> -		return ret;
>>>> +	if (domain->of_node) {	/* DT case */
>>>> +		int ret;
>>>> +		unsigned int type = IRQ_TYPE_NONE;
>>>> +		struct of_phandle_args *irq_data = arg;
>>>> +
>>>> +		ret = gic_irq_domain_xlate(domain, irq_data->np,
>>>> +					irq_data->args,
>>>> +					irq_data->args_count, &hwirq, &type);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	} else {	/* ACPI case */
>>>> +		hwirq = (irq_hw_number_t)*(u32 *)arg;
>>>> +	}
>>>
>>> If domain->of_node is NULL and system booted with DT the code above
>>> does not fail (and if it fails almost certainly that won't be graceful)
>>> but it should.
>>
>> how about the following logic?
>>
>> if (!domain->of_node && acpi_disabled)
>> 	return -ENODEV;
>> else if (domain->of_node)
>> 	dt related code;
>> else
>> 	ACPI related code;
>
> Code is not checking the node at present so:
>
> if (acpi_disabled)
> 	dt code;
> else
> 	ACPI code;
>
> would do, but that's a nit.
>
>>>>    	for (i = 0; i < nr_irqs; i++)
>>>>    		gic_irq_domain_map(domain, virq + i, hwirq + i);
>>>> @@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>    		gic_irqs = 1020;
>>>>    	gic->gic_irqs = gic_irqs;
>>>>
>>>> -	if (node) {		/* DT case */
>>>> +	if (node || !acpi_disabled) {		/* DT or ACPI case */
>>>>    		gic->domain = irq_domain_add_linear(node, gic_irqs,
>>>>    						    &gic_irq_domain_hierarchy_ops,
>>>>    						    gic);
>
> I think this is a bit more worrying, I mean passing a NULL node pointer to
> the irqdomain layer which basically means you are booting out of ACPI

I'm little confused here, would you mind explaining more for your
worrying? To me, node pointer is optional and it's ok for ACPI
case.

> (for you, if that's true for the irq_domain_add_linear implementation
> that's another story), the node pointer should be optional but you
> need feedback from IRQ layer maintainers here.

Sure.

Thanks
Hanjun
