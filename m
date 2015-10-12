From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 01/16] irqdomain: Use an accessor for the of_node field
Date: Mon, 12 Oct 2015 14:04:28 +0800
Message-ID: <561B4D6C.7000404@linaro.org>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com> <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34930 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbJLGEh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 02:04:37 -0400
Received: by pabve7 with SMTP id ve7so86881315pab.2
        for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2015 23:04:37 -0700 (PDT)
In-Reply-To: <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>

On 10/07/2015 01:36 AM, Marc Zyngier wrote:
> The struct irq_domain contains a "struct device_node *" field
> (of_node) that is almost the only link between the irqdomain
> and the device tree infrastructure.
>
> In order to prepare for the removal of that field, convert all
> users to use an accessor.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/mach-omap2/omap-wakeupgen.c          |  2 +-
>   arch/c6x/platforms/megamod-pic.c              |  2 +-
>   arch/mips/cavium-octeon/octeon-irq.c          |  4 ++--
>   arch/powerpc/platforms/cell/axon_msi.c        |  2 +-
>   arch/powerpc/platforms/cell/spider-pic.c      |  9 +++++---
>   arch/powerpc/platforms/pasemi/msi.c           |  6 ++++--
>   arch/powerpc/platforms/powernv/opal-irqchip.c |  2 +-
>   arch/powerpc/sysdev/ehv_pic.c                 |  3 ++-
>   arch/powerpc/sysdev/fsl_msi.c                 |  2 +-
>   arch/powerpc/sysdev/i8259.c                   |  3 ++-
>   arch/powerpc/sysdev/ipic.c                    |  3 ++-
>   arch/powerpc/sysdev/mpic.c                    |  3 ++-
>   arch/powerpc/sysdev/mpic_msi.c                |  2 +-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c            |  3 ++-
>   drivers/gpio/gpio-sodaville.c                 |  2 +-
>   drivers/irqchip/exynos-combiner.c             |  2 +-
>   drivers/irqchip/irq-atmel-aic-common.c        |  2 +-
>   drivers/irqchip/irq-crossbar.c                |  4 ++--
>   drivers/irqchip/irq-gic-v2m.c                 |  2 +-
>   drivers/irqchip/irq-gic-v3-its.c              |  2 +-
>   drivers/irqchip/irq-gic-v3.c                  |  2 +-
>   drivers/irqchip/irq-gic.c                     |  2 +-
>   drivers/irqchip/irq-hip04.c                   |  2 +-
>   drivers/irqchip/irq-imx-gpcv2.c               |  2 +-
>   drivers/irqchip/irq-mtk-sysirq.c              |  2 +-
>   drivers/irqchip/irq-s3c24xx.c                 |  4 ++--
>   drivers/irqchip/irq-tegra.c                   |  4 ++--
>   drivers/irqchip/irq-vf610-mscm-ir.c           |  5 +++--
>   drivers/spmi/spmi-pmic-arb.c                  |  2 +-
>   include/linux/irqdomain.h                     |  5 +++++
>   kernel/irq/irqdomain.c                        | 30 +++++++++++++++++++--------
>   31 files changed, 74 insertions(+), 46 deletions(-)

Some missing files I noticed:
./arch/arm/mach-imx/gpc.c:	if (domain->of_node != controller)
./arch/arm/mach-imx/gpc.c:	parent_args.np = domain->parent->of_node;
./arch/arm/mach-exynos/suspend.c:	if (domain->of_node != controller)
./arch/arm/mach-exynos/suspend.c:	parent_args.np = domain->parent->of_node;

Thanks
Hanjun
