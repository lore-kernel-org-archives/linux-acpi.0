From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Allow GIC ITS number more than
 MAX_NUMNODES
Date: Fri, 21 Jul 2017 18:06:00 +0800
Message-ID: <5971D208.3040005@huawei.com>
References: <1500630715-2156-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:9396 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbdGUKGV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 06:06:21 -0400
In-Reply-To: <1500630715-2156-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 2017/7/21 17:51, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> When running 4.13-rc1 on top of D05, I got the boot log:
>
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> [    0.000000] SRAT: ITS affinity exceeding max count[4]
>
> This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
>
> So dynamically alloc the memory needed instead of using
> its_srat_maps[MAX_NUMNODES], which count the number of
> ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
> then build the mapping of numa node to ITS ID.
>
> After doing this, I got what I wanted:
>
> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
> [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
> [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
> [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
>
> Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 3ccdf76..fb1c090 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1847,7 +1847,7 @@ struct its_srat_map {
>  	u32	its_id;
>  };
>  
> -static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
> +static struct its_srat_map *its_srat_maps __initdata;
>  static int its_in_srat __initdata;
>  
>  static int __init acpi_get_its_numa_node(u32 its_id)
> @@ -1861,6 +1861,12 @@ static int __init acpi_get_its_numa_node(u32 its_id)
>  	return NUMA_NO_NODE;
>  }

Oops, need to check if the its_srat_maps valid or not here, please
comment on what else I'm missing or wrong, then I will prepare another
version.

Thanks
Hanjun

