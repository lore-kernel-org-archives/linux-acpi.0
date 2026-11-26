Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704189;
	b=oVUQjZt4HIQcrS6yWZTT1F3fodK9pu/lI2qf7JVFygHYDF18Z4SbeiPgSDI8ZMSIGHzc
	 cUzytrN6k6thIIk/oP+JpV0H2YzMeQ2NAg2amtDf89GEA+EMHUcsgKlBcU5Ux8OXT5mhb
	 AspwPL/lt4dpvjC+aUfHmnJdZ7hiczV4W1nsKrMrgdyvlHu3ExhHB8eOIQcJZs6adxfMm
	 r8dvyMRGYtROgC07OFsueYh+r8yOu3pkd89u3t1SDEPIvIQ+lzYs5HD6+3awLNcYMbs1/
	 7qeeAGnCDWm0XaN1Phbw/XlSQePNOgqvDGNfEO3yfQ9xkzh1atUM7+Ki2tdlv+jGHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704189;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMUHiZuEtICvjydfqxjQu4Xmn+xqwyoYrAVr2P+AGdM=;
	b=IVj1H65t0F9tEnYOvdFY4CM6Eczh0UAsCBziDeS1XjNnF7gHHyPMJbEi861RauHo6kSj
	 yoTlr4bD0QVC/DhbEz+WFjvAu/JCIqK+TKlfDqWqEGddVCSaCrJ4CmVSynJRpfGIbeIf2
	 IOwNMIZhDN6ld6ydOFLYlxDQqfYBV4YQJfDbOdGcPX1AEeD1HPlKFnAjOQ+gTDMPRxG4b
	 oPK7fVQ6EdlSqOgHTnr4TcBDxHdY57BaLJOp4ZNECjGMlrlN4resP936vLq2Jxe5nqsXY
	 2+ZzzXXSPNnfs2wdyW2VyL0aC44AWblSt0RqHYH35vSckOUKhxLTsnE3dq1L3sceu1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd10onn6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6D606A327
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd10onn6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954E71F000C6
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704187;
	bh=IMUHiZuEtICvjydfqxjQu4Xmn+xqwyoYrAVr2P+AGdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bd10onn6Hm2QqO7osmizPugMTSgnz+Tr9B6Ky2ZlX/vqdn2f7EZPTVwYAQ6Vze6V5
	 vK2pm5GXPxnrIBQnCJ9BiIn1mkBsgOkBZpLnAvmTGqGNpoFKmtXIfHVOckotrwwDWv
	 T8Bz5YjU0XWHd5ngtO51fNBxy/GATHikiQs2NTt+cTwwc7RwZnZjIiLTAlaka3OR+F
	 fZ6C9uhKd6jvAE7CcGDGwlSdjXfbb1dCd67gPY+x8cwNIMrg1ZU4P3JBoOLKwXUdGM
	 S10Tn4np9vRhi+v4zn0m0IwWUqCbeC4X6Dr6ZFFcaV2jTJJHy+Gz8PSOwUNTya0EbG
	 gx79kCBoEYUTQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c08539c827so5579259e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 06:43:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFjcT5h8VZIJAxFvSy6x1mCPwyTszB4ma6UCz75Pqlq6DZGLONe6DXIzTQCGBt/1QdWUq7Y+LNCyOJi@vger.kernel.org
X-Gm-Message-State: APuU4Z82oJ47vICu/56ifZQBIYwgqWTrAFYg/KOgx3EO6NtNFEF+7fIA
	xI6lTfos6izpKBdRySo+3hLSqNzHIN/rH9mYOtX2/mVE3fUmGV1vqV2Wl4m3kUFu4Z8BbphLX89
	YNTq2I7ZEsfF5Xv3zBBUSVuawlXL9Yk8=
X-Received: by 2002:a05:6512:1596:b0:5c1:4e6b:6491 with SMTP id
 2adb3069b0e04-5c32da32175mr1103240e87.59.1795704185922; Thu, 26 Nov 2026
 06:43:05 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124182046.33252-1-elijah@elijahmock.com>
In-Reply-To: <20261124182046.33252-1-elijah@elijahmock.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 26 Nov 2026 15:42:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZtTAAhHBEXZg9iLqm7fvskWPT4kYwE7BrJ0ysG_GMqg@mail.gmail.com>
X-Gm-Features: Aa3M54rvsJloL0qz-S1sPLR_X4inplpwVmKmSfXP6eFIJ1-6A_J6_AXAnYjXkT4
Message-ID: <CAJZ5v0iZtTAAhHBEXZg9iLqm7fvskWPT4kYwE7BrJ0ysG_GMqg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Disable default lid wakeup on MSI MS-15FK
To: Elijah Mock <elijah@elijahmock.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 7:21=E2=80=AFPM Elijah Mock <elijah@elijahmock.com>=
 wrote:
