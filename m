Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5A441619
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036449; cv=none; b=k9zQZQetZB1z4bR7Hmc1i8yMBjTCCsWgfaSCgc32XfGl0WjYEEOOvnEJKmJa9/72v4CPwyQJpmekAqGKwXIBl/Q4RfSwAA9iAMcBxrWNeVjh9bdDhJuL7GhvVpc79jyR3V4CqXiWUs+ZMOn68iTyGXU5r0ukY/ErvPPVj/HR8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036449; c=relaxed/simple;
	bh=33jkVe2HyER1KO59xgKnh/ZHAIOHMiqD2aY62iDLQS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3ps/V/2KNO6YLsPTIIkiNmcZF8aQ8k9I23+Wuut1L5mukONZKXPgZEMsvnHJS7fGWS85WTSnA47C620yq6aB9XfZHbYnPqvLK8RCHvsRBd//vzPtcZuDF7bsUkeEiw6kqnsdCPhXWxh1o4+U20GsNkH7sVJA33g8rY0M2DA9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKZWTfyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKZWTfyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58D91F000FF
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036443;
	bh=GAZZaPXaI4qR9j5XZrEpQl1g16i8xS5CY+gqIZgfW7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PKZWTfyxUVK+JSVheY/XlnwNmz12bkGz8KjVY2O+yTLTJaIqkVUJb49Gv0bQzPYs7
	 F3eu1wD3EADcuVbOZNBQWdRVOAUL3loKlbXtLlMjcbmzBmRy4RPDI/UZM4X5MKD2EN
	 UzZmJXiAbL6CwI0AunfK3Fsgqe+Bo17Y2GfaLEKrKthvOPFWcHW5dZCW3oBAV8CSP6
	 dkVL6uCpJ9WLv5cfP//xeUp4IwL6ceGuPm2ccHSquP3Uy+eeOUxBCjXAkhw117o0Wd
	 xxoLkMwI1cSZmP7k++kggJza1vc1gyHR6AefKrLQNOIXvt6VvpUMEWJBjZ+P/W0fCL
	 XAcw7DifMiJag==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b7a9882e19so1672079e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 03:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJ3H2JIGLMLs8hftCOeUIKFBHDAgrnHKNEWZPANoSpMn3lrAOlErfMNX204qC5nWPhLxt+NeQrFXWe@vger.kernel.org
X-Gm-Message-State: AFuF++muEWCO59TTX18oa9uF3OMhaYJLfXTLv+Sw1CPKlSYL3B04512o
	iV97uhxg3zT3H/+2V0Cmi6H/vJphtK1hWXWGEQyKjNdYKLvZ0IgNgTAlbcfnCGdRTDlVNLBsACH
	5zeZzirbO/nnuGh0jwRUQ7WnEOJnmh+c=
X-Received: by 2002:a05:6512:3b2a:b0:5b6:1a7c:aa12 with SMTP id
 2adb3069b0e04-5b61a7cac2bmr6965561e87.42.1789036442198; Thu, 10 Sep 2026
 03:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910014953.187180-1-lijun01@kylinos.cn>
In-Reply-To: <20260910014953.187180-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 12:32:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gkhGdyoQ6t7yjY8LWJd12zVb9P1Ep3W1+kL48B=BgS5A@mail.gmail.com>
X-Gm-Features: AcwNN1WJbCNUuh2M8BAfLcBb0rRYEc6CB3Lj1-tmNZaURwYYeSOfFW69r5n1ToY
Message-ID: <CAJZ5v0gkhGdyoQ6t7yjY8LWJd12zVb9P1Ep3W1+kL48B=BgS5A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: button: replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:50=E2=80=AFAM Li Jun <lijun01@kylinos.cn> wrote:
>
> Replace `SIMPLE_DEV_PM_OPS` and `#ifdef CONFIG_PM_SLEEP`
> boilerplate with the modern `DEFINE_SIMPLE_DEV_PM_OPS()`
> macro in the acpi_button driver.

So again, this is not a replacement as it actively makes the kernel
waste memory in certain configurations.

> Signed-off-by: Li Jun <lijun01@kylinos.cn>

I guess my previous comment that I didn't see any point in making
these changes was not clear enough.

I'm not going to apply this.

> ---
> Changes:
> -Add pm_sleep_ptr for acpi_button_pm in acpi_button_driver.
> -Fix the warning:
> >> drivers/acpi/button.c:164:12: warning: function 'acpi_button_suspend' =
has internal linkage but is not defined [-Wundefined-internal]
>      164 | static int acpi_button_suspend(struct device *dev);
>          |            ^
>    drivers/acpi/button.c:167:49: note: used here
>      167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_su=
spend, acpi_button_resume);
>          |                                                 ^
> >> drivers/acpi/button.c:165:12: warning: function 'acpi_button_resume' h=
as internal linkage but is not defined [-Wundefined-internal]
>      165 | static int acpi_button_resume(struct device *dev);
>          |            ^
>    drivers/acpi/button.c:167:70: note: used here
>      167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_su=
spend, acpi_button_resume);
>          |                                                               =
       ^
>    2 warnings generated.
> ---
>  drivers/acpi/button.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..1df7e268c4dd 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -161,14 +161,10 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>  static int acpi_button_probe(struct platform_device *pdev);
>  static void acpi_button_remove(struct platform_device *pdev);
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev);
>  static int acpi_button_resume(struct device *dev);
> -#else
> -#define acpi_button_suspend NULL
> -#define acpi_button_resume NULL
> -#endif
> -static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_butto=
n_resume);
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acp=
i_button_resume);
>
>  static struct platform_driver acpi_button_driver =3D {
>         .probe =3D acpi_button_probe,
> @@ -176,7 +172,7 @@ static struct platform_driver acpi_button_driver =3D =
{
>         .driver =3D {
>                 .name =3D "acpi-button",
>                 .acpi_match_table =3D button_device_ids,
> -               .pm =3D &acpi_button_pm,
> +               .pm =3D pm_sleep_ptr(&acpi_button_pm),
>         },
>  };
>
> @@ -502,7 +498,6 @@ static u32 acpi_button_event(void *data)
>         return ACPI_INTERRUPT_HANDLED;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev)
>  {
>         struct acpi_button *button =3D dev_get_drvdata(dev);
> @@ -532,7 +527,6 @@ static int acpi_button_resume(struct device *dev)
>         }
>         return 0;
>  }
> -#endif
>
>  static int acpi_lid_input_open(struct input_dev *input)
>  {
> --
> 2.25.1
>
