Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755403D9DDE
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847605; cv=none; b=PlVA5KJm0JeXofCwudiSk+5z/QU9ZT7E0o40WkSAK+kk0gxy+akuH2o/KBy4i5Zp5rrum55zQKdJab6VSZEnnk0OGjXCzR4vUyq846OMnibgpb9OSz6F/0w/q0it+qEEw4e4Dr4T4Ba63r40IKzB+s8L37SmG78R8O+Yfe8mybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847605; c=relaxed/simple;
	bh=LYzrSwBFbfl22TyOkFOzeEjPlc63rtVaztyq2FVmUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnJ4ucP0+cpDXodEmYjkbLzgGezf7/yWli67YRopxjexl8PoG2DKbg2c4W8C26EIA33iDWREqVPTbGa//saIJMUQ8dFNBe8F2k7/FLElUWCUJTcECYH0kQmtUzQ87avZv6iTKjxbEH21JKOcqFNjz6xN7153EQ6QKfGJFMydWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TefkPpql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TefkPpql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D41F00A3F
	for <linux-acpi@vger.kernel.org>; Tue,  4 Aug 2026 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847601;
	bh=sQ3/NC+3cpmXFMYetYl7lO8X8YpBbpgvgulg/NkNMQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TefkPpqls1ZZTAGa4/z92f6he8C1TE1kWASWEntglG+IE1MYuZfISroWLw84x9WcG
	 3UdJ0oBAlSo36pUfeppT0sY1Zf5S8mNP5Td2lRgrUQ+JKGBufhaZE+RF2h+ausTaDX
	 zpKhp/I1u1xTy3R4aejECKkGnQ4Q8sqWRaCR9UjFrURorWC20PbpdR3hd1bY2PQp8Y
	 6IYow8nWHAPU1Y5d8caCWKuwk9/PnSKMZ6RaJE8OYN6TcJOOLMbIwm2GDzMiu6+S9X
	 fr7b7RgOhYnfEwIXkh/8YO/nmpPpcQLCC7dij5OPyWVztvuAs0+64HEhh8yZN4sp9Q
	 EvwpRQ5+wSMGQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so51604761fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2026 05:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpe2arIA/meXa4Yvlb4dVtbfDSx23P6w+i+QuunL2E5tarlpM7nM4D4zAOEbj/riSEmwe0ki3/mTWan@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1S1VcwfGi1DQcWVty9Yp3J4YBjf/xMB+4N+KJIVmzkTTstyF
	jW1mntF7bOlsIv6KlfVKD7KmSrLpWXpoODziNJ4a2bwq8VzWb5LvejF2ifq0v6vd7pYn7XGspq6
	ElbFx1liMBSvEdr+PborAZSUv5AP/d28=
X-Received: by 2002:a05:6512:3991:b0:5ae:b136:acdc with SMTP id
 2adb3069b0e04-5b2e4f6e8f6mr2869316e87.35.1785847599905; Tue, 04 Aug 2026
 05:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203459.10680-1-derekjohn.clark@gmail.com>
In-Reply-To: <20260803203459.10680-1-derekjohn.clark@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 4 Aug 2026 14:46:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com>
X-Gm-Features: AUfX_mz1srr2nF8qgwOyctaxm3G1UWnLyBr6WGtF7SuwYoBl4ClgZzzFQY9hT2A
Message-ID: <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com>
Subject: Re: [PATCH] acpi: pci_root: Add quirks table for _OSC support
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Derek J. Clark
<derekjohn.clark@gmail.com> wrote:
>
> The MSI Claw A8 hard-locks on resume from s2idle whenever an SD/MMC
> card is present in the RTS525A card reader (10ec:525a, PCI ID). This
> issue is not present on the Lenovo Legion Go with the same card reader.
> The primary difference is that the Claw A8 withholds LTR and DPC while
> granting ASPM control to the OS, leading to a split ownership. The issue
> can be mitigated by passing pcie_asmp=3Doff, but quirking on the pci_dev

You mean pcie_aspm=3Doff I suppose.

> in pci/quirks has no effect.
>
> Attempted quirks included use of pci_disable_link_state(),
> dev->link_state =3D NULL, manually zeroing aspm_l0s_support/aspm_l1_suppo=
rt
> via DECLARE_PCI_FIXUP_FINAL, and pcie_aspm_remove_cap() on
> DECLARE_PCI_FIXUP_HEADER. Only by disabling ASPM on the root hub is the
> system able to resume successfully.

So if there is a clash between the firmware and the OS, the question
is why it only happens during system resume and only for this specific
device in this specific configuration.

If disabling ASPM globally makes the symptom go away, it certainly is
related to ASPM, but it is kind of hard to say what exactly the
relationship is at this point.

