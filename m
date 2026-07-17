Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDE39D3FC
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279703; cv=none; b=IwCVxIWznvwB8AMuBHqLV10TibwZpZAtTwJGtsy2rEAkuV72jClxp0Aqnuav0cRdojfc78wSxgD1/6u3JfvOeL9UPJyp3qy7Jv+qMQigaP/d3RhRwyQzZw6WBvNx8yd5ToAeoSXPGUl8pSMC4bUxzjSfhj6sQyEu+YAY/hdZ9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279703; c=relaxed/simple;
	bh=yNenTNiz7CONPxTI50qO3r44+/wgFmqH7j1AyUDtNj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl5OpcfhFzgJr9fbhcRZwIwXUIVmASgNr49++Edid+xmBcIiMsoN1+era+1zknTpuF3FwBi98P+ILqnAO8azi9yaTvZGp7RZCHVh9zg3M5r5XUu47CYbDxMNrmjg1bto+fy+RfKtjEwCI2jqRaQcQvTCfNgFe6JE7RjYUrcErMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBAzwbs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBAzwbs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556A01F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279696;
	bh=ULGJ+1LpirI4Wiw2RdqL6G2QbDPyryLXlEfDEgk+O2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LBAzwbs8kGWqXXAZpwmyXPhX5eG97wfgCKu/E5F/0JtWlkmUKUOCt7QJnYkmrNu3o
	 iguSmeQPEXDf0Ayv4OTHolc1wFtUexmTh703pmbALqVAy4ozEcjqfJ48O2rpApnATN
	 x9IWapd0Au8MhQk9uw2uk9E3YFMIEgPoOa67TzQfRk3trPydrJdfnrcNe8Gk5VthaD
	 y+wVBb7QG7x1qS1HW8PkzwapE7BVB4wqX3WEtwbBu1083SynwvtXoNM4SHFi97aX5M
	 QkI+c9HMk3JzFUH5nsLkGBAjOcpyaJ/8VXE/Z3MK6Ax619hD7SrTbldmcL4JUAAq9Q
	 r8Pt71bHzNrxw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b013084dc2so3621891e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jul 2026 02:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RojtsIF/P5hjcgKbcx4hTB6KNMfYWUwqA7+gn3zqgFTdtzbkwvbQxvT7xh9kRJ0BGhXAXpQ6EGA700d@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkvtX66kJcoTXYqryO5y+fjWn5EABk+3mIK+izos0sbIRS8Z9
	uJQ/7t5+1laUDsOjRGDrED1BaSGCga38cuuHF8FO52HGArTQPlug8hYdkjOuxxshEt5j8O+Oemy
	pkmE9zdH5uWjN6ZBjsks3iD19ynrOLgk=
X-Received: by 2002:ac2:522c:0:b0:5b0:12a4:2262 with SMTP id
 2adb3069b0e04-5b28fab506dmr274104e87.59.1784279694791; Fri, 17 Jul 2026
 02:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716234538.1303811-1-W_Armin@gmx.de> <20260716234538.1303811-3-W_Armin@gmx.de>
In-Reply-To: <20260716234538.1303811-3-W_Armin@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 17 Jul 2026 11:14:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUoTRS4fce0=Qn8J=Yf5WtHfbzUw+kyxhhPaRtB2o35A@mail.gmail.com>
X-Gm-Features: AUfX_mwgwOe8CknA18nr8TBR-YSM4vbMkOem1_KEsUbQaA7gcJm76AFmTj3On0M
Message-ID: <CAJZ5v0hUoTRS4fce0=Qn8J=Yf5WtHfbzUw+kyxhhPaRtB2o35A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
To: Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@weissschuh.net, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:45=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> The WMI-ACPI driver now supports architectures other than x86.
> Remove the CONFIG_X86 handling from video-detect and the associated
> GPU drivers to simplify the resulting code.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Or please let me know if you want me to pick up this one.

Thanks!

