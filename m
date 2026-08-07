Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED733C1AD
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116726; cv=none; b=fNKTfk/yeJUsyCthp532Ba5zKXlz6KZ8Z34pJ4PfoPbA0LxI2MvBXzR1+n1chUwMg5zFI5OLoUOS5OP0a36U1vUh0+Zxt1zvPG+LeDqdTA/ldGoPXkj6DjDjze6k1dHamUdZoHNZ+YVGaSPflqYfUpv6rp/P5pj8Pzt4NQrTv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116726; c=relaxed/simple;
	bh=0Ua7+GDwlr2bqJfYRwuqX5uYgu3xS0ybJ+Z2qS7AX0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qo6PpMP3HVKvhHraBN4boxIHGBrDHp2JIbkOrefXBuR4URNJ76bbvwEzN9krAUNnQC0swAfZcHBRJAVfyLl+tYFoGt5Djng5a99F/CVOl1Ay6m+lT4fZL35iu+r0vn1hwOgjIAPVXGPaQvctDIRtYj0pPbLRbhsenXC8xClqm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMoIiip/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMoIiip/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A541F00AC4
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116725;
	bh=+G09DO7XOtGeiTQtlsOtMpyrrBBNAyV7TFtV+NSVamQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eMoIiip/iGQ100gQPf4Y1u2c405B7OJcvkMaq5FAsw4G807pXGUphgyDtQgH1xemT
	 DAusFYInjO6ZuiIldb/9hkbL5sBAveApIW+D3A4DYbaSyNvITx8cI1P7kG4Y5tzdWr
	 NT4958Hny8R/9X+qucHlpVpX7/deLy/4wmF/t3pS2vqijgWwqmcQaKd0RJ6V7jfzGM
	 tDEPQ6RSajET/0GB9v+1eED7TXqjyutLEwi+Xnp67BU5gXqwU723gdVuFCH+ZO/nvA
	 U/PnMzB55d6IzSn37JYJRh2YbNhJ55Y0SYEAKX/X5cL+SdLNNcM3+KSN/abiqqitQv
	 +JB4SGPtPUYBA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39f91ba1ef7so23735551fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 08:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPSAyGALKQJeqE/dnhwATQwoLh2m5vLPf5U57zNYwGXzU10/NKppvbwf270t473V792cfCuSzW4QLc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0hxQnJvAJy5rusmMN642n2KN3TwidrCBaks2quZezV7fMz7Z
	6GTEFjTFU3xze/n5cLGFGxk8VBkt+9m85vmwC46Ciw9rdiKUqkn+HCT5GJDpUOaSitB6tOdryOg
	L8ICcyG39n9PS1Htf022bJHLjHtsiV/w=
X-Received: by 2002:ac2:4429:0:b0:5ae:c7a2:69a8 with SMTP id
 2adb3069b0e04-5b30b78824cmr133212e87.44.1786116723651; Fri, 07 Aug 2026
 08:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807035453.948129-1-dbgh9129@gmail.com>
In-Reply-To: <20260807035453.948129-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 17:31:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbp-TwukgbvA=XBVTwYnePqo+SBSpUEUrrP6h4rRrc9A@mail.gmail.com>
X-Gm-Features: AUfX_mwdftLqOaxurPNw5U7u9YZbVXWV_RxiMKVO_-tujkHN7hf6so-b24sXfMI
Message-ID: <CAJZ5v0gbp-TwukgbvA=XBVTwYnePqo+SBSpUEUrrP6h4rRrc9A@mail.gmail.com>
Subject: Re: [PATCH v1] PNP: Release protocol device on registration failure
To: Yuho Choi <dbgh9129@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:55=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> pnp_register_protocol() adds a protocol to the PNP list before calling
> device_register(). If device registration fails, pnp_remove_protocol() on=
ly
> removes the list entry and leaves the device-core reference acquired by
> device_initialize() held.
>
> Give static protocol devices a release callback and drop the reference on
> registration failure. Also stop PNP ACPI device enumeration when protocol
> registration fails, instead of using an unregistered protocol device as a
> parent.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/pnp/core.c         | 9 ++++++++-
>  drivers/pnp/pnpacpi/core.c | 7 ++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 81603327079c..fc3bff43fdd8 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -23,6 +23,10 @@ static LIST_HEAD(pnp_protocols);
>  LIST_HEAD(pnp_global);
>  DEFINE_MUTEX(pnp_lock);
>
> +static void pnp_protocol_release(struct device *dev)
> +{
> +}
> +
>  /*
>   * ACPI or PNPBIOS should tell us about all platform devices, so we can
>   * skip some blind probes.  ISAPNP typically enumerates only plug-in ISA
> @@ -66,14 +70,17 @@ int pnp_register_protocol(struct pnp_protocol *protoc=
ol)
>
>         protocol->number =3D nodenum;
>         dev_set_name(&protocol->dev, "pnp%d", nodenum);
> +       protocol->dev.release =3D pnp_protocol_release;

Sashiko complains about adding an empty release callback here and IMV
it has a point:

https://sashiko.dev/#/patchset/20260807035453.948129-1-dbgh9129%40gmail.com

>
>         list_add_tail(&protocol->protocol_list, &pnp_protocols);
>
>         mutex_unlock(&pnp_lock);
>
>         ret =3D device_register(&protocol->dev);
> -       if (ret)
> +       if (ret) {
>                 pnp_remove_protocol(protocol);
> +               put_device(&protocol->dev);
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index fbf03ff007eb..da0ebc378696 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -298,12 +298,17 @@ static acpi_status __init pnpacpi_add_device_handle=
r(acpi_handle handle,
>  int pnpacpi_disabled __initdata;
>  static int __init pnpacpi_init(void)
>  {
> +       int ret;
> +
>         if (acpi_disabled || pnpacpi_disabled) {
>                 printk(KERN_INFO "pnp: PnP ACPI: disabled\n");
>                 return 0;
>         }
>         printk(KERN_INFO "pnp: PnP ACPI init\n");
> -       pnp_register_protocol(&pnpacpi_protocol);
> +       ret =3D pnp_register_protocol(&pnpacpi_protocol);
> +       if (ret)
> +               return ret;
> +
>         acpi_get_devices(NULL, pnpacpi_add_device_handler, NULL, NULL);
>         printk(KERN_INFO "pnp: PnP ACPI: found %d devices\n", num);
>         pnp_platform_devices =3D 1;
> --
> 2.43.0
>