> This strongly suggests a race between
> the OS resuming the link under its own ASPM assumptions and firmware
> independently acting on the same link based on state it never
> relinquished.

I'd like to see a boot log from the affected platform including the
entire PCI _OSC negotiation.

There actually is no way for the firmware to grant or refuse the ASPM
control to the OS separately.  It is part of the PCI Express
Capability Structure covered by OSC_PCI_EXPRESS_CAPABILITY_CONTROL, so
if that control bit is acknowledged via _OSC, the OS is supposed to
control ASPM (among other things).

The LTR and DPC are extended capabilities, so in principle they may be
controlled separately, if the OS controls the PCI Express Capability
structure, and there is no formal requirement to grant control of any
of them for ASPM to work.

> As an attempt to localize the workaround to as low level as possible
> while also being effective, introduce a quirk system to the existing
> acpi pci_root calculate_support() mechanism.

I'm not sure if there is a need to tell the firmware that ASPM is not
supported.  You may as well avoid asking for
OSC_PCI_EXPRESS_CAPABILITY_CONTROL on the affected platform.

> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  drivers/acpi/pci_root.c | 68 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6f78f96332ea..abd436a10438 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -422,7 +422,69 @@ static acpi_status acpi_pci_osc_control_set(acpi_han=
dle handle, u32 *mask,
>         return AE_OK;
>  }
>
> -static u32 calculate_support(void)
> +/*
> + * Some platforms advertise ASPM support in _OSC but withhold related
> + * control (e.g. LTR, DPC) from the OS on a specific root complex. The
> + * resulting split ownership between OS-managed ASPM and firmware-owned
> + * LTR/DPC can cause resume failures on s2idle. Rather than disabling
> + * ASPM system-wide, strip the offending support bits only on the
> + * affected root bridge so the OS abstains from requesting _OSC control
> + * there, leaving every other root complex on the system unaffected.
> + */
> +struct osc_support_quirk {
> +       const struct dmi_system_id dmi_match[2];
> +       u16 segment;
> +       u8 bus;
> +       u32 strip_support;
> +};
> +
> +static const struct osc_support_quirk osc_support_quirks[] =3D {
> +       /*
> +        * MSI Claw A8 (MS-1T8K): firmware withholds LTR/DPC control on
> +        * the primary root complex despite advertising ASPM support,
> +        * causing a hard lock on s2idle resume when the onboard RTS525A
> +        * SD card reader is populated.
> +        */
> +       {
> +               .dmi_match =3D {
> +                       {
> +                               .ident =3D "MSI Claw A8 BZ2EM",
> +                               .matches =3D {
> +                                       DMI_MATCH(DMI_SYS_VENDOR,
> +                                                 "Micro-Star Internation=
al Co., Ltd."),
> +                                       DMI_MATCH(DMI_BOARD_NAME, "MS-1T8=
K"),
> +                               },
> +                       },
> +                       {}
> +               },
> +               .segment =3D 0,
> +               .bus =3D 0,
> +               .strip_support =3D OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_P=
M_SUPPORT,
> +       },
> +};
> +
> +static u32 pci_osc_support_quirk_mask(struct acpi_pci_root *root)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(osc_support_quirks); i++) {
> +               const struct osc_support_quirk *q =3D &osc_support_quirks=
[i];
> +
> +               if (dmi_first_match(q->dmi_match) &&
> +                   root->segment =3D=3D q->segment &&
> +                   root->secondary.start =3D=3D q->bus) {
> +                       dev_info(&root->device->dev,
> +                                "PCI Root Bridge [%04x:%02x] _OSC quirk:=
 stripping support 0x%08x (%s)\n",
> +                                root->segment, (unsigned int)root->secon=
dary.start,
> +                                q->strip_support, q->dmi_match[0].ident)=
;
> +                       return ~q->strip_support;
> +               }
> +       }
> +
> +       return ~0;
> +}
> +
> +static u32 calculate_support(struct acpi_pci_root *root)
>  {
>         u32 support;
>
> @@ -441,6 +503,8 @@ static u32 calculate_support(void)
>         if (IS_ENABLED(CONFIG_PCIE_EDR))
>                 support |=3D OSC_PCI_EDR_SUPPORT;
>
> +       support &=3D pci_osc_support_quirk_mask(root);
> +
>         return support;
>  }
>
> @@ -571,7 +635,7 @@ static void negotiate_os_control(struct acpi_pci_root=
 *root, int *no_aspm)
>                 return;
>         }
>
> -       support =3D calculate_support();
> +       support =3D calculate_support(root);

This will delay the initialization of any system, not just the quirky
one.  Is there any way to avoid that?

>         decode_osc_support(root, "OS supports", support);
>
> --
