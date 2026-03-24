Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FC3FF8B0
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372561; cv=none; b=fAx4i7RfjgHfblFW6JVHFFU2BqaX8QO8Yu04ubi52jrupXQ1vdePsZO5c9zLdT/OytrbGkgn6z7nyRgQwn7TfmecFZPlamfSj7w1ECLFZu4g3EwG+IrwcoLUHBLTzA9pXjKGdmCDuPzDo4jyOYWYgxfL2IAnMDgIcrOfsgTgqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372561; c=relaxed/simple;
	bh=rJ1pctPs0xvOqyF2SiLanfq2whzraxuHaYE2pLWCFnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgHuFdHygEtpHmV3603TUDZWs6lKm6RIbHvmzmti2BH5r25xPFacN6Gta8TKmWPVGUqjBLVGgDw92mHKEV3rQtopE4J+Kapy2MwkQSMzDb+SLezHNgc0LKhu7z0XT5QPqaGxlikvNV3SNT1cDWSE6ERJHaP7e1WI2SK8A8NS6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8GIU8z4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8GIU8z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB96C2BCB2
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774372561;
	bh=rJ1pctPs0xvOqyF2SiLanfq2whzraxuHaYE2pLWCFnQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D8GIU8z42uPdqQnOgaUsOMsL9PsqF7sj3VlsmHDWfwi1TkinZ4lHEHzHUL+mFgGBM
	 VZMhX6TrJmjfa/8euQPq1+b6iCfqsa56/I7pJGV7H7eWzlo9do/kwsmHx19ChupPGq
	 6iK8D344oEcEqh626AYWFAs/+PdpEWtVr4h48eynkyaAbKCY5dwQw9ZvDA59DDGsmA
	 /KccpwmFA/FAmNGz2ytCLFsKkh/CLVSlbWy/mgQmWAhHAwmsQtqe1cu26Qzobsla58
	 Y/dtfgTz5Gzs3uSI4uoh3kucRK0ZtkOWAiLCfLKLXDZaN5iUFKb8+mz0xPBdIrrGp4
	 ItW1gRe+KosjQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7447778b9so2145180a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 10:16:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMYcRLm1CYdscuNF62iYorw8CFEu1rVgNwRjPyFzvzmPPsd2u37uoRUoq16UksGHwvHZR14fz5oxoZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3w/kyejUHVBweO1TO/7vteDlgFP1QeQDygyTHwJFsYvkUMDi
	qRQJXHmxHKndHEfAsSrWnXcuiUMicXGbuIHFuqpWjsu5Hy3h9kzo2JUcYNXl382IrTWaaBwCs6T
	wruN2zRDp5caXmP56bfr2t6CotIZi2vk=
X-Received: by 2002:a05:6830:6afa:b0:7d7:5032:cc86 with SMTP id
 46e09a7af769-7d9d696e682mr54612a34.23.1774372560392; Tue, 24 Mar 2026
 10:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5084777.GXAFRqVoOG@rafael.j.wysocki> <acEOf2pI_NpfA4EP@aspen.lan>
 <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com> <20260324164023.GE2902881@google.com>
In-Reply-To: <20260324164023.GE2902881@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 18:15:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOguJV5QxjewOnFXc5zcGWTGkvvXO85ntuq=dD7uu3xQ@mail.gmail.com>
X-Gm-Features: AQROBzBNhJuJrMCZzWjpU-Y01kAsHD8yJNab0EMozPdjoBqQ2WLuUdt66_JkkCg
Message-ID: <CAJZ5v0hOguJV5QxjewOnFXc5zcGWTGkvvXO85ntuq=dD7uu3xQ@mail.gmail.com>
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
To: Lee Jones <lee@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 5:40=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 24 Mar 2026, Rafael J. Wysocki wrote:
>
> > On Mon, Mar 23, 2026 at 10:57=E2=80=AFAM Daniel Thompson <danielt@kerne=
l.org> wrote:
> > >
> > > On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > In all cases in which a struct acpi_driver is used for binding a dr=
iver
> > > > to an ACPI device object, a corresponding platform device is create=
d by
> > > > the ACPI core and that device is regarded as a proper representatio=
n of
> > > > underlying hardware.  Accordingly, a struct platform_driver should =
be
> > > > used by driver code to bind to that device.  There are multiple rea=
sons
> > > > why drivers should not bind directly to ACPI device objects [1].
> > > >
> > > > Overall, it is better to bind drivers to platform devices than to t=
heir
> > > > ACPI companions, so convert the Apple Backlight ACPI driver to a
> > > > platform one.
> > > >
> > > > While this is not expected to alter functionality, it changes sysfs
> > > > layout and so it will be visible to user space.
> > > >
> > > > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysoc=
ki/ [1]
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> >
> > Thanks!
> >
> > Unless anyone has any objections or concerns (in which case please let
> > me know), I'm going to queue up this one for 7.1.
>
> Why would you queue-up a Backlight patch?

Because I care about this change and it's mostly about ACPI.

> I'd rather this goes in via the Backlight tree.

Sure, no problem with that.
