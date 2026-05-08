Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EA20E702
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268313; cv=none; b=cKCcGVNkRO2lQXLp3DSig2w+SRwv4jxV6Xe5XlyUaCzrpxNuyDbNb68h032uRkTs9oUbD8VhcKESsFi4HrWSaBRBcm61mptAHmDHnSb6E0QuiFA/wcOp3jqBgXADMotGNjyg2bP7dIqT95sHfZfIkApJQdeNXd0F1oIU6xbH9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268313; c=relaxed/simple;
	bh=3gCf1xha5AZBNhxUWVq5BkiVnTppVCLyA9+kYawbkg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF79y6xLQ0EeS8KtjMruMuazxhYeekenTtEYIfGEdsz/saHSSujcr+VuleAgTWSVRq1tg74ozj0prwVbDz/4cnz8XwZeYIUhT8TZqytQvdNjMgw1fK5hdRbTjz71/O/PXNqlVqccBRDGzYJ0YzwRIAyC3IUUQQM5pRd/3SyU474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAFqiBnn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAFqiBnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F259BC2BCF5
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268313;
	bh=3gCf1xha5AZBNhxUWVq5BkiVnTppVCLyA9+kYawbkg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EAFqiBnnFyfkDr7d34DLvJiMn+FOMyQ/dZ56GQdIeUiAm62CLHFt8lMPUyMswt0TD
	 9wogM/YNWBfqxVJTbqLNC9wrK4xHsuEBF4rNGlxbgTm2mNcbJs0KRDXYXhThLUs1QT
	 JDGdmGD8tFdG6hXZACrnltQ0BJQHvAQ1syWFdTPHD/27HA6k41gu+Jewif37UZHwsI
	 UjfV024Yxl9NRDh5R53Nv3/jO7CCmRTTY7wo6fP7OxIQ85TiAYQh9qR8Xhjj+GTa9W
	 0XRkZXiq2cJ+5t0dWgYuX8JTO/NYwN808cC/+eA4EACTBjJHu07d+UANUU7ie7Vg1D
	 7bxtuTpFgwzQQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a525aedb24so2307334e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2026 12:25:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/HWQOjaLIIk+ZE+6dOb26AgnHYBopfJe+oZwsBZu1kb4UMFZLJ2/F8uBV5vg/flSdi8yBqtLx+Sy6S@vger.kernel.org
X-Gm-Message-State: AOJu0YyqonjxmEAs/JMfffrryrPM9teea8VWljrQjfNLKzLDXTEHXP3x
	vTLj+2ZT37SWaSIf8eTRJsS7WuOkvFZGFmRzEVOh92UwGfwPflPb0oxV0R/RRgHzBY0MGkpCbLj
	Kh7nbmnDUmYhNBHvsD9b0LKAFivFnIjM=
X-Received: by 2002:a05:6512:ace:b0:5a8:8f72:de76 with SMTP id
 2adb3069b0e04-5a88f72e0d5mr3831732e87.19.1778268311108; Fri, 08 May 2026
 12:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev> <20260425215734.14116-3-lkml@antheas.dev>
