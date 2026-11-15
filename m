Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762421;
	b=ZwR12eKl8fVhMxZH3HYMrh7J3yBZ56YfSrzxXzIF0Y5Pjk5a8V3NQIUeuY9evjOJNLhF
	 c9fHB3Muhl8qxEfcqMqqbIF+ew1+NBp/v2fLfri8WlXgA+E76EOpDTiSEoNVEKSDRbjD+
	 q6kQyjiPVFV/uhWlAuARSycmaEDOiMqZ28U959oYLN/dfIlqUwMzo8PyAQK1CuUoF27Oo
	 HAJhJUv1hYautWzBD2ngJngL8vOVYThRi4TCGPe/DYBp5NTziF3jIWcD0zpdXOLDlCFHp
	 9PVE5zcy0hGjhc8OK74g+vZ45FfH0ThVfinYBvWnjVN/FPUqWTfTEDJw8JyGmbqvRCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762421;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=94l3N9AWBADZVlj1Q/uea2ritj8vF6vyqwsDKMg7bls=;
	b=RaLTu0HUOAyAEmh0KsmMzFh6Pt3CzVgHpr0SOvJ8uL7XqFJCorj8+Utt22LsaZejWbHQ
	 I4TIlzczIWZ3kq5b+yZXwmMg+47nTMmA27FZoGGrxyiU6aAcoVzsLqCWwgz6C/xY9TsFw
	 5StjuYQDHMi3yRE59rGf+3FyNd9cGHVhd/zwCiZM6xxfjzLygGKERBXgskpACulMV2JZq
	 Gk6kFx9FV+Tof56Q8QjhC9AQ0LxgX/6hFd6N39Df/bswMpSDeqR0nM4XLppI6cDqzcgLl
	 zLRSBBrsE+i44krpCVLAdx4Dy6ShD95imP3AbYpwwGMlLeYrd/NUCdktSAHw9/yEong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3pJ73Lj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E9606A31E
	for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3pJ73Lj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413701F000C8
	for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794762421;
	bh=94l3N9AWBADZVlj1Q/uea2ritj8vF6vyqwsDKMg7bls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A3pJ73LjdREijtEM8PpzpLcnagufO0XvuKAPCVVqv6qXZUveQOEN3VlrZu7PXq9KA
	 WRsK0Od/OeiQgz+gKc36Ekztx48AArPysXXpOCk1G5Ww99NzQ79fowPBjCLerDhI/p
	 y6YaALTmEis1m60RhWIUXz8PoRQjWr0V2NPgox43P3wWV0rqX9H3K5ahqLJMIxWRoB
	 znPT44qaTVlkt5Dit/TaTDlTv3wdV6/UXcU1g5wl2588gFZtf8bdO0NSY7lV62rmCG
	 P1VOQwkgDr7fVTgcHHG1fAqpQxzgNUHDA5Efv9Qt4jBD/kk5yJb2pFjpCgWBL3aDff
	 2urqqBgU9Rwxw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c17a1775fcso1394639e87.3
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 09:07:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErENIdJQu7VJJa2AmkwRAvJ331QXVO7rUFz4PpaZV8E2kdXHSegNIXCMgS1+0/jjF7sLAMN4bAse4ZdZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9aBtXiuj7OLqPaJjA2AQPX6Af2oeGb8bhCulBEmSA6zBZ+1Sjc
	GCZWBclvYVEmywGFZOSwBp5Wydjizklxj80EV3pRrlqsjpHLQGwwVlA0WskHEtUcqZR+yGE0RbO
	IY+fVOOdpLDZb8cOJu84v/k0/9aSN3M8=
X-Received: by 2002:a05:6512:220b:b0:5bf:d226:8c41 with SMTP id
 2adb3069b0e04-5c170b365bdmr3199074e87.29.1794762419642; Sun, 15 Nov 2026
 09:06:59 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115091221.2217-1-lirongqing@baidu.com>
In-Reply-To: <20261115091221.2217-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 15 Nov 2026 18:06:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hBVwOksptV2ThK9iCpHbSZDh0Z+R3dtojCtkze4_0eQg@mail.gmail.com>
X-Gm-Features: AclHuK9XPcUJ0mrDHIaDue0lT0yDTr2aABBQOGeL_rqJ2XyI8JCYu-HCtCU78iE
Message-ID: <CAJZ5v0hBVwOksptV2ThK9iCpHbSZDh0Z+R3dtojCtkze4_0eQg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ACPI: Check the found handle in acpi_get_rc_resources()
To: lirongqing <lirongqing@baidu.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:12=E2=80=AFAM lirongqing <lirongqing@baidu.com> =
wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> acpi_get_devices() returns AE_OK even when the namespace walk finishes
> without a match, in which case the return_value argument is not written.
> The caller passes an uninitialized acpi_handle and hands it to
> acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.
>
> Initialize the handle and reject a missing match.
>
> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64=
 platform")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: add fixes tag
>
>  drivers/pci/pci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e260089..e90e749 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -82,7 +82,7 @@ int acpi_get_rc_resources(struct device *dev, const cha=
r *hid, u16 segment,
>  {
>         struct acpi_device *adev;
>         acpi_status status;
> -       acpi_handle handle;
> +       acpi_handle handle =3D NULL;
>         int ret;
>
>         status =3D acpi_get_devices(hid, acpi_match_rc, &segment, &handle=
);
> @@ -92,6 +92,9 @@ int acpi_get_rc_resources(struct device *dev, const cha=
r *hid, u16 segment,
>                 return -ENODEV;
>         }
>
> +       if (!handle)
> +               return -ENODEV;

acpi_fetch_acpi_dev() will return NULL if handle is NULL, won't it?

> +
>         adev =3D acpi_fetch_acpi_dev(handle);
>         if (!adev)
>                 return -ENODEV;
> --
