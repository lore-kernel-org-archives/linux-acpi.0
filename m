Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2B3E2AB1
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224482; cv=none; b=PdgeKTRwlZDvpMZ6Mp7F1mWjukvXeqOBmLubNFfpXht8uAIulvkPuSFt6sv4iJt4hLDglUy+c/2d/i+w7wfgtiBpxKEgbc7w0YtYhZ+YweMPNapr+fi5QEFsFCKjyoa5U97Fmo7W0sqYE9MUM/Rs5JwdcyvpE3o9CBeWL+kgbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224482; c=relaxed/simple;
	bh=Z3cJOTmakhG2ToQHT/5FxzyoNWm1hdaFax+j9zTe9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJahR58f6/IAXIWZwwMpPR7UDPf4ax+UtE8yrSACIINDoFUGpI6WH8kh/AF94YvjoSWxw+6w3CTzdM3UqEvESgaCrZ+rZaM5AO26oSE65Lxsy8xcvmJmtoN5cDqVc+6TPgvATSiS8Ubz7Tb6qDHykwDjd2pMRF0y/gbzeAsWgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB0AlIja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB0AlIja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF241F00898
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224480;
	bh=ciNNq/asO0Xczbe18xuJLKGNXvHiS5vIKAICk9vV2Vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RB0AlIjauT81LR0eELfgA7A/hnlIr1fLDoCEyXyT6J1958im936FTatmIVI4Pz344
	 Xf+jvS62tpekH73Y7xQXSvB8J4OSXXzrEoCfm7aeKReUCAJruTNJIB8f8T9qGM5sSP
	 McFOkACIJ+c/+GKjSvPxRizg1M4Gd7vVj2lGOuQPibIFKHSJ/RUIWgMptRxUFLtvQ6
	 esmr6A3N/S4+7slbgQ/WSU6z6Tpom2g6rjORcKJFqRLUXm+ksrwJYJBnsoL1n+49LG
	 eo0S4YKnXnfceUn32g1ha0b0fo9llWvduqDFnj7HxHR9Pd5k7XK60A6dqlWLCpPDxc
	 /cXDclu5H2U9w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so5149264e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 14:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dAt4cjqX1hnRcC7+WTb8o7QMQlk/Y0pjDdF8qvG8FZkq+lEZIKJ6pWcUBPf7SJXcaXJSSPxeh2jOo@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTgAv6odQWnZ3kkjzLFb/+AlQI8Z28EX2hG5lUfPUumoMUU4a
	hhLiv5oDCvfnFaaqw3xKAvOhhwm5CdaSIHK6cId+zgue2Kjkz1kgLm4dUYk4jWrgvY0G4jAZpRz
	YoPiUC+iMv+HMSeEijvN+WLi5pCp0Phk=
X-Received: by 2002:a05:6512:3b1e:b0:5a2:b514:4fbb with SMTP id
 2adb3069b0e04-5aa0df9adf6mr5089577e87.11.1779224479262; Tue, 19 May 2026
 14:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2848144.mvXUDI8C0e@rafael.j.wysocki> <agfFERWn-5b-0H24@kernel.org>
In-Reply-To: <agfFERWn-5b-0H24@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 23:01:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
X-Gm-Features: AVHnY4I9klusfThoCs0TQ2e3DPUhwmyxrTWlknteBVSl45ihQaxaiAEhLjhk2eI
Message-ID: <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during probe
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 3:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Every platform driver can be forced to match a device that doesn't matc=
h
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companio=
n
> > object need to verify its presence.
> >
> > Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> > tpm_crb driver.
> >
> > Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
> >  static int crb_acpi_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> > -     struct acpi_device *device =3D ACPI_COMPANION(dev);
> >       struct acpi_table_tpm2 *buf;
> > +     struct acpi_device *device;
> >       struct crb_priv *priv;
> >       struct tpm_chip *chip;
> >       struct tpm2_crb_smc *crb_smc;
> > @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
> >       u32 sm;
> >       int rc;
> >
> > +     device =3D ACPI_COMPANION(dev);
> > +     if (!device)
> > +             return -ENODEV;
> > +
> >       status =3D acpi_get_table(ACPI_SIG_TPM2, 1,
> >                               (struct acpi_table_header **) &buf);
> >       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> >
> >
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks!

So do you want me to pick up this one?
