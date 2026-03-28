Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAD37F736
	for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774699182; cv=none; b=ZZyVqXhaHo55gIgtzaEb2ofrcBEe4MPcmo2ht2X0b52yq5ZsgnjZg7RlqmOYcL/y8iPDwv75Li+VqvWtbCH3T1UPAE2yNglNv9gOWowhwDBwRHKa06462Y4bCjhd3S+MLbttekUoDMwABjJLU+aFP3NyL50it+Dl+eONZBDkdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774699182; c=relaxed/simple;
	bh=PTz2rHI475IxV/7XekLz6uyjPu4o8UrPYGzuKbSBcaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFsNhZgnVzlBa8R+TwNzA4AmWAUaXV8b5ypynA0TFJgpmwF08UXUmz1j4614HWJwW4ewY9uZC4uMazTe92mXRMu7zLzI5rWQAhGNYOf/LfgbB/rLiqr5QvCMYa0Ew0XF4O2XkVcK/TaI6CK4e9aC2Qu+KTllXVmfxAKkiBrySR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5uMPz4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5uMPz4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214BCC2BC9E
	for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2026 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774699182;
	bh=PTz2rHI475IxV/7XekLz6uyjPu4o8UrPYGzuKbSBcaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a5uMPz4v1SyZIsXxv2hZAIKcTrC0XpWrUq8qYLhxv97mEF1HNY6xMOWv8ZqpiMH0W
	 T3gHZTmN8AC3lkffRuAIFMHv3qznShrriIdcUKeCPXtOY/OoJmqEzQBhhK0hSDG+Yb
	 S9FD5lLZ9a2zddwX0pTcbLLgy/J9p5w2hTflBNVc0QceEs8heP6sCuKvQmacQxyuvv
	 9BjohsaV5FnpQxEAOjXtoMEDWmEGkiq7QIzpQBEvioBWy6dCkWdzvVGuzjjeJg1d1V
	 jXQXcCyhmmRxXmgvg25Em90Q9smFMr8PhbMnJL+zHTUeWNPEo7dyRLbY3sXv4wvQDv
	 obOzyNWLCkmrQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ef10ec84cso2435763fac.2
        for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2026 04:59:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM6hd3G3GVNGo6QyPZKDSuiaHlIT3olbU9amhUW2JbFB01VVvnmtIntDYVqspZg70tn1y29Lii3BLf@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQyvbOTx4tHEIp64jfMLdoqDe+iJK6Xl2EFE8QCOwvc51kvOB
	diewMyTdTOBr5BCTo1w+F4TM2fOCAjgOfgXHbx8iKHemZiAXIZNjvJKL5n9c2w0b8qSiyOhT50R
	TmliRNgRyA6HDe0NVilnt95GKCdtEvEU=
X-Received: by 2002:a05:6870:b3e4:b0:409:5560:72f8 with SMTP id
 586e51a60fabf-41cebe755a7mr3240178fac.0.1774699181235; Sat, 28 Mar 2026
 04:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3949487.kQq0lBPeGt@rafael.j.wysocki> <cd671e41-9f36-409d-97b4-f696935b1efe@app.fastmail.com>
In-Reply-To: <cd671e41-9f36-409d-97b4-f696935b1efe@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 28 Mar 2026 12:59:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwA-dDen-GYsdtEkHqahVrg4jSc9KD6-5AHLT=RV=bWA@mail.gmail.com>
X-Gm-Features: AQROBzA3DxvYl3RU61mvKW4Htjtda6yOaEem0JiYgDysa_YLltqwpeGV0M_fbRE
Message-ID: <CAJZ5v0gwA-dDen-GYsdtEkHqahVrg4jSc9KD6-5AHLT=RV=bWA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: thinkpad_acpi: Drop ACPI driver registration
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 2:29=E2=80=AFAM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
> Hi Rafael
>
> On Tue, Mar 24, 2026, at 4:08 PM, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > There is no point in registering an ACPI driver that only has an empty
> > .add() callback, which is done by the thinkpad_acpi driver, since
> > after binding to an ACPI device it only sits there and does nothing.
> >
> > That binding only effectively causes the ACPI device's reference count
> > to increase, but that can be achieved by using acpi_get_acpi_dev()
> > instead of acpi_fetch_acpi_dev() in setup_acpi_notify(), and doing
> > the corresponding cleanup in ibm_exit().
> >
> > Update the code accordingly and get rid of the non-functional ACPI
> > driver.
> >
> > No intentional functional impact beyond altering sysfs content.
>
> Just curious - where would I see changes?

