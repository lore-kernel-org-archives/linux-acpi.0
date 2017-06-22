From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 2/2] acpi, gicv3-its, numa: Adding numa node mapping
 for gic-its units
Date: Thu, 22 Jun 2017 15:49:25 +0100
Message-ID: <2d99c999-8ded-ac3d-57a2-fd81dbadadea@arm.com>
References: <1498111812-17053-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498111812-17053-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbdFVOte (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jun 2017 10:49:34 -0400
In-Reply-To: <1498111812-17053-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, jnair@caviumnetworks.com, gpkulkarni@gmail.com

On 22/06/17 07:10, Ganapatrao Kulkarni wrote:
> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2.
> Later in per device probe, ITS devices are mapped to numa node using
> ITS Id to proximity domain mapping.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 75 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 45ea1933..1c21e01 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1833,6 +1833,77 @@ static int __init its_of_probe(struct device_node *node)
>  
>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
>  
> +#ifdef CONFIG_ACPI_NUMA

So given that there is a dependency issue between the irqchip and apcica
trees, I plan on taking this patch with the following change:

#if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170531)

matching what is currently in -next.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