>
> On the MSI Creator A16 AI+ A3HVFG (board MS-15FK), the system fails to
> enter s2idle hardware sleep due to a firmware quirk exposed in v7.0.
>
> ACPI behavior of the device: LID0 (PNP0C0D) defines a _PRW package
> referencing GPE 0x03 with wake state S0 and no AML handler (_L03/_E03);
> the status bit for GPE 0x03 remains 1 regardless of the physical lid
> state. Lid open/close detection via the Embedded Controller (GPE 0x0A)
> functions correctly.
>
> Following commit 52d864019636 ("ACPI: button: Convert the driver to a
> platform one") and commit 57c31e6d620f ("ACPI: scan: Use
> acpi_setup_gpe_for_wake() for buttons"), GPE 0x03 is armed for wakeup
> during suspend, which immediately causes a spurious wakeup (regardless
> of whether the lid is open or closed) [1].
>
> To prevent this issue, add a DMI quirk for board MS-15FK so that
> devm_acpi_button_init_wakeup() marks LID0 as wakeup-capable via
> device_set_wakeup_capable(dev, true) but does not enable wakeup by
> default with device_init_wakeup(dev, true); instead, the ED lid
> detection delivers necessary wakeup events. This fixes
> suspend-to-idle while preserving normal lid state reporting and
> preserving the lid wakeup event handler for user space.
>
> Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one"=
)
> Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for butto=
ns")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5283 [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Elijah Mock <elijah@elijahmock.com>
> ---
> Testing:
> - Tested on MSI Creator A16 AI+ A3HVFG (BIOS E15FKAMS.321, 09/17/2026)
>   on top of mainline (v7.4-rc4+)
> - Verified hardware sleep with lid open and lid closed, using amd-s2idle
>   test
> - Verified awake lid state reporting (/proc/acpi/button/lid/LID0/state)
>
> Notes for reviewers:
> - I am supposing that this is a firmware quirk matching MS-15FK (largely
>   due to this issue not being widely reported) and not a generic ACPI
>   kernel issue
> - The Fixes: tags reference the commits that exposed this firmware
>   quirk; let me know if they are not appropriate
>
>  drivers/acpi/button.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 91a4e9698f7..c80164283d6 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -170,6 +170,23 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>         {}
>  };
>
> +static const struct dmi_system_id dmi_lid_no_wakeup_quirks[] =3D {
> +       {
> +               /*
> +                * MSI Creator A16 AI+ A3HVFG (MS-15FK): LID0 declares a
> +                * handlerless _PRW GPE (0x03) with S0 wake state whose s=
tatus
> +                * bit stays asserted regardless of lid state, aborting s=
2idle
> +                * immediately when armed for wakeup.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR,
> +                                 "Micro-Star International Co., Ltd."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "MS-15FK"),
> +               },
> +       },
> +       {}
> +};
> +
>  static int acpi_button_probe(struct platform_device *pdev);
>  static void acpi_button_remove(struct platform_device *pdev);
>
> @@ -570,9 +587,15 @@ static void acpi_button_wakeup_cleanup(void *data)
>         device_init_wakeup(data, false);
>  }
>
> -static int devm_acpi_button_init_wakeup(struct device *dev)
> +static int devm_acpi_button_init_wakeup(struct device *dev, u8 button_ty=
pe)
>  {
> -       device_init_wakeup(dev, true);
> +       if (button_type =3D=3D ACPI_BUTTON_TYPE_LID &&
> +           dmi_first_match(dmi_lid_no_wakeup_quirks)) {

Any chance to combine this new DMI quirk list with the existing one
and do just one DMI check upfront in acpi_button_init()?  You can add
an extra static bool var for this, no problem.

> +               dev_info(dev, "Disabling default wakeup due to DMI quirk\=
n");
> +               device_set_wakeup_capable(dev, true);
> +       } else {
> +               device_init_wakeup(dev, true);
> +       }
>         return devm_add_action_or_reset(dev, acpi_button_wakeup_cleanup, =
dev);
>  }
>
> @@ -747,7 +770,7 @@ static int acpi_button_probe(struct platform_device *=
pdev)
>         if (error)
>                 return error;
>
> -       error =3D devm_acpi_button_init_wakeup(dev);
> +       error =3D devm_acpi_button_init_wakeup(dev, button_type);
>         if (error)
>                 return error;
>
>
