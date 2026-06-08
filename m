Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF23D4131
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939110; cv=none; b=oHh1qlBSq129GO5fHco8lQk3RIaw2B6yraw1j8KoVUHiZO23CACspBQ7czxmQuYmoSGDd5ZYQWGNTukJT13wAG3H3gGgwd/1R+i7vGGgZ7Vb6MPzhdK2RT6u004xRVGnYq+7pGsnrksZzLMrLFH+/zzBEFOzF+Ao8xPmLDISmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939110; c=relaxed/simple;
	bh=XswRMnJy2WcPmkojhTaDjWE6sZSauClfbcBvgsDRxTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFL2yaV0L7LOBTa5o4fKUFfkWUHHWOvJAO/GdNRQl8ofc6hrN3+dCYCty0PvEjH6lPz3yjzAAqZ1ReRKGo/qEgDgc+4BqhoeHiym/vfOpp4TzIKIvl3luqkP4+iz0Ih0La17bXVg/Acc1bRygRL+geD88LCR4OSUOwX9t04ZdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLTgCh3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLTgCh3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4C41F008A4
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939109;
	bh=XrNOOi+PlaQWmV4dMJih5PA704/YUREYdhWD77leDwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HLTgCh3yhadZl289IczKuXkCE36Qy7xWQugFEKxferkvMdoUi39a5EfSBSYYG/5L0
	 rqmvn5BwRvfJ9gcRUO5dOU1cZ4cFHPByO4XdvDaRbU/lNu8DMN8sN8+G0x/eZncMxx
	 qcE4hqpnHAr8kL5B0t3GqUjTCcFPi9NvxxvU7uCAef3rxLRq1UEJd0RNxehBZTsnHS
	 Wiw3c+X2tgQqIAGFGeVL5c1gdbjX6ajj+NEO8jI0cR1DrhbE0zK6zvviO7SPBG2X8j
	 gZO2GWNBfvSSrQ9K9S1l8DYU0BvHH+jT+igpACkxJd5M83AhLapkQEBY+e7F3Wq21T
	 EcjeVVSjGa/Pw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39676d82b7fso45640271fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 10:18:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/g6z2aAg+M4nOZIcr1fRyvgnvsPiiqy0L6AXhmP5c0xi3CRrogNR9m6N9A1GL0XupnysNpZ2mMJrm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JpEelBtIFPHNnuVSVdOx/jbKGtKYhoMj7/dxrtAYxUFLAx53
	TWChhGO/3k1HqIYLLJnAYC4IbgyEX4w5kIxO83wO9UibzRKqSG4L/20+iY4OUx65sZHCnWanOG4
	XgMmkAZFw0HcaLOJod6uQsYMnuWhU+so=
X-Received: by 2002:a05:6512:33c3:b0:5aa:6e5d:adf5 with SMTP id
 2adb3069b0e04-5aa87beb34fmr4601211e87.19.1780939107273; Mon, 08 Jun 2026
 10:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 19:18:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>
X-Gm-Features: AVVi8CcTa11c5Xl8V7_VF2hxe7iSgWJNbGaXh3nHX-6VT5F-TvPgOxONicEOC_k
Message-ID: <CAJZ5v0ibZKfzJwGyUb92-K1N9C_ab0QujpAKCrvMdyygquS1Vw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 10:21=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> Register an ACPI hook in the ACPI interrupt management code for GICv5 to
> retrieve the ACPI interrupt controller handle (if any) of the controller
> handling a specific GSI, by updating the acpi_set_irq_model() call with
> the gic_v5_get_gsi_handle() function pointer parameter.
>
> gicv5_get_gsi_handle() allows ACPI core to detect the ACPI handle
> of the controller that manages a specific GSI interrupt.
>
> Update the IWB driver to clear device dependencies in ACPI core once the
> IWB driver has probed.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
>  drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v=
5-iwb.c
> index 9103feb70ce8..a02cb9537b15 100644
> --- a/drivers/irqchip/irq-gic-v5-iwb.c
> +++ b/drivers/irqchip/irq-gic-v5-iwb.c
> @@ -269,6 +269,11 @@ static int gicv5_iwb_device_probe(struct platform_de=
vice *pdev)
>         if (IS_ERR(iwb_node))
>                 return PTR_ERR(iwb_node);
>
> +#ifdef CONFIG_ACPI
> +       if (has_acpi_companion(&pdev->dev))
> +               acpi_dev_clear_dependencies(ACPI_COMPANION(&pdev->dev));
> +#endif

I would rather add a wrapper for this, along with an empty stub for
the !CONFIG_ACPI case.

> +
>         return 0;
>  }
>
> diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> index 03cc2830b260..26cfaea1af41 100644
> --- a/drivers/irqchip/irq-gic-v5.c
> +++ b/drivers/irqchip/irq-gic-v5.c
> @@ -1217,11 +1217,19 @@ static struct fwnode_handle *gsi_domain_handle;
>  static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
>  {
>         if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) =3D=3D GICV5_GSI_IWB_TYPE)
> -               return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, =
gsi));
> +               return iort_iwb_handle_fwnode(FIELD_GET(GICV5_GSI_IWB_FRA=
ME_ID, gsi));

Why is this change needed?

>
>         return gsi_domain_handle;
>  }
>
> +static acpi_handle gic_v5_get_gsi_handle(u32 gsi)
> +{
> +       if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) =3D=3D GICV5_GSI_IWB_TYPE)
> +               return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, =
gsi));
> +
> +       return NULL;
> +}
> +
>  static int __init gic_acpi_init(union acpi_subtable_headers *header, con=
st unsigned long end)
>  {
>         struct acpi_madt_gicv5_irs *irs =3D (struct acpi_madt_gicv5_irs *=
)header;
> @@ -1242,7 +1250,8 @@ static int __init gic_acpi_init(union acpi_subtable=
_headers *header, const unsig
>         if (ret)
>                 goto out_irs;
>
> -       acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_i=
d, NULL);
> +       acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_i=
d,
> +                          gic_v5_get_gsi_handle);
>
>         return 0;
>
>
> --
