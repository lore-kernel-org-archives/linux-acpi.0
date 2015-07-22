From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
Date: Wed, 22 Jul 2015 08:52:26 +0100
Message-ID: <55AF4BBA.5030209@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com> <1437473280-11431-2-git-send-email-marc.zyngier@arm.com> <55AF47D7.8010304@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34636 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbbGVHwa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jul 2015 03:52:30 -0400
In-Reply-To: <55AF47D7.8010304@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>

On 22/07/15 08:35, Hanjun Guo wrote:
> On 07/21/2015 06:07 PM, Marc Zyngier wrote:
>> The struct irq_domain contains a "struct device_node *" field
>> (of_node) that is almost the only link between the irqdomain
>> and the device tree infrastructure.
>>
>> In order to prepare for the removal of that field, convert all
>> users outside of kernel/irq/irqdomain.c to use an accessor.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
>>   arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
>>   arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
>>   arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
>>   arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
>>   arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
>>   arch/powerpc/sysdev/i8259.c                   | 3 ++-
>>   arch/powerpc/sysdev/ipic.c                    | 3 ++-
>>   arch/powerpc/sysdev/mpic.c                    | 3 ++-
>>   arch/powerpc/sysdev/mpic_msi.c                | 2 +-
>>   arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-
>>   drivers/gpio/gpio-sodaville.c                 | 2 +-
>>   drivers/irqchip/exynos-combiner.c             | 2 +-
>>   drivers/irqchip/irq-atmel-aic-common.c        | 2 +-
>>   drivers/irqchip/irq-crossbar.c                | 4 ++--
>>   drivers/irqchip/irq-gic-v2m.c                 | 2 +-
>>   drivers/irqchip/irq-gic-v3-its.c              | 2 +-
>>   drivers/irqchip/irq-gic-v3.c                  | 2 +-
>>   drivers/irqchip/irq-gic.c                     | 2 +-
>>   drivers/irqchip/irq-hip04.c                   | 2 +-
>>   drivers/irqchip/irq-mtk-sysirq.c              | 2 +-
>>   drivers/irqchip/irq-s3c24xx.c                 | 4 ++--
>>   drivers/irqchip/irq-tegra.c                   | 4 ++--
>>   drivers/irqchip/irq-vf610-mscm-ir.c           | 5 +++--
>>   drivers/spmi/spmi-pmic-arb.c                  | 2 +-
>>   include/linux/irqdomain.h                     | 5 +++++
>>   26 files changed, 46 insertions(+), 32 deletions(-)
> 
> It seems to me that some other files missed,
> in arch/powerpc/platforms/pasemi/msi.c:
> 
>          if (!mpic->irqhost->of_node ||
>              !of_device_is_compatible(mpic->irqhost->of_node,
>                                       "pasemi,pwrficient-openpic"))
>                  return -ENODEV;
> 
> If you need more eyes to find all of them, please count me in :)

Looks like my coccinelle foo is still lacking a bit... Oh well.

Thanks for the help!

	M.
-- 
Jazz is not dead. It just smells funny...
