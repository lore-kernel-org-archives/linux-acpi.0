Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A548579812
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965302; cv=none; b=ZyrhrWJqEtrGK+JtXFPlfxqkoQs1uSQB632zZ/A+BfPl+twOZS5taW5bs0DC7PVdgjS8L+TDVm2tBXhl1p4yRFcW+vJqwQkBTZgCHT2Ysu+MdJ3hqhR1Ign8q+lRtmUlBG0DbBzYGnMvM9jX+G7ET38ndGWT03vZ+/tg76XWggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965302; c=relaxed/simple;
	bh=SoWe4XDLLneiNldftimsQNnBplrAFFWx4n5mTvWlLeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqGTUZYLo9oit+TE1MwjSXGNz0p9zBVuYURBYbpc1U5/VrL0xdb176S5ZirRMlhHIJQICF4cXGL+RjKraA3EPTSOLsFX/Gkk+HW1SxduSSQyFBILXDjFklUm0W7ab37cPVNm6F8Cntjc9X7GN/loh5JrAhggNC85Ntdia3y8vDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkHt4pwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkHt4pwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A11F00ACA
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965301;
	bh=6KCL6qY2IiSfBzoydX0rsP5u/mEDjQaNr8NglV8uPMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RkHt4pwDMWmFc19MTfHAy6htYA6SPctwfS1lj0+uEDA6c7B95C29K6JQ/7geNn91i
	 0rj6QgDekwlHGTot2D5Y6tJ0qDC1O69RFQ8sZMt9jYU6f2N1LZGcAPvME9l40IBgeg
	 GFZBAwQaq7ujE9WwYd0LGJYj1yJs1oZSFll0jmQL1PGtFLD1N0T0txGb1aPAB1IJ+q
	 lCYm66cCdvMQeqsX1Nf/7Awrdlu3wAuf3WOCVpuDeyK5Wm/BxCUuWWWzGQoCn1vqg7
	 j56k1mwldZZG3+KwKw2VCuH3e+DT3bZ1u0f+DZC3ozQfGe6HY2Y/FxPjP/ydVbfYVm
	 q9SPFdXyBzB7g==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso4471631fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwV2m8MZiR+QzAEHWgtKY3LIDR6K01FfGuocGGEE2Oj0rRmmkbjOReF/2hAclRMGu7iBPPQgJuRU3ut@vger.kernel.org
X-Gm-Message-State: AFuF++nrGoiBphew1OgyEd20oifsG90dm1rUrGUEWmOAu5usC91J7YkY
	H1h/lUMX+ssOJnRgzorRuEQPoOODuIpCD1FnRKIA68lOlsN78wYEqSvWyQ1qoQbPoi9LKwZq72W
	UIPSuSTQqXNk8mUM3PD8BeBtkY+1TRV8=
X-Received: by 2002:a05:651c:19a9:b0:3a3:1674:a814 with SMTP id
 38308e7fff4ca-3a58d33e002mr3464211fa.2.1788965299489; Wed, 09 Sep 2026
 07:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820033653.1682804-1-triet.hoang.dev@gmail.com>
In-Reply-To: <20260820033653.1682804-1-triet.hoang.dev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:47:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNLspde-oi9Bi+LKT_NbpSYCLmdqUSkNvKS_kgFnB90g@mail.gmail.com>
X-Gm-Features: AcwNN1WWb7xCM6B2UGqkPyo4D4Aw-LeWGyzimjdPKCb4wk0gHbWh1Trh9ik8m7M
Message-ID: <CAJZ5v0gNLspde-oi9Bi+LKT_NbpSYCLmdqUSkNvKS_kgFnB90g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: use DEFINE_SIMPLE_DEV_PM_OPS
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:37=E2=80=AFAM Triet Hoang <triet.hoang.dev@gmail.=
com> wrote:
>
> Convert the deprecated SIMPLE_DEV_PM_OPS
> to DEFINE_SIMPLE_DEV_PM_OPS
>
> Also use pm_sleep_ptr() when assigning the ops to the driver.
> This allows the removal of the ifdef CONFIG_PM_SLEEP
> and unnecessary forward declarations of 4 functions.
>
> No intentional functional impact.
>
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
>  drivers/acpi/button.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 3836ee75dd66..d4cb942b754f 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -147,28 +147,6 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>         {}
>  };
>
> -static int acpi_button_probe(struct platform_device *pdev);
> -static void acpi_button_remove(struct platform_device *pdev);
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int acpi_button_suspend(struct device *dev);
> -static int acpi_button_resume(struct device *dev);
> -#else
> -#define acpi_button_suspend NULL
> -#define acpi_button_resume NULL
> -#endif
> -static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_butto=
n_resume);
> -
> -static struct platform_driver acpi_button_driver =3D {
> -       .probe =3D acpi_button_probe,
> -       .remove =3D acpi_button_remove,
> -       .driver =3D {
> -               .name =3D "acpi-button",
> -               .acpi_match_table =3D button_device_ids,
> -               .pm =3D &acpi_button_pm,
> -       },
> -};
> -
>  struct acpi_button {
>         struct acpi_device *adev;
>         struct device *dev;             /* physical button device */
> @@ -491,7 +469,6 @@ static u32 acpi_button_event(void *data)
>         return ACPI_INTERRUPT_HANDLED;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
> @@ -521,7 +498,6 @@ static int acpi_button_resume(struct device *dev)
>         }
>         return 0;
>  }
> -#endif

And the function above is going to be unused when CONFIG_PM_SLEEP is
unset, causing the compiler to complain AFAICS.

>  static int acpi_lid_input_open(struct input_dev *input)
>  {
> @@ -753,6 +729,18 @@ static void acpi_button_remove(struct platform_devic=
e *pdev)
>                 acpi_lid_forget(button->adev);
>  }
>
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acp=
i_button_resume);
> +
> +static struct platform_driver acpi_button_driver =3D {
> +       .probe =3D acpi_button_probe,
> +       .remove =3D acpi_button_remove,
> +       .driver =3D {
> +               .name =3D "acpi-button",
> +               .acpi_match_table =3D button_device_ids,
> +               .pm =3D pm_sleep_ptr(&acpi_button_pm),
> +       },
> +};
> +
>  static int param_set_lid_init_state(const char *val,
>                                     const struct kernel_param *kp)
>  {
> --
> 2.53.0
>
