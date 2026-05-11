Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC82449EA9
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517445; cv=none; b=nX6UkkufXpEfyyIb478b12NlnYjWFEt6iBd4jTj5T3MjyeudzgEukUA8qjUojCEBDDMISzRZoBjone6D1VCH83ByY9AYqic0nPztmCkvzjJpo9G+gsc5Dl7AxMa9oOz2q5YQlsNbWPh+MzA6S2oHx5VMxAusMlVg3ola7XkOqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517445; c=relaxed/simple;
	bh=+NkMbk1SVW7S6P7NmK715GNyt/tuNvSJCJCRgeRwgmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4/A3TlRFyxwuGFWbEwl/KZARYUnoyWwkemMAxJJ1dPuZrlRaGmdoyBiDGwjoqP2SOVncRByga/Ed47SR37i9/TyO3M8kQ9dpYZN4vEoZ2VuEnPNG4NqpFH6zvWsv/H34J4ri61UI0Qg3LxB7U23xgyDNlDj2KPH9g+qQe1x1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kygq7wdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kygq7wdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEFCC2BCC9
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517445;
	bh=+NkMbk1SVW7S6P7NmK715GNyt/tuNvSJCJCRgeRwgmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kygq7wdVv0aBk1Ie6vYSODKTx52L8/kWnpHuOADer+mom4fpiriyko/IEdfJv2MNB
	 gWnr/k5tNcHWJ/R0lRpcS1sLi2kHjXoM2C734jzUPwuBe7tWsmxnYdp+JRenw7A9hk
	 vlAj+PVXGrSS3DlOGGSN9QNwnsUAE/7LWigkPhI+EiplNGBNb4SNb/zT3x+PpOnAZl
	 tAtAusP6NB5X82XYzm4dFdH5NGQDoqiKCh++voEfncB9W7jZLlywMHAhYSrIlsyMDY
	 qCpnXJq9ifWnjEmWFjOGxo9rmWICzu1LLDEZ70GV/sdVw47PSVZMxtZx466cAnzbzA
	 6JBdnkYxVIM4g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3922b35e69cso38082061fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 09:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9wT6cCn2Nm0MQoz4XBtJPWdQz6a9BEBQfol6nwirpaKnjdyQwcTGVyt31qfVn7MBGo/Voip1Y0zKSH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4VXChCpFlzQ9hNEbMEnlnpI82UxwCicjw1kPzNxDaBn0LVp/
	yON3+7CpIRFwdXnXjF+coUkidcLx0wzDR1p3OIrsHo/phewJ5BauAPpuUAsD9RAPsCVBhC4zAwx
	/823gC5jVf/azTLpBuytvJPJ8VlKBs4E=
X-Received: by 2002:a05:6512:3e1c:b0:5a8:b966:7b1f with SMTP id
 2adb3069b0e04-5a8b9667b9amr4147111e87.16.1778517443802; Mon, 11 May 2026
 09:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki>
 <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com> <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
 <db0875af-5b2f-b710-43ff-ec1b9922ec27@linux.intel.com>
In-Reply-To: <db0875af-5b2f-b710-43ff-ec1b9922ec27@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 18:37:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAKEiy3JVP4w+wX-P3XxiVddVXt36zqqRdtPLnnmnYnw@mail.gmail.com>
X-Gm-Features: AVHnY4IAXsyRuzxaEtsglew_Cd17JvCp3cVNj1XmBIbwyQ32drMEwhOgD2qaqHA
Message-ID: <CAJZ5v0hAKEiy3JVP4w+wX-P3XxiVddVXt36zqqRdtPLnnmnYnw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:17=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 11 May 2026, Rafael J. Wysocki wrote:
>
> > On Mon, May 11, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Fri, 8 May 2026, Rafael J. Wysocki wrote:
> > >
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > To facilitate subsequent conversion of the driver to a platform one=
,
> > > > make it install an ACPI notify handler directly instead of using
> > > > a .notify() callback in struct acpi_driver.
> > > >
> > > > No intentional functional impact.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
> > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x=
86/xo15-ebook.c
> > > > index 616f4bb3461a..8af1b9078db8 100644
> > > > --- a/drivers/platform/x86/xo15-ebook.c
> > > > +++ b/drivers/platform/x86/xo15-ebook.c
> > > > @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_device =
*device)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static void ebook_switch_notify(struct acpi_device *device, u32 ev=
ent)
> > > > +static void ebook_switch_notify(acpi_handle handle, u32 event, voi=
d *data)
> > > >  {
> > > >       switch (event) {
> > > >       case ACPI_FIXED_HARDWARE_EVENT:
> > > >       case XO15_EBOOK_NOTIFY_STATUS:
> > > > -             ebook_send_state(device);
> > > > +             ebook_send_state(data);
> > > >               break;
> > > >       default:
> > > > -             acpi_handle_debug(device->handle,
> > > > -                               "Unsupported event [0x%x]\n", event=
);
> > > > +             acpi_handle_debug(handle, "Unsupported event [0x%x]\n=
", event);
> > > >               break;
> > > >       }
> > > >  }
> > > > @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_device=
 *device)
> > > >       if (error)
> > > >               goto err_free_input;
> > > >
> > > > +     error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE=
_NOTIFY,
> > > > +                                             ebook_switch_notify, =
device);
> > > > +     if (error)
> > > > +             goto err_unregister_input;
> > > > +
> > > >       ebook_send_state(device);
> > > >
> > > >       if (device->wakeup.flags.valid) {
> > > > @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_device=
 *device)
> > > >  err_free_button:
> > > >       kfree(button);
> > > >       return error;
> > > > +
> > > > +err_unregister_input:
> > > > +     input_unregister_device(input);
> > > > +     goto err_free_button;
> > >
> > > The end result would be much simpler if there would be patch 5 to con=
vert
> > > to devm_*().
> >
> > Well, I can add one.
> >
> > Do you want me to resend an update of the series for this?
>
> Ah, right. I took these now to review-ilpo-next.
>
> (I was initially thinking of making a little bit different suggestion
> which would have required changes to these patches but then realized it
> was better to just add the devm_*() conversion after these).

So I guess I'll prepare a follow-up patch for the devm_ conversion.

Note though that there's no devm_ counterpart of
acpi_dev_install_notify_handler() ATM, so I may need to add one while
at it.
