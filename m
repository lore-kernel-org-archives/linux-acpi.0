Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0743E4B9
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518988; cv=none; b=GXUuDQ0E1mjLp0N24PHcDEoIAsXyoSbtyxmLaVLWGlzK5T6ILcZCh4Nzo0CuWfZ+zwViZvC8wZAvkQ4VM5b4pmFJ9pAkO2YvEY2TUY35/c3Yihtxsz9AHsq4OyNm5HlTh3Er6ZUwzYxtOSqJGvRG+JimeBMH6PedJ48hez1IgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518988; c=relaxed/simple;
	bh=mU/foMwLY7I2cXRhqhtqv4ud+3Lhv5MB0VsaOfnQ5QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfOI2yWg1HEVZRPlfLDhyVyk6SfIej+/zTyhqXhoZinqKO2CPac7i8JVowzM3mM6ZQzES1uvmkoGNvrPZtaOpNG4KszjrzFPI80VWEuYKCpvXrJS4zZubrMlIbNYrZ3lmczwxksftR9S52Bn7qUSyyYNrh9uo5+Qc4ejghNPHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw4QUlX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw4QUlX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBFCC2BCB0
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518988;
	bh=mU/foMwLY7I2cXRhqhtqv4ud+3Lhv5MB0VsaOfnQ5QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dw4QUlX9q2Pm9+dAAFkARSudtTosPocsLDchlnW/E4YLu0xo0bzvvFgbput5mAg1x
	 /JdyhPSqdO8wpW01tPHRO6nBrP7WO/7ECSN2r+EexRFBqpV1M2ac/nIOgl4Hy0F9Ma
	 UhU8tW4U4t/dqMyKofBG0nsf4+bwViG8BdTM7H6cFviF3NRJtdtqGjzRRicKID6N60
	 t9mEUAXoVjRC0uR0d07iOcM/VOd+CXsX2HQEMPguXOd1DJpHqpK4kju8aKhju0UxZG
	 FxPAmldcFUGjgGTNMQx4V7xypmOSwzl4UefhlhxPJ8pSGn3AgA6N6fTfUAnpxLLZtf
	 E0JoDV3QvUVEQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3939d2bd739so40182811fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 10:03:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MrT18L4C07rM5SEeijUEZNZRD7u77dA3FkLkOIu089hzVVOgrdr3fDzklXdP6jFXPXg4gHaZbYlrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1mkMj5nXGPZbcGx8mzIM+IKozZ6jwgYFypeKPAX2V1GSw/Ey
	Kj8Pr0W2l+GdLB8FKXhBkvrweRgva3P7BTAvSJQi667UbUH03lkyvGVsoNgOhdX2hcTA1wCEfGC
	I01BvFpg1dd/6xYmk2DdxB30KcvDJGcA=
X-Received: by 2002:a05:6512:40d1:b0:5a8:88f8:9ed4 with SMTP id
 2adb3069b0e04-5a888f8a070mr7770357e87.30.1778518986748; Mon, 11 May 2026
 10:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki>
 <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com> <CAJZ5v0i5u4uq7v52oWYNt_tXwJAcpuXVS21y6PKU54XY7y=ciA@mail.gmail.com>
 <db0875af-5b2f-b710-43ff-ec1b9922ec27@linux.intel.com> <CAJZ5v0hAKEiy3JVP4w+wX-P3XxiVddVXt36zqqRdtPLnnmnYnw@mail.gmail.com>
 <de73ccd5-15c4-4836-d63e-4bb3138310d7@linux.intel.com>
In-Reply-To: <de73ccd5-15c4-4836-d63e-4bb3138310d7@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 19:02:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hn8oSu03QBNyPm35sBMPS10_MP_wfCmizt9datjDkcVQ@mail.gmail.com>
X-Gm-Features: AVHnY4KAOkQ9IipZwCzeBLRNwmyGrQCH5FZbn18C29IxP949nS1hsjd20p7swts
Message-ID: <CAJZ5v0hn8oSu03QBNyPm35sBMPS10_MP_wfCmizt9datjDkcVQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:44=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 11 May 2026, Rafael J. Wysocki wrote:
>
> > On Mon, May 11, 2026 at 6:17=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Mon, 11 May 2026, Rafael J. Wysocki wrote:
> > >
> > > > On Mon, May 11, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, 8 May 2026, Rafael J. Wysocki wrote:
> > > > >
> > > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > To facilitate subsequent conversion of the driver to a platform=
 one,
> > > > > > make it install an ACPI notify handler directly instead of usin=
g
> > > > > > a .notify() callback in struct acpi_driver.
> > > > > >
> > > > > > No intentional functional impact.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
> > > > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platfo=
rm/x86/xo15-ebook.c
> > > > > > index 616f4bb3461a..8af1b9078db8 100644
> > > > > > --- a/drivers/platform/x86/xo15-ebook.c
> > > > > > +++ b/drivers/platform/x86/xo15-ebook.c
> > > > > > @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_dev=
ice *device)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -static void ebook_switch_notify(struct acpi_device *device, u3=
2 event)
> > > > > > +static void ebook_switch_notify(acpi_handle handle, u32 event,=
 void *data)
> > > > > >  {
> > > > > >       switch (event) {
> > > > > >       case ACPI_FIXED_HARDWARE_EVENT:
> > > > > >       case XO15_EBOOK_NOTIFY_STATUS:
> > > > > > -             ebook_send_state(device);
> > > > > > +             ebook_send_state(data);
> > > > > >               break;
> > > > > >       default:
> > > > > > -             acpi_handle_debug(device->handle,
> > > > > > -                               "Unsupported event [0x%x]\n", e=
vent);
> > > > > > +             acpi_handle_debug(handle, "Unsupported event [0x%=
x]\n", event);
> > > > > >               break;
> > > > > >       }
> > > > > >  }
> > > > > > @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_de=
vice *device)
> > > > > >       if (error)
> > > > > >               goto err_free_input;
> > > > > >
> > > > > > +     error =3D acpi_dev_install_notify_handler(device, ACPI_DE=
VICE_NOTIFY,
> > > > > > +                                             ebook_switch_noti=
fy, device);
> > > > > > +     if (error)
> > > > > > +             goto err_unregister_input;
> > > > > > +
> > > > > >       ebook_send_state(device);
> > > > > >
> > > > > >       if (device->wakeup.flags.valid) {
> > > > > > @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_de=
vice *device)
> > > > > >  err_free_button:
> > > > > >       kfree(button);
> > > > > >       return error;
> > > > > > +
> > > > > > +err_unregister_input:
> > > > > > +     input_unregister_device(input);
> > > > > > +     goto err_free_button;
> > > > >
> > > > > The end result would be much simpler if there would be patch 5 to=
 convert
> > > > > to devm_*().
> > > >
> > > > Well, I can add one.
> > > >
> > > > Do you want me to resend an update of the series for this?
> > >
> > > Ah, right. I took these now to review-ilpo-next.
> > >
> > > (I was initially thinking of making a little bit different suggestion
> > > which would have required changes to these patches but then realized =
it
> > > was better to just add the devm_*() conversion after these).
> >
> > So I guess I'll prepare a follow-up patch for the devm_ conversion.
> >
> > Note though that there's no devm_ counterpart of
> > acpi_dev_install_notify_handler() ATM, so I may need to add one while
> > at it.
>
> While adding it will be able to remove acpi_dev_remove_notify_handler()
> call from ebook_switch_remove(), there's no such call in rollbacks for
> ebook_switch_probe() so it wouldn't be strictly required.

Right.

> But it certainly wouldn't hurt to have one for other drivers.

Sure, I definitely have a plan to add one.