In-Reply-To: <20260425215734.14116-3-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:24:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXccTBZOkzSMv38aMP7H5S5sR8viAoffqqHuENx1pGWQ@mail.gmail.com>
X-Gm-Features: AVHnY4KppuIy-VCBpHE3OB-HYAt0KPBAeHgpp3qxeD15E6iefRRjhR9pXc4IpSM
Message-ID: <CAJZ5v0jXccTBZOkzSMv38aMP7H5S5sR8viAoffqqHuENx1pGWQ@mail.gmail.com>
Subject: Re: [RFC v2 02/10] acpi/x86: s2idle: Move Modern Standby calls to
 s2idle begin/end
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 11:57=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> In Windows, the modern standby calls for sleep entry/exit and display
> on/off happen while the kernel device subsystems are active and the
> device is asleep. Currently, in the Linux kernel they happen in
> prepare_late, after e.g. the USB subsystem has turned off. This
> disimilarity causes obscure issues in certain devices that use these
> calls to turn off peripherals that should not be active during modern
> standby, e.g. handheld controllers, and RGB.
>
> Therefore, move these calls to _begin(), and _end() to match Windows.
> Particularly for _end(), introduce a acpi_s2idle_end_lps0() function to
> wrap acpi_s2idle_end(), matching the structure introduced with
> acpi_s2idle_begin_lps0().
>
> Of note is that unlike the ACPI ABI of LPS0, there is no device power
> state requirement before entering sleep/screen off, therefore it is
> appropriate to move these calls to _begin(), before s2idle suspend.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/modern-standby-states
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/acpi/x86/s2idle.c | 63 +++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 61a044b59776..f5aefba8b191 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -517,8 +517,10 @@ static struct acpi_scan_handler lps0_handler =3D {
>
>  static int acpi_s2idle_begin_lps0(void)
>  {
> -       if (lps0_device_handle && !sleep_no_lps0 && check_lps0_constraint=
s &&
> -           !lpi_constraints_table) {
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return acpi_s2idle_begin();
> +
> +       if (check_lps0_constraints && !lpi_constraints_table) {
>                 if (acpi_s2idle_vendor_amd())
>                         lpi_device_get_constraints_amd();
>                 else
> @@ -532,6 +534,24 @@ static int acpi_s2idle_begin_lps0(void)
>                         lpi_constraints_table =3D ERR_PTR(-ENODATA);
>         }
>
> +       /* Display off */
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> +                                       ACPI_LPS0_DISPLAY_OFF,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid=
);
> +
> +       if (lps0_dsm_func_mask_microsoft > 0)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
> +                                       lps0_dsm_func_mask_microsoft,
> +                                       lps0_dsm_guid_microsoft);
> +
> +       /* Modern Standby entry */
> +       if (lps0_dsm_func_mask_microsoft > 0)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
> +                                       lps0_dsm_func_mask_microsoft,
> +                                       lps0_dsm_guid_microsoft);

This is almost certainly too early at least for some systems out there.

While I can agree with putting ACPI_LPS0_DISPLAY_OFF here, I don't
quite agree with the other one.

> +
>         return acpi_s2idle_begin();
>  }
>
> @@ -545,36 +565,17 @@ static int acpi_s2idle_prepare_late_lps0(void)
>         if (check_lps0_constraints)
>                 lpi_check_constraints();
>
> -       /* Display off */
> +       /* LPS0 entry */
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> -                                       ACPI_LPS0_DISPLAY_OFF,
> +                                               ACPI_LPS0_ENTRY_AMD :
> +                                               ACPI_LPS0_ENTRY,
>                                         lps0_dsm_func_mask, lps0_dsm_guid=
);
>
>         if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
> -                                       lps0_dsm_func_mask_microsoft,
> -                                       lps0_dsm_guid_microsoft);
> -
> -       /* LPS0 entry */
> -       if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> -                                       lps0_dsm_func_mask, lps0_dsm_guid=
);
> -
> -       if (lps0_dsm_func_mask_microsoft > 0) {
> -               /* Modern Standby entry */
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
> -                                       lps0_dsm_func_mask_microsoft,
> -                                       lps0_dsm_guid_microsoft);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>                                         lps0_dsm_func_mask_microsoft,
>                                         lps0_dsm_guid_microsoft);
> -       }
> -
> -       if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> -                                       lps0_dsm_func_mask, lps0_dsm_guid=
);
>
>         list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node)=
 {
>                 if (handler->prepare)
> @@ -615,9 +616,19 @@ static void acpi_s2idle_restore_early_lps0(void)
>                                         ACPI_LPS0_EXIT,
>                                         lps0_dsm_func_mask, lps0_dsm_guid=
);
>
> -       if (lps0_dsm_func_mask_microsoft > 0) {
> +       if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
> +}
> +
> +static void acpi_s2idle_end_lps0(void)
> +{
> +       acpi_s2idle_end();
> +
> +       if (!lps0_device_handle || sleep_no_lps0)
> +               return;
> +
> +       if (lps0_dsm_func_mask_microsoft > 0) {
>                 /* Intent to turn on display */
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_TURN_ON_DISPLAY,
>                                         lps0_dsm_func_mask_microsoft,
> @@ -648,7 +659,7 @@ static const struct platform_s2idle_ops acpi_s2idle_o=
ps_lps0 =3D {
>         .wake =3D acpi_s2idle_wake,
>         .restore_early =3D acpi_s2idle_restore_early_lps0,
>         .restore =3D acpi_s2idle_restore,
> -       .end =3D acpi_s2idle_end,
> +       .end =3D acpi_s2idle_end_lps0,
>  };
>
>  void __init acpi_s2idle_setup(void)
> --
