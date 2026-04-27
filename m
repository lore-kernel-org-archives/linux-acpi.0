Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CC32694E
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302457; cv=none; b=vAB1o+9aEgVI+Wdejh8/wn+qIsBWK9G3eKGF16sOMs5StO0JIditF/CjpSda5kZg2BjRn9UwgUFyeRNWttBntfvCcfwhYWdSfLOUctuziMO3NDREDVI484AlKEXUX0ohJ4aLlESKGy7BBPumnCHpdXa6jAm3IM1ySnDzxTwLPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302457; c=relaxed/simple;
	bh=lAOMKeAh78GaAZdGv8qnD3UtQWYzQjoXOP7kks58Nsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF/mek+mEFcIzSchNDJz00t82YwDVWivzmnrNFfHYU2fe9zxhfsuet2nV2p1ZYbHgaLG5q8tQ4Ijgt35VKRK1Kfy+zCS5znVYTGBRQVBlzncAbY5aExHGOWwd4Ztyhs30B92E0uEza3b0s825Ww+0cAVFVqFpf+XAYZD48aLQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhrtn52d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhrtn52d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BFAC2BCC9
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302456;
	bh=lAOMKeAh78GaAZdGv8qnD3UtQWYzQjoXOP7kks58Nsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bhrtn52dQOioKttmXBC0pKNndmLFurFuVRJuczsSuhwZyG36Omu/6C7sHBL8FVyZX
	 n2Ty9kE1Ghjqngk8V/pU/S/OTLQ5f1hiTuxKcN8aFglZcyoyxUDozSBAi6bXe1iZ50
	 AUn9R8uRo7M7lUVMAC4BlKEJHLz1SduyxfIAvWrP91OPqwIqmnly4adkFTr4wRqD3D
	 OKDh84DUp5BdQF1dLqc5ZB4NiwUTtXbvxHGYFWBOqJoUOIVQkSXd3zjNpkc6mw9Nct
	 GUSA/MzHGtBEelvg1O9ql34l42uWhAiyKVBsQEvUDF5Em+DTdlCoRfXCluh7ORAL1b
	 RHS/8FGhSO5tA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a415fd6bceso11367802e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 08:07:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/u50zsG+DQr9FeFK45FWLRa+REFEvrnE4uTrQA49Azcb2ClWh2ZlJFXJSmw1HzDWhr2bmZcqZXk/6v@vger.kernel.org
X-Gm-Message-State: AOJu0Ywps5cWRaPebRd05vBazkZlDz7qdBsLRh83+LWIDZ2rg7UO70ZI
	wdq93tnpOMzrqfg0i587+naO0+XnpfXW4RsMmxCjEnP2boUPSN9HE7IscNyr8dGrz8Yrjpbt20a
	71wFmgC24R2oXSeUn57XgZwHyy9w+joo=
X-Received: by 2002:a05:6512:3ba5:b0:5a2:b370:f796 with SMTP id
 2adb3069b0e04-5a417287a78mr14128710e87.10.1777302455025; Mon, 27 Apr 2026
 08:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev> <20260425215734.14116-2-lkml@antheas.dev>
 <CAJZ5v0ipM9khNZs3uNu5GuFO3nJZ=EOht7mLtLNNsW9s9jWCsg@mail.gmail.com> <CAGwozwE4aqgBur-45whZManQzj-bMF4GUfA-oPk+huRnpkGRYA@mail.gmail.com>
In-Reply-To: <CAGwozwE4aqgBur-45whZManQzj-bMF4GUfA-oPk+huRnpkGRYA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 17:07:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icsPtG1JaMCBZUPDHAvzsOwxKQZiSMNTcNpdASMJq34g@mail.gmail.com>
X-Gm-Features: AVHnY4KzRX_ZRbV_VehzTpMgqf0QbXcy7KOi4ytw3bA60o7TAY-7PCGIC2_zrEs
Message-ID: <CAJZ5v0icsPtG1JaMCBZUPDHAvzsOwxKQZiSMNTcNpdASMJq34g@mail.gmail.com>
Subject: Re: [RFC v2 01/10] acpi/x86: s2idle: Rename LPS0 constants so they
 mirror their function
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmitry.osipenko@collabora.com, 
	bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net, 
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:08=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> On Sun, 26 Apr 2026 at 16:15, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Sat, Apr 25, 2026 at 11:57=E2=80=AFPM Antheas Kapenekakis <lkml@anth=
eas.dev> wrote:
> > >
> > > The LPS0 3/4 constants are part of a firmware notification called
> > > "Display on/off", in which the device enters a "Screen Off" state.
> > > The LPS0 7/8 constants are part of a firmware notification in which
> > > a Windows modern standby computer enters a "sleep" state where the
> > > CPU may still be active and maintain the radios.
> > >
> > > However, currently, the values are named as "Screen on/off" and "MS
> > > entry/exit", where Modern Standby is abbreviated as "MS". Therefore,
> > > perform a minor rename so that the values match their function. Then,
> > > fix the debug message to say that it executes notifications instead o=
f
> > > entering states as it is otherwise confusing.
> > >
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >  drivers/acpi/x86/s2idle.c | 84 +++++++++++++++++++++----------------=
--
> > >  1 file changed, 45 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > > index b6b1dd76a06b..61a044b59776 100644
> > > --- a/drivers/acpi/x86/s2idle.c
> > > +++ b/drivers/acpi/x86/s2idle.c
> > > @@ -43,20 +43,20 @@ static const struct acpi_device_id lps0_device_id=
s[] =3D {
> > >  #define ACPI_LPS0_DSM_UUID     "c4eb40a0-6cd2-11e2-bcfd-0800200c9a66=
"
> > >
> > >  #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS       1
> > > -#define ACPI_LPS0_SCREEN_OFF   3
> > > -#define ACPI_LPS0_SCREEN_ON    4
> > > +#define ACPI_LPS0_DISPLAY_OFF  3
> > > +#define ACPI_LPS0_DISPLAY_ON   4
> >
> > You've clearly ignored my feedback on this.
>
> Hi,
>
> did https://lore.kernel.org/all/CAGwozwE_QbiNk53+kTjwELtWhK31LCrBm5fgx2b4=
6sZa_5wjaA@mail.gmail.com/
> not address your feedback?

I missed that one, sorry.

> The notifications are named display off / on in the document you linked.
>
> I did not receive a response so I considered it resolved.

OK, fair enough.

I'll review the whole series later this week if all goes well.
