Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF053D9028
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510611; cv=none; b=NH6hbYTCwrljGwJlr1d3O7K4idk3TOH7Q7NtUJBao32Yk5yH2W0RpFT3y+XpTz0eCN+GlJks1QJkhLBaHkaR4Kk6SuHH5rsp74Y7+5O0G0mdIpl7xlBszf9FzuPIhTOUraOCcydmRv0douCLovzOpuzRl2QeM4RCm8qjZQ1dWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510611; c=relaxed/simple;
	bh=pIBbToBFWDq0XDZ87Ik5kGwisGTl5NlEP0y7mDYzjJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPJKypmcjrDCuLRJ7tTr/2ECJzj+QuWZDGdFwGzFwBeVt6jVR+nolpqMs7qjGUtgNbLBachh6ozXuhjfwPdgWe9UnJmFNQLZJQk+24NdpC4srs8BuQwpHqcDhqja54HojFXqlXSg9ZacKpG42Vc4juKOLNHshqzvjFU+0fkhh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUHRgCRP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUHRgCRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7582C2BCB0
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510610;
	bh=pIBbToBFWDq0XDZ87Ik5kGwisGTl5NlEP0y7mDYzjJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QUHRgCRP0e/6ScxK/5dTZy8ISsmkojhS0TW2/gZ0b4ivVhMZyRTDRu51KN+ZD+Om+
	 3eusio/rAALuGOlGwuJlukGhfOjglkRzOL5AAin9/HctvptBA5kMzZHrTrcg05I3q8
	 TW2P6VvCw0cWKbb7XMPUeM+xi7HwqxfUpgMKSNqyoIb3QpkSAyXc0FTOt1DmsEaOYM
	 1OXlhov6sc2jsiRZKgEffZ2x+2EvegF+fywRatJpAv384a5VrbHsoK5bKBbeGxMcDl
	 MMhCMtvl8oafT3K47Mdb9Cw6YHWo9GJUFQEcGP3EYesRsjQnR5KaqoarfZJuc1JCC3
	 GU+8EzBj7PYvQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so4763424e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 07:43:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ZhPA1IIN22S6dhSQMDqb/vfxa3UdYmROaWyUwXl7/oDpJ2bRXDjY4wf8kSJY1QoNfwmv03nHG0Owy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx86wu6MpxBE7KnCnK57G79KhQ+fwl8twoJRlg1yPRjqqMwYtK
	c0VofXgUmVhtiX2YnKg9eOe52xisGTp3KKxJuxlKZOv/0JtpSknknZJ/nPRBe35MLU7RhjLHIOQ
	JGkowkRu0enB5uF6xBE9uqIL2/G9atOk=
X-Received: by 2002:a05:6512:ad6:b0:5a8:8de0:4576 with SMTP id
 2adb3069b0e04-5a8b708e865mr2654068e87.25.1778510609071; Mon, 11 May 2026
 07:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki>
 <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com>
In-Reply-To: <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 16:43:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
X-Gm-Features: AVHnY4LOe4EP62-gPoPF1mzGD3d6HSYBsrrHbr1wuI1ywmHypezLHqxn-Ir6YGE
Message-ID: <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 8 May 2026, Rafael J. Wysocki wrote:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > To facilitate subsequent conversion of the driver to a platform one,
> > make it install an ACPI notify handler directly instead of using
> > a .notify() callback in struct acpi_driver.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/x=
o15-ebook.c
> > index 616f4bb3461a..8af1b9078db8 100644
> > --- a/drivers/platform/x86/xo15-ebook.c
> > +++ b/drivers/platform/x86/xo15-ebook.c
> > @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_device *dev=
ice)
> >       return 0;
> >  }
> >
> > -static void ebook_switch_notify(struct acpi_device *device, u32 event)
> > +static void ebook_switch_notify(acpi_handle handle, u32 event, void *d=
ata)
> >  {
> >       switch (event) {
> >       case ACPI_FIXED_HARDWARE_EVENT:
> >       case XO15_EBOOK_NOTIFY_STATUS:
> > -             ebook_send_state(device);
> > +             ebook_send_state(data);
> >               break;
> >       default:
> > -             acpi_handle_debug(device->handle,
> > -                               "Unsupported event [0x%x]\n", event);
> > +             acpi_handle_debug(handle, "Unsupported event [0x%x]\n", e=
vent);
> >               break;
> >       }
> >  }
> > @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_device *de=
vice)
> >       if (error)
> >               goto err_free_input;
> >
> > +     error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOT=
IFY,
> > +                                             ebook_switch_notify, devi=
ce);
> > +     if (error)
> > +             goto err_unregister_input;
> > +
> >       ebook_send_state(device);
> >
> >       if (device->wakeup.flags.valid) {
> > @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_device *de=
vice)
> >  err_free_button:
> >       kfree(button);
> >       return error;
> > +
> > +err_unregister_input:
> > +     input_unregister_device(input);
> > +     goto err_free_button;
>
> The end result would be much simpler if there would be patch 5 to convert
> to devm_*().

Well, I can add one.

Do you want me to resend an update of the series for this?

> >  }
> >
> >  static void ebook_switch_remove(struct acpi_device *device)
> > @@ -149,6 +157,8 @@ static void ebook_switch_remove(struct acpi_device =
*device)
> >               acpi_disable_gpe(device->wakeup.gpe_device,
> >                                device->wakeup.gpe_number);
> >
> > +     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +                                    ebook_switch_notify);
> >       input_unregister_device(button->input);
> >       kfree(button);
> >  }
> > @@ -160,7 +170,6 @@ static struct acpi_driver xo15_ebook_driver =3D {
> >       .ops =3D {
> >               .add =3D ebook_switch_add,
> >               .remove =3D ebook_switch_remove,
> > -             .notify =3D ebook_switch_notify,
> >       },
> >       .drv.pm =3D &ebook_switch_pm,
> >  };
> >
> >
> >
>
> --
