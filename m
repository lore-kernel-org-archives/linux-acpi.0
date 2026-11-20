Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182414;
	b=1jEi5id233Gxn6d7r+xj396bKZACXfLoiHlH4BKf/pS+tvFNFUGTLs2pXPkhfRghzaMr
	 iPXcHfO9KDlL0itph9Jgd9cgBrX7bgM6IonZbToaZHrPR+izDTE4rFdi/6wmCkyk5Zr0N
	 P1B1qlRYGtXt5XmIMxPkcnlkEtm0cV1tSyeTy7wrqhlGgEw1XVV07A0PxC5MiwJP650n7
	 amn2gq76vx5shcL5EPTm5s4+16ZsCxraNbVibjC5i7NEuBAFHF2F0OjPekeIzuclXzXek
	 hwrIQnwHuEwmvJFnipI8vkdn2MZquY76IFGU7fhWrOnN9FKVhLuaIFoCATMGcrEYp+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182414;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=752YCVAyzFuu5Sp9aAshrd7utneGhM1dK2FP+3q8Ru8=;
	b=bDl1zMDu4JACKiARWbMprLIORMnpnWZ+//5ILuKCQHZs2oO10MWhZGTgruzH9rmo7BXl
	 JsRbtsarqJp9h2UtpFZCyqdFCFeHjPIkueYF2cQKcnkrf4P0BeG+w+8x67BesLdCzkVsD
	 kAN3/nvMOav/bHJC51UVDEq85kBtBObJlVo7Ij3LS08vS7I8PU13FTegCJR+kDrumBwUE
	 I6Gk+2YZGe5/WzDzgzciZD52w2A/KnzM2/A+2XgERcCalGmJAr2lsW1KRcvAEYHijtRUD
	 uYHK7xPWrLhh6YmqNFo4Iqc9KjZRIVpiU3eKz3VgiIXADu9ctEB8qxZQH+RmoBzd0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JNtoe/rT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593C606A320
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JNtoe/rT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E241F000CA
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182413;
	bh=752YCVAyzFuu5Sp9aAshrd7utneGhM1dK2FP+3q8Ru8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JNtoe/rTxqNpXYF9iOLgQWfGdSFQKO5lKb0i4AqpCKR80z8Tnv9Pv/WWkW/O7u1X2
	 lufjblysjJU6tb4VIDv4FSDHT4W8jQ/3Ark1X6ekB5pjf845tYeqsHt9ulN3dNP5Cs
	 a77A3ZkgSmmE37ckp2m/MSa++ldSmy1Q4ozqJxxTst9+9R2GUgM5n2FwX3DFNEb4qM
	 c8b38nEaQcH2MZNfZhedAIMxjqHl+t4bMMIAQqf2L6yAIqBNLj0xral1XVE3aLPWNo
	 6y58qJaG99+chxu9mJWK6f+Zx6acWXEs8ag7luF7Hfp1ePLAucxtv3h+1kpjjMIubd
	 S1GUdvOF7ELSw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c1c0c8d61aso507359e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 05:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFn20z/PYOFcIj1OtKVopB6ipkxkKSUpDcWLTGBAcqZCjQK98/R6HO7w2XPikHtAdtHgvVUklQhrnih@vger.kernel.org
X-Gm-Message-State: APuU4Z8gLtKx9/czIQJqVO9grLGAnZtaHAi6llNPHw8Q7X8MmD/wUW+y
	YRO07fhEs+MmqV+LEDecIp28ECfJeDhkp6Fh5kLtZaQg6Jskbt0W5JjdH55f/eIh7arOZiOdVe+
	E1p27bfILm2fOAXdz7TtAHkSOARKRyKo=
X-Received: by 2002:a05:6512:3a81:b0:5bf:b27e:3fac with SMTP id
 2adb3069b0e04-5c1bc822487mr1176868e87.57.1795182412322; Fri, 20 Nov 2026
 05:46:52 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116102642.15099-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20261116102642.15099-1-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:46:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUm6AweP4niRuoVUD9QmqEaj7v-CoUGybjcJoP+xjW4w@mail.gmail.com>
X-Gm-Features: Aa3M54o5Z7hpTBbbF25DzJd_bFkXBIqvGOEvRiqHSCKm-nxtnue3ZcbIGMtxRSY
Message-ID: <CAJZ5v0gUm6AweP4niRuoVUD9QmqEaj7v-CoUGybjcJoP+xjW4w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Remove unnecessary acpi_disabled check
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:26=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> As the comment explains the acpi_disabled check was there to avoid
> returning the error acpi_bus_register_driver() would return when
> acpi_disabled is set.
>
> But now that the ACPI button driver is a normal platform driver it calls
> platform_driver_register() instead which works fine with acpi_disabled se=
t.
>
> Registering the platform driver when ACPI is disabled is not a problem
> since no devices to which it binds will be created.
>
> Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one"=
)
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied as 7.5 material, but without the Fixes: tag because this is
not a functional issue AFAICS.

> ---
>  drivers/acpi/button.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 91a4e9698f7a..d8f3641b1a40 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -822,23 +822,12 @@ static int __init acpi_button_init(void)
>                         lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
>         }
>
> -       /*
> -        * Modules such as nouveau.ko and i915.ko have a link time depend=
ency
> -        * on acpi_lid_open(), and would therefore not be loadable on ACP=
I
> -        * capable kernels booted in non-ACPI mode if the return value of
> -        * platform_driver_register() is returned from here with ACPI dis=
abled
> -        * when this driver is built as a module.
> -        */
> -       if (acpi_disabled)
> -               return 0;
> -
>         return platform_driver_register(&acpi_button_driver);
>  }
>
>  static void __exit acpi_button_exit(void)
>  {
> -       if (!acpi_disabled)
> -               platform_driver_unregister(&acpi_button_driver);
> +       platform_driver_unregister(&acpi_button_driver);
>  }
>
>  module_init(acpi_button_init);
> --
> 2.56.0
>
