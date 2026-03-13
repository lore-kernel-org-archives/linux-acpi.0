Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4E369223
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434168; cv=none; b=DWhrUASt2ChgPUKKvj+6Sgqq5NfOmEEu7o4swjF3r3NiHjvTLmisQVKhUj4FZHT0kTGoe77EJfNrWH2KI2++MvpAhjbdxoTvO6t8C3AL11mTBQvQCBDBIRdf2fCBNjJdWPAUBrbsrRu94yEr8FBwoP9Kzqjxr0YS3UcOsJBi3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434168; c=relaxed/simple;
	bh=7ShzbUKEWa2pMm5LdMtCprVT8Y0BmpKIFLvodmhoVRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG4gt8nU96xJkq+PSoXeDlEAm/BpOxMfGTpUrJ24IJCblpoA80EtjIG3lL5QL2bTYlRklcXzy6VNT8BCzvfFmgUQ+I5cogqk6sgvYTIezWiFeT0xze61/LXS9wixdXWuzy0poOumgqihAYlkivMGgu0bDrGaoEKYpdcVBBdCVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny99/rxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny99/rxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565E7C2BC86
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773434168;
	bh=7ShzbUKEWa2pMm5LdMtCprVT8Y0BmpKIFLvodmhoVRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ny99/rxX3A/ucqJy1bZsMIRYDeGGlpTrKZ97m39aLT/d0rTU2OlvZYYDvvb8E9IfB
	 5G6u+m04lg0/1xXfnvxgIm6+v3v9J7HZRNchR4zlm3TsyKQplDuPVqZSWkIW3YXKZl
	 gzc5RjiY6JWTVk67aSypCcq6FOHNhKgwmpX0gqtqMlGUoW6/Q+gRLZ8r+kx9psNbKS
	 wLMTPAlL9RD1JuKCJ2dzDQP6F4Y+RbRmYP8hFTzojaNwET2gNx05oHKrAxR16BQ1ol
	 P4wstrx0sP+f8czvniNbOfugehIDuQ2xAvQHsVJ/tLqikRo7TH9xvKyykXU+/oz37/
	 5ajoa7+UqD6mA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7422b4ff1so1191116a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 13:36:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4cRaPkX/w4qtM0K4mbsCM8DYBi7glD42ksF1iA4dJfoQ3nZM+F25MVp9w4OqxwFxzwHBfMPATNU7M@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkNfR+d1zZRmur0sl/Xj9ph4bW/7PZdGbI9IZmJubs4upnp6Q
	0JIK+EwUOmBPfpG5oQdJATLHWueyubeV9F21Xf5tP+dVtMvhlnaUWrzzAlewERRdDR5FsIqFvvz
	xitF6C0aeTV7tNB3x33ODKHPGFtfJIdo=
X-Received: by 2002:a4a:ec49:0:b0:67b:b6be:7fee with SMTP id
 006d021491bc7-67bda9b4a50mr2738225eaf.22.1773434167407; Fri, 13 Mar 2026
 13:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2277493.Mh6RI2rZIc@rafael.j.wysocki>
In-Reply-To: <2277493.Mh6RI2rZIc@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 21:35:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5bhEHau2siLmeBxX-X9yxxT9x6oH8AsCXF+G0B+srtA@mail.gmail.com>
X-Gm-Features: AaiRm53dxR7r-zpe3_talVdMAyWyymTCAlVLASn2LviCyEvx-wUlSIBpeGC9EhE
Message-ID: <CAJZ5v0j5bhEHau2siLmeBxX-X9yxxT9x6oH8AsCXF+G0B+srtA@mail.gmail.com>
Subject: Re: [PATCH v1] sonypi: Convert ACPI driver to a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the sonypi ACPI driver to a platform one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1=
]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/char/sonypi.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
> index 677bb5ac950a..ccda997a9098 100644
> --- a/drivers/char/sonypi.c
> +++ b/drivers/char/sonypi.c
> @@ -1115,15 +1115,17 @@ static int sonypi_disable(void)
>  }
>
>  #ifdef CONFIG_ACPI
> -static int sonypi_acpi_add(struct acpi_device *device)
> +static int sonypi_acpi_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +
>         sonypi_acpi_device =3D device;
>         strcpy(acpi_device_name(device), "Sony laptop hotkeys");
>         strcpy(acpi_device_class(device), "sony/hotkey");
>         return 0;
>  }
>
> -static void sonypi_acpi_remove(struct acpi_device *device)
> +static void sonypi_acpi_remove(struct platform_device *pdev)
>  {
>         sonypi_acpi_device =3D NULL;
>  }
> @@ -1133,13 +1135,12 @@ static const struct acpi_device_id sonypi_device_=
ids[] =3D {
>         {"", 0},
>  };
>
> -static struct acpi_driver sonypi_acpi_driver =3D {
> -       .name           =3D "sonypi",
> -       .class          =3D "hkey",
> -       .ids            =3D sonypi_device_ids,
> -       .ops            =3D {
> -                          .add =3D sonypi_acpi_add,
> -                          .remove =3D sonypi_acpi_remove,
> +static struct platform_driver sonypi_acpi_driver =3D {
> +       .probe =3D sonypi_acpi_probe,
> +       .remove =3D sonypi_acpi_remove,
> +       .driver =3D {
> +               .name =3D "sonypi_acpi",
> +               .acpi_match_table =3D sonypi_device_ids,
>         },
>  };
>  #endif
> @@ -1518,8 +1519,8 @@ static int __init sonypi_init(void)
>                 goto err_free_device;
>
>  #ifdef CONFIG_ACPI
> -       if (acpi_bus_register_driver(&sonypi_acpi_driver) >=3D 0)
> -               acpi_driver_registered =3D 1;
> +       error =3D platform_driver_register(&sonypi_acpi_driver);
> +       acpi_driver_registered =3D !error;
>  #endif
>
>         return 0;
> @@ -1535,7 +1536,7 @@ static void __exit sonypi_exit(void)
>  {
>  #ifdef CONFIG_ACPI
>         if (acpi_driver_registered)
> -               acpi_bus_unregister_driver(&sonypi_acpi_driver);
> +               platform_driver_unregister(&sonypi_acpi_driver);
>  #endif
>         platform_device_unregister(sonypi_platform_device);
>         platform_driver_unregister(&sonypi_driver);
> --


If anyone has any objections or  concerns regarding this change,
please let me know.

In the absence of any, I'll queue it up for 7.1.

Thanks!
