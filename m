Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426D56E056
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965148; cv=none; b=f2Q4fwgRwIKBRsFBpzvXueZKOB1IeD+naSo6SUHxwZHxoNlDBz4PxZb0QH1TXre+OCkdbNGgR68zPjBU3jAgqnphdLNI0NUXwIBlbkSyD0eMSEwlNiU2abRpgPP6dVMza0aCjqj8zNcY2ZiJeNd1ql/oxG/P/59X3OYeGV044Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965148; c=relaxed/simple;
	bh=cUiIRYQL1jbuM3Apocj0lbpCttRoc41bzAzZJ7CuVHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtlR5jk7ax5D/lseI/F4KeqzNinuJKonLy3OtMmDA9B3hJSCMbQAT21ShtrRxjMbq/sHm242KVCiO7mgN+nXaoqvEFujPXMnu8LAJ71PU6Lev40O28BT7Lf/8ozUGgI4OSz88v+gonTZzXWMq0FfjDrgvM1k/KLte4axe4Fq8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeUakYx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeUakYx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4AC1F00A3D
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965147;
	bh=6qAIkeaXELitgGo5KRgF3ZOS5HrR0K2OEuxNRcYKfWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jeUakYx8ACGYA6kI5dBrEDuBu69NLuPEb6q4rMiIpenhrnxV75lU82mB+rJPfhRFC
	 9IVO1BCW7AgM+2FXrk6zcFpMhoOmxZimQvuULiwq9GpzTaLFsjutwtJ0TLZBdjBZqa
	 Y1Da8mBRe9vvIwgIMEMF5OTRtkXPfn2q+Z5VibRUoqQ9ASsnGmkXUNO09J6QkrpFOk
	 z6Nsg4TjaNAd8/JNbb9eURMx0KCGB/JekRfYomI+W0aCSOxOxPM1RgeSuYpUWKpoc0
	 DcbIWxuXfcMzBzQOLghBsYe6xGcbDCgnOtmqJpjCry5E5mhz8Mrd9kAalcPpFXfhuK
	 izYK3rci2Td6A==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso308752e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:45:47 -0700 (PDT)
X-Gm-Message-State: AFuF++kOQWNGLXSBWXnwFwxUfMY1j9J60R8Zf0ZDBOYkczB3QGrwTo4D
	KLgoC0IVE3RRqSFk/zf+RIK3ADYOs0M53JbRAhcEiF+34zkI1Iv3wN03YEseclSewHb7nDuMTzW
	6f2FKUIj2KXAFMYpFeJJRzs8x35Cz59k=
X-Received: by 2002:a05:6512:ac7:b0:5b6:19e9:faee with SMTP id
 2adb3069b0e04-5b898100df8mr680776e87.7.1788965145630; Wed, 09 Sep 2026
 07:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820031253.1636952-1-triet.hoang.dev@gmail.com>
In-Reply-To: <20260820031253.1636952-1-triet.hoang.dev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:44:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBR1Y+exJN0gg1L5GqjMwxLUPu+GWHHJzbLctoFLFNCA@mail.gmail.com>
X-Gm-Features: AcwNN1VwvSs2Tv5vesFrvXTCXoyUzEzygRHUBmSinL5h5vFgI1z3PuFZXGj6KO4
Message-ID: <CAJZ5v0hBR1Y+exJN0gg1L5GqjMwxLUPu+GWHHJzbLctoFLFNCA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: use DEFINE_SIMPLE_DEV_PM_OPS
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:12=E2=80=AFAM Triet Hoang <triet.hoang.dev@gmail.=
com> wrote:
>
> Convert the deprecated SIMPLE_DEV_PM_OPS
> to DEFINE_SIMPLE_DEV_PM_OPS
>
> Also use pm_sleep_ptr() when assigning the ops to the driver.
> This allows the removal of the ifdef CONFIG_PM_SLEEP.
>
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
>  drivers/acpi/ac.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index f19d6dd43473..eef0c8e32d73 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -239,7 +239,6 @@ static int acpi_ac_probe(struct platform_device *pdev=
)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_ac_resume(struct device *dev)
>  {
>         struct acpi_ac *ac =3D dev_get_drvdata(dev);
> @@ -253,9 +252,8 @@ static int acpi_ac_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif

And the function above is going to be unused when CONFIG_PM_SLEEP is
unset, causing the compiler to complain AFAICS.

> -static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
>
>  static void acpi_ac_remove(struct platform_device *pdev)
>  {
> @@ -270,7 +268,7 @@ static struct platform_driver acpi_ac_driver =3D {
>         .driver =3D {
>                 .name =3D "ac",
>                 .acpi_match_table =3D ac_device_ids,
> -               .pm =3D &acpi_ac_pm,
> +               .pm =3D pm_sleep_ptr(&acpi_ac_pm),
>         },
>  };
>
> --
> 2.53.0
>
