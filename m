From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 1/7] genirq: irqdomain: Use an accessor for the of_node
 field
Date: Fri, 24 Jul 2015 18:06:39 +0100
Message-ID: <55B2709F.4080707@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com> <1437656713-9677-2-git-send-email-marc.zyngier@arm.com> <55B1FD45.4060706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46318 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566AbbGXRGo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Jul 2015 13:06:44 -0400
In-Reply-To: <55B1FD45.4060706@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>

On 24/07/15 09:54, Hanjun Guo wrote:
> On 07/23/2015 09:05 PM, Marc Zyngier wrote:
>> The struct irq_domain contains a "struct device_node *" field
>> (of_node) that is almost the only link between the irqdomain
>> and the device tree infrastructure.
>>
>> In order to prepare for the removal of that field, convert all
>> users outside of kernel/irq/irqdomain.c to use an accessor.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   arch/c6x/platforms/megamod-pic.c              | 2 +-
>>   arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
>>   arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
>>   arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
>>   arch/powerpc/platforms/pasemi/msi.c           | 6 ++++--
>>   arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
>>   arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
>>   arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
>>   arch/powerpc/sysdev/i8259.c                   | 3 ++-
>>   arch/powerpc/sysdev/ipic.c                    | 3 ++-
>>   arch/powerpc/sysdev/mpic.c                    | 3 ++-
>>   arch/powerpc/sysdev/mpic_msi.c                | 2 +-
>>   arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-
> 
> Hmm, no arch/arm/, and there are several domain->of_node
> or similar in those files, or did I miss something?

No, I was missing some more -I on my spatch command line... I pushed out
a fixup.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
