Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3B3382C7
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965988; cv=none; b=ZVhgPaX2KJN0q8siGiOZe+PJOjro4+V9pcbQ9OlWetAqIwY57X9g0vMVw84Tij7X5dfoLRsQCsLSuDT/MdX/MDe1Kh0dWMpQLFWCBJJkfO9bguvH9KDQ6Kd0Zpg3RRJPaj8yfZMpEAyxxxqWqY7Q9SsXpLI6543jOApU/7JenF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965988; c=relaxed/simple;
	bh=o1hpiqUrlBxo0KGTSCG6/0sWQwy2LMagGdEe3XY4+ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frT0IU9gml7JKqxx1a5YKBDcsAWHJDg9KpiQxN+8PDARGSiWFkqI+bNZ2zzeuY6IzT7WTk33efLgiz1LUWaCEYfrL1mw+LQD7ko64c00uMXV2Rmc6rGvqgSmVEo27pHRPMk2G8ii6dr1h/iK09tSFYM3XxbbEtuQkusJCzPs+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg4pG+Ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg4pG+Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C31F00A3F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965987;
	bh=Au4rQwz893looLpHC6//Qc2BERkEZwiaGaFajr8kdxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg4pG+RaBaRX0Seds7+GTkHeePHoxYPS6hBEVbeX/VD45yQTYQfqeFpAdyTjyZgP7
	 C5Qv+50+BiDH60VpqVCWmvGS2oQee+cBGLTLJXWZLOjzDSn0hk1MaKcBpU39+RqLOK
	 E4AIOj3Bb5sJZScMRM3CvmQo89O1xxP8H76r9t47epX9yV74svpldlC37HgYPLDQNQ
	 YNRq7MPSnXDilEyGBYN0pRzv9LST6H6EqjRNOPqvTdB7qCUGlf1PyKo3YPTof75df8
	 lKTnEGcEtvgnmOD/mWWDjfWATZgeHfoNpJ2Xr4WzsFO4QTb0whDu/7Qqmyhczub+oO
	 P1StYk4FdVBvg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so55621881fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:59:47 -0700 (PDT)
X-Gm-Message-State: AFuF++mga/W6Vel2ix2lMhMy7fjCwrJaqgbxZhsg70i8rgvm0Vug7M7H
	d+CtIZMtjcNrEDqXUnqj1fUognUjcVURlDqgom8oORAhZmhMQTnQ4IrNfzM/n5EmDwghI5bizIG
	CF4S3KGC0E4ks7jbi4nZtGxHI/9t/FXc=
X-Received: by 2002:a05:6512:110d:b0:5ae:b7ca:33ec with SMTP id
 2adb3069b0e04-5b616f15d02mr5852181e87.9.1788965985781; Wed, 09 Sep 2026
 07:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820033653.1682804-1-triet.hoang.dev@gmail.com> <CAJZ5v0gNLspde-oi9Bi+LKT_NbpSYCLmdqUSkNvKS_kgFnB90g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gNLspde-oi9Bi+LKT_NbpSYCLmdqUSkNvKS_kgFnB90g@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:58:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUOLDeTOrFkckUJQdAm3qbs4E8kG52QUjmYPf6K=g5dg@mail.gmail.com>
X-Gm-Features: AcwNN1VXyg11sVtt4pdJ7scrgELLhoBoi5mNSZrpBAqJz2JuI3Kpqyp91tfh86k
Message-ID: <CAJZ5v0jUOLDeTOrFkckUJQdAm3qbs4E8kG52QUjmYPf6K=g5dg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: use DEFINE_SIMPLE_DEV_PM_OPS
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 4:47=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 20, 2026 at 5:37=E2=80=AFAM Triet Hoang <triet.hoang.dev@gmai=
l.com> wrote:
> >
> > Convert the deprecated SIMPLE_DEV_PM_OPS
> > to DEFINE_SIMPLE_DEV_PM_OPS
> >
> > Also use pm_sleep_ptr() when assigning the ops to the driver.
> > This allows the removal of the ifdef CONFIG_PM_SLEEP
> > and unnecessary forward declarations of 4 functions.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> > ---
> >  drivers/acpi/button.c | 36 ++++++++++++------------------------
> >  1 file changed, 12 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 3836ee75dd66..d4cb942b754f 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -147,28 +147,6 @@ static const struct dmi_system_id dmi_lid_quirks[]=
 =3D {
> >         {}
> >  };
> >
> > -static int acpi_button_probe(struct platform_device *pdev);
> > -static void acpi_button_remove(struct platform_device *pdev);
> > -
> > -#ifdef CONFIG_PM_SLEEP
> > -static int acpi_button_suspend(struct device *dev);
> > -static int acpi_button_resume(struct device *dev);
> > -#else
> > -#define acpi_button_suspend NULL
> > -#define acpi_button_resume NULL
> > -#endif
> > -static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_but=
ton_resume);
> > -
> > -static struct platform_driver acpi_button_driver =3D {
> > -       .probe =3D acpi_button_probe,
> > -       .remove =3D acpi_button_remove,
> > -       .driver =3D {
> > -               .name =3D "acpi-button",
> > -               .acpi_match_table =3D button_device_ids,
> > -               .pm =3D &acpi_button_pm,
> > -       },
> > -};
> > -
> >  struct acpi_button {
> >         struct acpi_device *adev;
> >         struct device *dev;             /* physical button device */
> > @@ -491,7 +469,6 @@ static u32 acpi_button_event(void *data)
> >         return ACPI_INTERRUPT_HANDLED;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> >  static int acpi_button_suspend(struct device *dev)
> >  {
> >         struct acpi_button *button =3D dev_get_drvdata(dev);
> > @@ -521,7 +498,6 @@ static int acpi_button_resume(struct device *dev)
> >         }
> >         return 0;
> >  }
> > -#endif
>
> And the function above is going to be unused when CONFIG_PM_SLEEP is
> unset, causing the compiler to complain AFAICS.

Scratch this, but you should mention in the changelog that the file is
going to contain dead code for CONFIG_PM_SLEEP unset after this
change.

And I'm not really sure if I like that.

> >  static int acpi_lid_input_open(struct input_dev *input)
> >  {
> > @@ -753,6 +729,18 @@ static void acpi_button_remove(struct platform_dev=
ice *pdev)
> >                 acpi_lid_forget(button->adev);
> >  }
> >
> > +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, a=
cpi_button_resume);
> > +
> > +static struct platform_driver acpi_button_driver =3D {
> > +       .probe =3D acpi_button_probe,
> > +       .remove =3D acpi_button_remove,
> > +       .driver =3D {
> > +               .name =3D "acpi-button",
> > +               .acpi_match_table =3D button_device_ids,
> > +               .pm =3D pm_sleep_ptr(&acpi_button_pm),
> > +       },
> > +};
> > +
> >  static int param_set_lid_init_state(const char *val,
> >                                     const struct kernel_param *kp)
> >  {
> > --
> > 2.53.0
> >
