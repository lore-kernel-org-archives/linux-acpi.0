Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09C39A4A7
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354013; cv=none; b=nhtr7HclZI/eeuXl1z0Fa8Yrsu0VV9czxO3VBTUQ1R5QlNCW5IIFPSXu7sfqjBk/Gsv1x6LAEF/Gz0zTExNkuzp2Yc1jZ2Zub/TTd3FAkkRKqa+fSfqBHvMRxePZcCLc6LQVCwJQ3hSfNYiyTsu1G34V51m0/LOUt5r+0FJ9EA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354013; c=relaxed/simple;
	bh=+g21c+xhEJXCq+MdxQtW3Cq7+eoTte0xylmROZEupSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz5LakFJjUukBJjHyZ7EQP2s9TnHXovmoYSC+EoPyvjAXgxIRQM+uKW4cEdn4wXOBWVpS1bIILrezNr7XBCgOaQSSCKMQBQZkp7Rgce6Z/zm+95NdfoIqVuU4H1eBaofdci+NYYlPmBWLw+oeMe9yd29NR7TmBihQ69yIxGYjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDgSVMbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDgSVMbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDE21F00A3F
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783354012;
	bh=eyA6yVp8m39CxXVR7h4a+POew7OJM8DAxAj7Cs+Enzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fDgSVMbTIxjABvO2eraPe1Xya7KYN0LsjO3aT5z8b+F5kiO5/NR407LPjZPj3O4LL
	 38iGOlWYWQd5DNiV23TshcDmHPrQJiMoClgbB5LIA90kwweEJ+KuU7ylLtFGDbTABn
	 6ZFOiyME8z9h9PLqRCCoxDF8ziEN3dZgj3yGtCmk8w38kmHiBonRv0+iE7QiboOv75
	 CvA/LXtWQI44E6sC8NpRnu3D3kRbQM73fsLUrL12llSTLjIlWIyt5DTWUgGpnCDjFo
	 whx1yp/qK/zo6SBo/5kgu0JZiq91YiL5cK9jnVrv4PE+iaAzYGdER6s1hunhFkcKn9
	 of44BwY1Vovmg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb18fe7ceso2002038e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 09:06:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrMhKy03oPpWTH9H6FPGbI18K0kUSKOrQX9uz5n5CtGqAPibiCYEwY+R0OD8wS4+YnvjoYODN8E9FeX@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQOMaS68jtrgAONIqqIc/hmqWTIduZS5hRUXKk5vCvpK2o0rq
	azzCA/Nwz8xb5vnl2YyYc2mWPyI7FTUdBen5eWfHEo8LC7G/tXuKrLAZiZRVfRJ7PMSBBMB4uR8
	Ut7B55fEdAHP6F5JNVC/gLUjK0IdW3/w=
X-Received: by 2002:a05:6512:1557:b0:5ae:b75e:454d with SMTP id
 2adb3069b0e04-5b007c6a08bmr198361e87.45.1783354010669; Mon, 06 Jul 2026
 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6036011.DvuYhMxLoT@rafael.j.wysocki> <akvN6-V7TOuwG4c2@ashevche-desk.local>
In-Reply-To: <akvN6-V7TOuwG4c2@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 18:06:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2qzoJMtzv7TpZx6u0i4mDMSXzj-smhZ=Sna2Kh8_s-w@mail.gmail.com>
X-Gm-Features: AVVi8CcEDpYWxD_qkRfZQGdI6hUXpr8K0RAyHb2-iCnjd5eGd82uslYctKqVAK4
Message-ID: <CAJZ5v0j2qzoJMtzv7TpZx6u0i4mDMSXzj-smhZ=Sna2Kh8_s-w@mail.gmail.com>
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Stop setting acpi_device_name()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Chen Yu <yu.c.chen@intel.com>, Maximilian Luz <luzmaximilian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 5:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 06, 2026 at 02:28:56PM +0200, Rafael J. Wysocki wrote:
>
> > Since acpi_device_name() set by the driver is only used for input
> > class device name initialization and printing a message on probe
> > success, and SURFACE_BUTTON_DEVICE_NAME can be used instead of it
> > directly in both cases, make the driver do so and stop setting
> > acpi_device_name().
> >
> > No intentional functional impact.
> >
> > This will facilitate the removal of device_name from struct
> > acpi_device_pnp in the future.
>
> ...
>
> > -     input->name =3D acpi_device_name(device);
> > +     input->name =3D SURFACE_BUTTON_DEVICE_NAME;
> >       input->phys =3D button->phys;
> >       input->id.bustype =3D BUS_HOST;
> >       input->dev.parent =3D &pdev->dev;
>
> > -     dev_info(&pdev->dev, "%s [%s]\n", acpi_device_name(device),
> > +     dev_info(&pdev->dev, SURFACE_BUTTON_DEVICE_NAME " [%s]\n",
> >                acpi_device_bid(device));
>
> I would keep one place of accessing the definition:
>
>         dev_info(&pdev->dev, "%s [%s]\n", input->name, acpi_device_bid(de=
vice));
>
> If we ever change that, we won't need to look at two (or more) places.

Yeah, makes sense.  I'll send a v2.
