Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26203A6F0A
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116661; cv=none; b=oGW81RWW9ShWkWGRGojuSZPc2mwknTzzqLrh7CB/M5TuGm17pR3+sJSemFJfgRx0r7wcCGwVK1HtIxtKIWb4F2cWZUKSfI9c6WtoVcgMHbUxJA1vEx3TwPfXv2et+0f8q1Dtn3LwOWjGdjqv4NUKcCLLUzR5xWsIbp9oSncUlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116661; c=relaxed/simple;
	bh=J/X9S5mHRkBZqjiBC2mztY0guIjZaDc5I5e/LwjNRtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhCLlGgATVZObWxgOkOFo25uX9LuXdVbjWQWsLd3VuQTjJ1A1GsFsrvb583tw8rQO2XnEgYL4FzrsM5YJZOTK3JouaqM0vCdDWb/g29EPICqI2U814LrKQWjv6oxGp42vgFxV7t7se1oGBLdGMosviV9EMLlbKpMY3CdfSVwBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNGuZzVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNGuZzVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8151A1F00A3D
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116660;
	bh=RLXgL/vXT2/LzkqZHzqAvFRxe67NW5e1tLWzzIAoLYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nNGuZzVPZcqi1JCJFAn+03TF08Ihckf1P96eiEOOoh+s1YoRdDNXQvS9Goh9FpQCc
	 lG40gzeXJ8xsmXP+XtTEfhR5s9SZY+ei1vEAbPXaqztjURMd0sSrcqnxG6qAycYIIy
	 UkIJeTWPhhFi+DoM/E5ZCToKX2iu5fzgqqkPxy7bMHdTQO9ZaaekYJBCVJWK1uLBcE
	 pDJxypATmXM49O+0iW9WZJXJkvkvO8p/QGzikYCwt24tyHfU8xDU1Kf82oHdhniS48
	 LQe25CV4GeLqlC3YpFg+q7Udij9e7uANycRtpRISNISJ+cCl3b4+B7yjf2ugdU5rFe
	 kgJzjosmviEdA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39f75e0a2f1so24808341fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 08:31:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrThLiYo3X17bgScdT9XJS21dUW1Il7bi9zE3ca+yKxh+k23MO4ngC3mp2yjd17YMVObV5LS2yzjcRO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/HtaptM19trck+EMWDe/R6n3CClQGhp4aBbisA11jX+7w8Ga
	QwIacyxm1KWz8Fpvi5NxG6Vm25FReTwVFf7IE+u1helc67din1FOoDTqxSV2q+1r6N7e5YnDmYK
	XWmPUCHImxVF6RyYSECX0LH9RQB4uPf4=
X-Received: by 2002:a05:651c:b2a:b0:39a:cfe9:2482 with SMTP id
 38308e7fff4ca-39fbb2d1d60mr26755321fa.31.1786116658978; Fri, 07 Aug 2026
 08:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807015734.913361-1-dbgh9129@gmail.com>
In-Reply-To: <20260807015734.913361-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 17:30:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUAA2xZbe=_ZeGsskeXQ4DS=s0AamDc4776BvH9QFuYw@mail.gmail.com>
X-Gm-Features: AUfX_my1DT7IwIH5M6FQdEXyGK_eortWGfVB_TKgUbUuaWBEusfgvaTFfh9Q-Qo
Message-ID: <CAJZ5v0jUAA2xZbe=_ZeGsskeXQ4DS=s0AamDc4776BvH9QFuYw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: video: Release PCI device reference after lookup
To: Yuho Choi <dbgh9129@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:57=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> video_detect_portege_r100() uses pci_get_device() only as a boolean
> check for the Trident CyberBlade XP4m32 device. pci_get_device() takes a
> reference on a matching PCI device, but the callback returns without
> releasing it.
>
> Drop the reference after selecting the vendor backlight quirk so the PCI
> device can be released normally.
>
> Fixes: 35a341c9b25d ("ACPI: video: Add acpi_backlight=3Dvendor quirk for =
Toshiba Port=C3=A9g=C3=A9 R100")
> Assisted-by: OpenAI-Codex:GPT-5
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/acpi/video_detect.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 458efa4fe9d4..4c1c3b0b5499 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -137,8 +137,10 @@ static int video_detect_portege_r100(const struct dm=
i_system_id *d)
>         struct pci_dev *dev;
>         /* Search for Trident CyberBlade XP4m32 to confirm Port=C3=A9g=C3=
=A9 R100 */
>         dev =3D pci_get_device(PCI_VENDOR_ID_TRIDENT, 0x2100, NULL);
> -       if (dev)
> +       if (dev) {
>                 acpi_backlight_dmi =3D acpi_backlight_vendor;
> +               pci_dev_put(dev);
> +       }
>         return 0;
>  }
>
> --

Applied as 7.3 material, thanks!
