Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028962EA48F;
	Tue,  9 Jun 2026 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997499; cv=none; b=X+zXxkJh1XzeB0EU2IPvcZPZANWFygz7syxcDazbzuJo0XiLVQFrmko+zWqxHFoxp9rWBizJ279dkbJVumULLEEUq5jyzimODUytmzUfc1MSJqx8DEPJ9w2cEyrhtxgxWRXE4Ts7S21Eb9b06UKkyGXfUFZXu/fM+fyCKKjElQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997499; c=relaxed/simple;
	bh=JglZkZ7Dbmzv+aB20UgQeLa2k2exjJzd5rFjaiPrylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SseF3le5gDmu62vQqaELUqM7kMk1c9l2YojHVN6V2JKRZ6uxdqc8qqTGiX14SjO3sAXV1cWP5OW7Bn/tETqPHpvQ98N4DNKAirYo6kluZd/lL/nOGvjRk1o0GJZSN4/ssCZBPary/S7ZZP7w7V7r2g7OdduR5lr3OwREhBVmCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAI6hhRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAI6hhRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0606B1F00893;
	Tue,  9 Jun 2026 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780997497;
	bh=2O0A8k7i0uc3+GN/wePb/LhobyOV72RtaqOWFuiG+AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mAI6hhRXHfGBva7Rk3YIaxAe7+mGw8/Nc1CfF0iSOK7POUGUFrcPUd8rhYyAIQ/PA
	 dlYb0Z433wrDey4OY33Evo/RywrrH3HIGh1lADXKvY+gT6ZAUmg6ZBjy9/IrdeOviS
	 NuiO0yVrE5IWQNWfJz8xhh0BIlRrIE9lOhSaL3/LGs4BGbbOAr8eiDOybX/erkM50Z
	 B52wIBz2lnFpm0+319gQkrelQ1Y5h7gPp1y7bgpmHtOqRm2vnr9gBYfgU/iSufmUkS
	 R9LDV5FA/sPADE1rEeSrsfU5+o2bX1TWV5nsX2r5S6NA9HAXJye9hxqLxf1vBOU5LO
	 B5RcmBKv9b83Q==
Date: Tue, 9 Jun 2026 11:31:31 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 6/6] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
Message-ID: <aifdc2E/+YCvCnwG@lpieralisi>
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
 <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>

On Mon, Jun 08, 2026 at 07:18:15PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2026 at 10:21 AM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >
> > Register an ACPI hook in the ACPI interrupt management code for GICv5 to
> > retrieve the ACPI interrupt controller handle (if any) of the controller
> > handling a specific GSI, by updating the acpi_set_irq_model() call with
> > the gic_v5_get_gsi_handle() function pointer parameter.
> >
> > gicv5_get_gsi_handle() allows ACPI core to detect the ACPI handle
> > of the controller that manages a specific GSI interrupt.
> >
> > Update the IWB driver to clear device dependencies in ACPI core once the
> > IWB driver has probed.
> >
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
> >  drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
> > index 9103feb70ce8..a02cb9537b15 100644
> > --- a/drivers/irqchip/irq-gic-v5-iwb.c
> > +++ b/drivers/irqchip/irq-gic-v5-iwb.c
> > @@ -269,6 +269,11 @@ static int gicv5_iwb_device_probe(struct platform_device *pdev)
> >         if (IS_ERR(iwb_node))
> >                 return PTR_ERR(iwb_node);
> >
> > +#ifdef CONFIG_ACPI
> > +       if (has_acpi_companion(&pdev->dev))
> > +               acpi_dev_clear_dependencies(ACPI_COMPANION(&pdev->dev));
> > +#endif
> 
> I would rather add a wrapper for this, along with an empty stub for
> the !CONFIG_ACPI case.

Ok, I will.

> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> > index 03cc2830b260..26cfaea1af41 100644
> > --- a/drivers/irqchip/irq-gic-v5.c
> > +++ b/drivers/irqchip/irq-gic-v5.c
> > @@ -1217,11 +1217,19 @@ static struct fwnode_handle *gsi_domain_handle;
> >  static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
> >  {
> >         if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
> > -               return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
> > +               return iort_iwb_handle_fwnode(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
> 
> Why is this change needed?

This is a mistake, thanks for spotting it, it belongs in the previous patch
(IMO patch 5 and 6 are a single logical entity, I split it to try to keep
irqchip specific changes in one patch).

iort_iwb_handle() was refactored to return an acpi_handle not a fwnode_handle
(in preparation for adding gic_v5_get_gsi_handle() below - the dependency
chain requires acpi_handle retrieval not fwnode_handle), so the change above
belongs in patch 5, I will move this line change to patch 5 in v3.

Thanks,
Lorenzo

> >
> >         return gsi_domain_handle;
> >  }
> >
> > +static acpi_handle gic_v5_get_gsi_handle(u32 gsi)
> > +{
> > +       if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
> > +               return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
> > +
> > +       return NULL;
> > +}
> > +
> >  static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
> >  {
> >         struct acpi_madt_gicv5_irs *irs = (struct acpi_madt_gicv5_irs *)header;
> > @@ -1242,7 +1250,8 @@ static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsig
> >         if (ret)
> >                 goto out_irs;
> >
> > -       acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id, NULL);
> > +       acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id,
> > +                          gic_v5_get_gsi_handle);
> >
> >         return 0;
> >
> >
> > --
