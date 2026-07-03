Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D83CC7EA
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081251; cv=none; b=CeHacb2WA5johBRObDn4E+mYC/GlOlUF/1xZ0Dg7EUwU/whHU1b6LWhUaBuBfRyROewkO88ltY7edVFkSuPytRpyZ7cm9sMpJZXYOGtV8gbklPdf7AvjUmUb1iKJDl5SE4yyYOAuugM5iE5rXiK/ObZ4PirmfyX/iN/m9qCP53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081251; c=relaxed/simple;
	bh=1ft6eBC5qSgyCao5fssxbUPrc4L+zHx4bkwqMWIJPuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg2M7CziZ5apjZhN+5N7UVuOPn5cAScD1OPaNvP/PF/dnznHShwbhB6uhsRXYBtlXoJEzJItuwzqeWgjMVdCKB1rcevqLwfvTJNJKG/mnrBBwmJohdFNbMkDSBD9oWL+o5Yg4zWneZ67Wa7lNY1sx11C5eZyhJoB5MZf+lBW2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll4G5YMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll4G5YMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8391F0155D
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081249;
	bh=op6UzruBl6JxCpoMmFhu44wfH07DDTryRdDldVcdG2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ll4G5YMjeNHWPicE6oeS8/kvtHq0jd5CqiYQlfgyDNDI90e6wzHeWIs9fMFHA6Ra9
	 Vr6rEWvx10fYUKEmnChQHTOvOoIg1IBHAg7TM1t++qZ3sX8AS7TBw/dv/HiNsRFbaa
	 5AUtydM2x0/A178bhpumCJnXUyk1/bNP1D07/bNvo3wSOedoJAI3EvnoLhoxdj5HqX
	 Fdn/c6GYqEQmn2Mtd/WqPn/JI2dgiJaRLJSlE22pZ4P8B+UIU8LHPCxuqiNEIveMji
	 J68da6E5cHrsM9iVikh+OhW6bxn13bMvwk1WKexdy9i6KjFWEw4277tG+ixLqPnt9L
	 5KVvoX6trqovQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebf9a509eso546361e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:20:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrJTVW0gvsUO4ulflRMXoxnYGFwlEthT12PkqvNiemGd6Ojii+hBZI7YMkvhphknJnruJssIbglj36U@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSc2x0vnFDqwB4G5QDoYrC4DUtO9IExyEgJ7sTsCL4hYfjpJ4
	h0PEZAkSnPcTBgKa+MiR9QOKeEZtR1S+mn4tcnNPtcCbqe0enf0i77qDJEP341vsEXivps0C/aA
	4zEATnl/fF8iKuiUW3qciiMrepX+Nohk=
X-Received: by 2002:a05:6512:8388:b0:5ae:b711:72ca with SMTP id
 2adb3069b0e04-5aec8065e27mr1950170e87.45.1783081248275; Fri, 03 Jul 2026
 05:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5135166.31r3eYUQgx@rafael.j.wysocki> <23182921.EfDdHjke4D@rafael.j.wysocki>
 <akeoeAzCjTlGc_lz@ashevche-desk.local>
In-Reply-To: <akeoeAzCjTlGc_lz@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 14:20:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMrX41jMgz04Hf1hDTTpgU=m_1a-LM=xpAYpj=3jDLnQ@mail.gmail.com>
X-Gm-Features: AVVi8Cd-4naswoFJD3YiM_amrZrSYAYGmr8wgZFf-TqwPxjYNGpirWh-ji6PfIA
Message-ID: <CAJZ5v0hMrX41jMgz04Hf1hDTTpgU=m_1a-LM=xpAYpj=3jDLnQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] platform/x86: thinkpad_acpi: Stop setting acpi_device_class()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>, 
	Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
	Mattia Dongili <malattia@linux.it>, Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 01:30:00PM +0200, Rafael J.  Wysocki wrote:
>
> > To facilitate the removal of device_class from struct acpi_device_pnp
> > in the future, make the driver store the device class string used for
> > generating ACPI netlink events in a new device_class field in struct
> > ibm_struct.
> >
> > No intentional functional impact.
>
> ...
>
> >               acpi_bus_generate_netlink_event(
> > -                                     ibm->acpi->device->pnp.device_cla=
ss,
> > +                                     ibm->device_class,
> >                                       dev_name(&ibm->acpi->device->dev)=
,
> >                                       event, 0);
>
> In other cases you condensed the code a bit, not sure if you want to do t=
he
> similar here
>
>                 acpi_bus_generate_netlink_event(ibm->device_class,
>                                                 dev_name(&ibm->acpi->devi=
ce->dev),
>                                                 event, 0);
>
> >               return;
>
> ...
>
> >               if (send_acpi_ev) {
> >                       acpi_bus_generate_netlink_event(
> > -                                     ibm->acpi->device->pnp.device_cla=
ss,
> > +                                     ibm->device_class,
> >                                       dev_name(&ibm->acpi->device->dev)=
,
> >                                       event, hkey);
> >               }
>
> Ditto.

It can go both ways and I settled for changing fewer code lines.
