From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFCv2 PATCH 1/8] irqdomain: Introduce
 irq_domain_ops.init_alloc_info
Date: Thu, 23 Jul 2015 13:50:42 +0700
Message-ID: <55B08EC2.4000204@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1436778864-17645-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <alpine.DEB.2.11.1507202326450.18576@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0125.outbound.protection.outlook.com ([65.55.169.125]:52112
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750859AbbGWHGY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 03:06:24 -0400
In-Reply-To: <alpine.DEB.2.11.1507202326450.18576@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, rjw@rjwysocki.net, al.stone@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, msalter@redhat.com, grant.likely@linaro.org, leo.duran@amd.com, sherry.hurwitz@amd.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



On 7/21/15 04:28, Thomas Gleixner wrote:
> On Mon, 13 Jul 2015, Suravee Suthikulpanit wrote:
>
>> Currently, when calling irq_domain_alloc_irqs() on ARM64, it uses
>> struct of_phandle_args to pass irq information. However, this is not
>> appropriate for ACPI since of_phandle_args is specific to DT.
>>
>> Therefore, this patch introduces a new function pointer,
>> irq_domain_ops.init_alloc_info, which can be used by irqchips to provide
>> a way to initialize irqchip-specific data-structure for allocating IRQ.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>> NOTE:
>> Similarly, x86 is currently using struct irq_alloc_info
>> (see arch/x86/include/asm/hw_irq.h) and each irq_domain has different
>> way of initializing this structure.
>
> And why don't you use the same mechanism on ARM and have a private
> irq_alloc_info implementation which can carry either DT or ACPI
> information?

Let me look further into this. I would like to take a similar approach here.

Suravee

> Thanks,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