In /sys/bus/acpi/drivers/ - no thinkpad_* any more (quite obviously)
and no "driver" link in the sysfs directory of the ACPI device the
driver used to bind to.  That should be it IIRC.

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/x86/lenovo/thinkpad_acpi.c | 62 ++-------------------
> >  1 file changed, 4 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > index 8982d92dfd97..9e1614754cd7 100644
> > --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > @@ -299,7 +299,6 @@ struct ibm_struct;
> >
> >  struct tp_acpi_drv_struct {
> >       const struct acpi_device_id *hid;
> > -     struct acpi_driver *driver;
> >
> >       void (*notify) (struct ibm_struct *, u32);
> >       acpi_handle *handle;
> > @@ -322,7 +321,6 @@ struct ibm_struct {
> >       struct tp_acpi_drv_struct *acpi;
> >
> >       struct {
> > -             u8 acpi_driver_registered:1;
> >               u8 acpi_notify_installed:1;
> >               u8 proc_created:1;
> >               u8 init_called:1;
> > @@ -832,9 +830,9 @@ static int __init setup_acpi_notify(struct ibm_stru=
ct *ibm)
> >       vdbg_printk(TPACPI_DBG_INIT,
> >               "setting up ACPI notify for %s\n", ibm->name);
> >
> > -     ibm->acpi->device =3D acpi_fetch_acpi_dev(*ibm->acpi->handle);
> > +     ibm->acpi->device =3D acpi_get_acpi_dev(*ibm->acpi->handle);
> >       if (!ibm->acpi->device) {
> > -             pr_err("acpi_fetch_acpi_dev(%s) failed\n", ibm->name);
> > +             pr_err("acpi_get_acpi_dev(%s) failed\n", ibm->name);
> >               return -ENODEV;
> >       }
> >
> > @@ -859,44 +857,6 @@ static int __init setup_acpi_notify(struct ibm_str=
uct *ibm)
> >       return 0;
> >  }
> >
> > -static int __init tpacpi_device_add(struct acpi_device *device)
> > -{
> > -     return 0;
> > -}
> > -
> > -static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
> > -{
> > -     int rc;
> > -
> > -     dbg_printk(TPACPI_DBG_INIT,
> > -             "registering %s as an ACPI driver\n", ibm->name);
> > -
> > -     BUG_ON(!ibm->acpi);
> > -
> > -     ibm->acpi->driver =3D kzalloc_obj(struct acpi_driver);
> > -     if (!ibm->acpi->driver) {
> > -             pr_err("failed to allocate memory for ibm->acpi->driver\n=
");
> > -             return -ENOMEM;
> > -     }
> > -
> > -     sprintf(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name)=
;
> > -     ibm->acpi->driver->ids =3D ibm->acpi->hid;
> > -
> > -     ibm->acpi->driver->ops.add =3D &tpacpi_device_add;
> > -
> > -     rc =3D acpi_bus_register_driver(ibm->acpi->driver);
> > -     if (rc < 0) {
> > -             pr_err("acpi_bus_register_driver(%s) failed: %d\n",
> > -                    ibm->name, rc);
> > -             kfree(ibm->acpi->driver);
> > -             ibm->acpi->driver =3D NULL;
> > -     } else if (!rc)
> > -             ibm->flags.acpi_driver_registered =3D 1;
> > -
> > -     return rc;
> > -}
> > -
> > -
> >  /*********************************************************************=
*******
> >   *********************************************************************=
*******
> >   *
> > @@ -11532,6 +11492,8 @@ static void ibm_exit(struct ibm_struct *ibm)
> >               acpi_remove_notify_handler(*ibm->acpi->handle,
> >                                          ibm->acpi->type,
> >                                          dispatch_acpi_notify);
> > +             ibm->acpi->device->driver_data =3D NULL;
> > +             acpi_dev_put(ibm->acpi->device);
> >               ibm->flags.acpi_notify_installed =3D 0;
> >       }
> >
> > @@ -11542,16 +11504,6 @@ static void ibm_exit(struct ibm_struct *ibm)
> >               ibm->flags.proc_created =3D 0;
> >       }
> >
> > -     if (ibm->flags.acpi_driver_registered) {
> > -             dbg_printk(TPACPI_DBG_EXIT,
> > -                     "%s: acpi_bus_unregister_driver\n", ibm->name);
> > -             BUG_ON(!ibm->acpi);
> > -             acpi_bus_unregister_driver(ibm->acpi->driver);
> > -             kfree(ibm->acpi->driver);
> > -             ibm->acpi->driver =3D NULL;
> > -             ibm->flags.acpi_driver_registered =3D 0;
> > -     }
> > -
> >       if (ibm->flags.init_called && ibm->exit) {
> >               ibm->exit();
> >               ibm->flags.init_called =3D 0;
> > @@ -11587,12 +11539,6 @@ static int __init ibm_init(struct
> > ibm_init_struct *iibm)
> >       }
> >
> >       if (ibm->acpi) {
> > -             if (ibm->acpi->hid) {
> > -                     ret =3D register_tpacpi_subdriver(ibm);
> > -                     if (ret)
> > -                             goto err_out;
> > -             }
> > -
> >               if (ibm->acpi->notify) {
> >                       ret =3D setup_acpi_notify(ibm);
> >                       if (ret =3D=3D -ENODEV) {
> > --
> > 2.51.0
>
> Changes seem good to me (but not an expert).
> I did try them out on a system (X1 Carbon 13) and didn't find any problem=
s. Let me know if there's anything in particular I should look out for or c=
heck and happy to do that.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you!
