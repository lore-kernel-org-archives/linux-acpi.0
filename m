From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 1/7] genirq: irqdomain: Use an accessor for the of_node
 field
Date: Fri, 24 Jul 2015 16:54:29 +0800
Message-ID: <55B1FD45.4060706@linaro.org>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com> <1437656713-9677-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36766 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbbGXIyi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 04:54:38 -0400
Received: by pdjr16 with SMTP id r16so10782083pdj.3
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2015 01:54:37 -0700 (PDT)
In-Reply-To: <1437656713-9677-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
> The struct irq_domain contains a "struct device_node *" field
> (of_node) that is almost the only link between the irqdomain
> and the device tree infrastructure.
>
> In order to prepare for the removal of that field, convert all
> users outside of kernel/irq/irqdomain.c to use an accessor.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/c6x/platforms/megamod-pic.c              | 2 +-
>   arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
>   arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
>   arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
>   arch/powerpc/platforms/pasemi/msi.c           | 6 ++++--
>   arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
>   arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
>   arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
>   arch/powerpc/sysdev/i8259.c                   | 3 ++-
>   arch/powerpc/sysdev/ipic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic_msi.c                | 2 +-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-

Hmm, no arch/arm/, and there are several domain->of_node
or similar in those files, or did I miss something?

>   drivers/gpio/gpio-sodaville.c                 | 2 +-
>   drivers/irqchip/exynos-combiner.c             | 2 +-
>   drivers/irqchip/irq-atmel-aic-common.c        | 2 +-
>   drivers/irqchip/irq-crossbar.c                | 4 ++--
>   drivers/irqchip/irq-gic-v2m.c                 | 2 +-
>   drivers/irqchip/irq-gic-v3-its.c              | 2 +-
>   drivers/irqchip/irq-gic-v3.c                  | 2 +-
>   drivers/irqchip/irq-gic.c                     | 2 +-
>   drivers/irqchip/irq-hip04.c                   | 2 +-
>   drivers/irqchip/irq-mtk-sysirq.c              | 2 +-
>   drivers/irqchip/irq-s3c24xx.c                 | 4 ++--
>   drivers/irqchip/irq-tegra.c                   | 4 ++--
>   drivers/irqchip/irq-vf610-mscm-ir.c           | 5 +++--
>   drivers/spmi/spmi-pmic-arb.c                  | 2 +-
>   include/linux/irqdomain.h                     | 5 +++++
>   28 files changed, 51 insertions(+), 35 deletions(-)
>


Thanks
Hanjun