> ---
>  drivers/acpi/Kconfig               | 2 +-
>  drivers/acpi/video_detect.c        | 8 --------
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
>  drivers/gpu/drm/gma500/Kconfig     | 1 -
>  drivers/gpu/drm/i915/Kconfig       | 1 -
>  drivers/gpu/drm/radeon/Kconfig     | 4 +---
>  drivers/gpu/drm/xe/Kconfig         | 5 ++---
>  7 files changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..cc1e58fa664b 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>         tristate "Video"
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on INPUT
> -       depends on ACPI_WMI || !X86
> +       depends on ACPI_WMI
>         select THERMAL
>         help
>           This driver implements the ACPI Extensions For Display Adapters
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 458efa4fe9d4..af9280b244f1 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context, =
void **rv)
>         return AE_OK;
>  }
>
> -/* This depends on ACPI_WMI which is X86 only */
> -#ifdef CONFIG_X86
>  static bool nvidia_wmi_ec_supported(void)
>  {
>         struct wmi_brightness_args args =3D {
> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>          */
>         return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
>  }
> -#else
> -static bool nvidia_wmi_ec_supported(void)
> -{
> -       return false;
> -}
> -#endif
>
>  /* Force to use vendor driver when the ACPI device is known to be
>   * buggy */
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 12e4a41bf1f0..50305630f533 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>         # ACPI_VIDEO's dependencies must also be selected.
>         select INPUT if ACPI
>         select ACPI_VIDEO if ACPI
> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> -       select X86_PLATFORM_DEVICES if ACPI && X86
> -       select ACPI_WMI if ACPI && X86
> +       select ACPI_WMI if ACPI
>         help
>           Choose this option if you have a recent AMD Radeon graphics car=
d.
>
> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kcon=
fig
> index a2acaa699dd5..dc4c56638819 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -11,7 +11,6 @@ config DRM_GMA500
>         select ACPI_VIDEO if ACPI
>         select BACKLIGHT_CLASS_DEVICE if ACPI
>         select INPUT if ACPI
> -       select X86_PLATFORM_DEVICES if ACPI
>         select ACPI_WMI if ACPI
>         help
>           Say yes for an experimental 2D KMS framebuffer driver for the
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 5e939004b646..71426b9c91f0 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -28,7 +28,6 @@ config DRM_I915
>         # but for select to work, need to select ACPI_VIDEO's dependencie=
s, ick
>         select BACKLIGHT_CLASS_DEVICE if ACPI
>         select INPUT if ACPI
> -       select X86_PLATFORM_DEVICES if ACPI
>         select ACPI_WMI if ACPI
>         select ACPI_VIDEO if ACPI
>         select SYNC_FILE
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kcon=
fig
> index c479f0c0dd5c..3cd70aef770e 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -25,9 +25,7 @@ config DRM_RADEON
>         # ACPI_VIDEO's dependencies must also be selected.
>         select INPUT if ACPI
>         select ACPI_VIDEO if ACPI
> -       # On x86 ACPI_VIDEO also needs ACPI_WMI
> -       select X86_PLATFORM_DEVICES if ACPI && X86
> -       select ACPI_WMI if ACPI && X86
> +       select ACPI_WMI if ACPI
>         help
>           Choose this option if you have an ATI Radeon graphics card.  Th=
ere
>           are both PCI and AGP versions.  You don't need to choose this t=
o
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4d7dcaff2b91..502c7b3c1f16 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -4,7 +4,6 @@ config DRM_XE
>         depends on DRM && PCI
>         depends on KUNIT || !KUNIT
>         depends on INTEL_VSEC || !INTEL_VSEC
> -       depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
>         depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
>         select INTERVAL_TREE
>         # we need shmfs for the swappable backing store, and in particula=
r
> @@ -29,8 +28,8 @@ config DRM_XE
>         # but for select to work, need to select ACPI_VIDEO's dependencie=
s, ick
>         select BACKLIGHT_CLASS_DEVICE if ACPI
>         select INPUT if ACPI
> -       select ACPI_VIDEO if X86 && ACPI
> -       select ACPI_WMI if X86 && ACPI
> +       select ACPI_VIDEO if ACPI
> +       select ACPI_WMI if ACPI
>         select SYNC_FILE
>         select CRC32
>         select SND_HDA_I915 if SND_HDA_CORE
> --
> 2.39.5
>
>
