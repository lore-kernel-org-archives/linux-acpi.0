Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14194335091
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950143; cv=none; b=M5+GDG3Es5J6/q3hccRflo9b4cVjnAwulHx5KiB20Jnc6jbxV+rEZA4KoY1mHayeV8aaEGWsSnAk3LujINwnE2+/x0nH6pb++A1CgXJLl3A1lb8MkNeHIQvaKVXWrlOF5BHvCJab8enFPDzvMCk9pQFmVfS1GC/FkR2u+8rQmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950143; c=relaxed/simple;
	bh=UVXndUC5AiXrgpThIiPLHz9wzQoGGbMP2Fg7NsV01F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnOxIqrerQLyReCVVhM+jJttuAe0CYTE594vtPvLyhDlMVN/C6D8YFhneUYbd56lI5z+WUrsfFnUB8gHhb4LF0D+mStFYjIlt+ogQCiPndwlDhmjcBITqLb1f0eNB0RxKBWy6Isq0TfL5qK/W5/kC4Pox9ItMaMfUpWvjlcI3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJlcAr7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJlcAr7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB31F000E9
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785950141;
	bh=b9AAwPnowa411jA6f+Cdna9enhr2G3lCD0UlJHOIWmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PJlcAr7Rdlc/K3G83/lh+BI0TRdJc96+Lh3+6suaOjshT7C1GWwh3Qu/jvWX9j7em
	 Xa9nRplpuDRBIkQw1SZh8ezRXBmhaL4dX5Wi4WR+HcQ1oKUAc5WpfGAFkMpkGIEg3d
	 hy5YKkmnsUxcsxUoIEG/U9lAj0F+ucJwzaZanVP2hZw60ZvNJ+E0XfcO7LXyBK36Hl
	 BeRC0pwffvVuOB+ZVjLQZXBxM6YsKxId8bgHxvyLViALIZqiGde8dqv/pBoPYJeV8K
	 8t8FB88X8+NnSgq/NADRmn8Cf+N+HOqvWdjQ7e5uXWm2WFVi0i7XE+8PxleONHv5OZ
	 ohvYhxNKOORUA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso1224570e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 10:15:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofxKuEehSl1pjYfjukTTdYd6ugkfUbgSh3EIfNvEvYraXF74BqG7uUw7dCLucQg8nnXRLLb4QRN7PG@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSeWK4Lx8thK9t6nbjni+Hn+5VimP4PFEGwF8ZfMGimzJzYpE
	sYN3Q0IieHERbOT7ikCCsMYIvkgADi4kaxdSHQgE6hnPtbtvCd4lgMtGWKsDe9mHeVCk0ZZihd4
	6yhrjmt0yaTW68/kc3YxLkPrNpGvWYDc=
X-Received: by 2002:a05:6512:1293:b0:5aa:6c98:a090 with SMTP id
 2adb3069b0e04-5b2f4cc8ddcmr1265179e87.34.1785950140193; Wed, 05 Aug 2026
 10:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727132151.12792-1-maarcospm1996@gmail.com>
In-Reply-To: <20260727132151.12792-1-maarcospm1996@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 19:15:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jRYmhr+x7j_zWSu5tnt+Nkf3-sVHXS1_rp=xk86wFbCA@mail.gmail.com>
X-Gm-Features: AUfX_my3JmedCtKm9VmYYAfb05BRMCL3JbodFcmhWVu5jNL7rAYpIVTbBLqoCPY
Message-ID: <CAJZ5v0jRYmhr+x7j_zWSu5tnt+Nkf3-sVHXS1_rp=xk86wFbCA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: force native backlight on Acer Nitro AN515-46
To: Marcos Paulo Medeiros <maarcospm1996@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:22=E2=80=AFPM Marcos Paulo Medeiros
<maarcospm1996@gmail.com> wrote:
>
> The Acer Nitro AN515-46 is a hybrid graphics laptop whose internal
> panel is driven by the AMD GPU (Radeon 680M); the discrete NVIDIA GPU
> only drives external outputs. The firmware nevertheless advertises the
> NVIDIA WMI EC backlight GUID, so the backlight type resolves to
> nvidia_wmi_ec. The nvidia-wmi-ec-backlight driver however fails to
> probe ("EC backlight control failed: AE_NOT_FOUND") and, since the
> backlight type is still nvidia_wmi_ec, amdgpu skips registering its
> own backlight device. The result is no backlight device at all,
> leaving the brightness keys and the desktop brightness slider
> non-functional.
>
> Booting with acpi_backlight=3Dnative makes amdgpu register its backlight
> interface and brightness control works. Add a DMI quirk to use the
> native backlight on this model by default.
>
> Signed-off-by: Marcos Paulo Medeiros <maarcospm1996@gmail.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 5b0dc679e..07755b856 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -919,6 +919,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-=
n0xxx"),
>                 },
>         },
> +       {
> +        .callback =3D video_detect_force_native,
> +        /* Acer Nitro AN515-46 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Nitro AN515-46"),
> +               },
> +       },
>
>         /*
>          * x86 android tablets which directly control the backlight throu=
gh
> --

Applied as 7.3 material, thanks!
