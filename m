From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Allow GIC ITS number more than MAX_NUMNODES
Date: Fri, 21 Jul 2017 18:50:36 +0800
Message-ID: <CAGHbJ3AfXMHy5+ZNQnPBiNEOvxTNgELMWvvgRZmYM5dHdzN4-w@mail.gmail.com>
References: <1500630715-2156-1-git-send-email-guohanjun@huawei.com> <5971D208.3040005@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35021 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbdGUKuh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 06:50:37 -0400
Received: by mail-qt0-f176.google.com with SMTP id b40so38436833qtb.2
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2017 03:50:37 -0700 (PDT)
In-Reply-To: <5971D208.3040005@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 21 July 2017 at 18:06, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2017/7/21 17:51, Hanjun Guo wrote:
> > From: Hanjun Guo <hanjun.guo@linaro.org>
> >
> > When running 4.13-rc1 on top of D05, I got the boot log:
> >
> > [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> > [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> > [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> > [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> > [    0.000000] SRAT: ITS affinity exceeding max count[4]
> >
> > This is wrong on D05 as we have 8 ITSes with 4 NUMA nodes.
> >
> > So dynamically alloc the memory needed instead of using
> > its_srat_maps[MAX_NUMNODES], which count the number of
> > ITS entry(ies) in SRAT and alloc its_srat_maps as needed,
> > then build the mapping of numa node to ITS ID.
> >
> > After doing this, I got what I wanted:
> >
> > [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
> > [    0.000000] SRAT: PXM 0 -> ITS 1 -> Node 0
> > [    0.000000] SRAT: PXM 0 -> ITS 2 -> Node 0
> > [    0.000000] SRAT: PXM 1 -> ITS 3 -> Node 1
> > [    0.000000] SRAT: PXM 2 -> ITS 4 -> Node 2
> > [    0.000000] SRAT: PXM 2 -> ITS 5 -> Node 2
> > [    0.000000] SRAT: PXM 2 -> ITS 6 -> Node 2
> > [    0.000000] SRAT: PXM 3 -> ITS 7 -> Node 3
> >
> > Fixes: dbd2b8267233 ("irqchip/gic-v3-its: Add ACPI NUMA node mapping")
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 3ccdf76..fb1c090 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1847,7 +1847,7 @@ struct its_srat_map {
> >       u32     its_id;
> >  };
> >
> > -static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata;
> > +static struct its_srat_map *its_srat_maps __initdata;
> >  static int its_in_srat __initdata;
> >
> >  static int __init acpi_get_its_numa_node(u32 its_id)
> > @@ -1861,6 +1861,12 @@ static int __init acpi_get_its_numa_node(u32 its_id)
> >       return NUMA_NO_NODE;
> >  }
>
> Oops, need to check if the its_srat_maps valid or not here, please
> comment on what else I'm missing or wrong, then I will prepare another

                                                                   ^^^
And need to free the memory.

Thanks
Hanjun
