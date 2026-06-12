Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA614368968;
	Fri, 12 Jun 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250409; cv=none; b=pSy2nvwMMvbfpHGEWkms25TMEIDDzTE2PxXPOO3/odyqM1K0faFE9MoxNTaU9MYDuHb4pjh1OePJc1bO9Ma/zYVVhQUwjTa6+aiAxvHnB0+v9pTsQYpS8P3gX5L9oHmAUae8pPcf1o6531SiOy3bp3DGUnbHTeyPbzSpaxKpl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250409; c=relaxed/simple;
	bh=UmeoYy1ZTv2diNGfEqQ7eaK3gvhVqdqJTY1VsVd4Nqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKffgoW+pcUjn0fgotp/QQyFHJRdmT1n4u+hwsl+dPwDpwIK6W2UD8PazV1JmeKwQ1AZtr10Z+9OxKYAc/HjlF5XR7OgEttoWToiDdc5hznuyxO3y8zndY6jEhLg6UZIRbRjtsYtg3obT9miC/JD1mbzphO/mHOz6bgreLjQbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+1QaXUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+1QaXUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68651F000E9;
	Fri, 12 Jun 2026 07:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781250407;
	bh=wsHqcKwo5977UKsycGEh8MAYVcFHAquPzMtiUyoer6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+1QaXUCq74YYvlVOgn/Ru3J12byjHh3oF1trnV981cS8ZSh9VtCGlEcXiRceS0W6
	 IhRSby5DNEkviGLbN1SJZptVd+Wb/RffOlOwE1U+cFRwqF18XDv85vCbSHbM7+5/sm
	 ZJVjKw3nQftPFdVwiHE5wpG8sVvghI4L+wmFDV4YkBs95Lw8BE64SN38qzA3aYMtOl
	 8gOo8rbJsRMkdZE+zW4NFVpPJKluCb+Mi3j8kkfeNi9kReI4EBo06U7Qnmvvo9n5rK
	 J0h1wU6VurMB/ZF/CcGpHyeIPLFwdZxhS1OatXGHm3KmYVsRvP2CkmHWxP3azrFqlR
	 HzDiFLG4oNUMA==
Date: Fri, 12 Jun 2026 09:46:41 +0200
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
Message-ID: <aiu5YU+Yn1DekE+E@lpieralisi>
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

Given that this has no OF counterpart, I'd rather add an empty stub
for acpi_dev_clear_dependencies() and remove the ifdef - I am not
sure that adding a FW agnostic:

dev_clear_dependencies()

would help much but that's just my opinion. Then the question is whether I
should convert all other acpi_dev_clear_dependencies() users (with ifdeffery
included) in tree.

Thanks,
Lorenzo

> 
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
> 
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
