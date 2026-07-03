Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C93C819E
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081482; cv=none; b=B99Eek30+DlMkQWgzyae4I2jIo6cWrB4FhI8Wj7D9Yd4tHOZ7tn+i0NEScl2bJy+NwMrit2JKwGgAkSJaGtmh/V08exmyJflDrMG34L73f++1Z4lyaA7tEhUbfZ5FHwyNgI2f++0w+f6x6uzlfnq+o12GpLX3tqD5FVSxiV5/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081482; c=relaxed/simple;
	bh=11ddIWVSTTVnM2cM9G+vdAOaYF2hlWJNuDgVSRrIWAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmabphVlDJ4sGNtGtAA1jiqGR3lrBfTC8PXic/MlfNuCYccetU4kcNMFX6dTfH6emjhaxwf87sTlorA9OpQTfowy0FBTs24giCC9zaes0OvtbnCmYI/yWte68XcBEzrecAv6pdugRwDvgOzeGec51YLbpfrpeLyIblG4jthAJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSsXr/Qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSsXr/Qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC61F0155D
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081480;
	bh=11ddIWVSTTVnM2cM9G+vdAOaYF2hlWJNuDgVSRrIWAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XSsXr/Qy14o5yxDXbrK1+6cYkK8wleAtPF7ayQ9Ks8av8+CYBIAlUI4hMq3Dz7B/J
	 4L/DdhR7JW7+gTaGtPTJn2gcFQd2SKyojsttKWjh23iHNY8qifgKRAl+YvynahwUUL
	 1Z11gmVuqEHBYp0J4XxJPz58g1T0Ummbfux/+pBQkhZv76y3B3dcvbZqoGpJSuLGMG
	 auSCDRox5yZsvtSvcqPG+dSuH6bR2aZWRF1AxLf9M+S6uH2/YX0v7qvLVitRwEBWgA
	 lxrS0PuIzzmzFvGy6ZGZfqJcGgwaGkhuJLQtjpLbAdtLIj82UDDReE3jZhr96Rn/wy
	 zE+kWOLi0KIPA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39b1eab2f29so15080581fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:24:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpsP9uOxxdz18zzgtYOWnprrBsucKJFYkkmTMdhcI6RL7oe4aIHHtS0XP+RssC0+KWrntiDezP62fXC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0SSbHderRH9S2vUwTcfhDwD4Nv9cqrgndZ6xIyBhrKtnXD9c
	8VSLDcGk3FsBxcCGLJGIt2Y4d1SILgX9jEOZD8muu86Ds+U7azKf2H5Q5wlfHd6oIkxiqOFrBXs
	FZDRg37DeqUQCuUMNrHCEQUbd9cb4DwU=
X-Received: by 2002:a05:6512:8345:b0:5ae:b4bc:9109 with SMTP id
 2adb3069b0e04-5aecf4bf6aemr692157e87.10.1783081479252; Fri, 03 Jul 2026
 05:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5135166.31r3eYUQgx@rafael.j.wysocki> <akemrOqzWtcDVqey@ashevche-desk.local>
 <akeo1CfX1ayQPPew@ashevche-desk.local>
In-Reply-To: <akeo1CfX1ayQPPew@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 14:24:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0it+WWyuHeHdk5-Jww3h+H34Tbd5-6sEwHnMvtmya=s-Q@mail.gmail.com>
X-Gm-Features: AVVi8CeK3zBZREeS0k_UGGfmzL_7OdoW8MOyxhYMuPu7iyTAiNjbS9VZIDtLjnc
Message-ID: <CAJZ5v0it+WWyuHeHdk5-Jww3h+H34Tbd5-6sEwHnMvtmya=s-Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using acpi_device_name/class()
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

On Fri, Jul 3, 2026 at 2:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 03:10:26PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > There are two fields in struct acpi_device_pnp, device_name and devic=
e_class,
> > > that were supposed to be populated and used by device drivers, but th=
ey have
> > > never been used consistently and some drivers just populate them and =
don't
> > > access them later, and some drivers use them uninitialized.
> > >
> > > All of that is confusing and messy, so the drivers for core ACPI devi=
ces
> > > have been updated to stop using those fields which are now slated for
> > > removal, but they are still accessed in some places.
> > >
> > > This series updates platform x86 drivers accessing those fields to st=
op
> > > doing that.
> >
> > In most of the patches you have double space in your name in From. Can =
we have
> > some consistency here? Or is it deliberate (in which case I'm wondering=
 why)?
>
> I looked into all patches and I see them good.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> (with preferably used same From field across the patches).

What goes into commits is the one in the patch body (which overrides
the one in the SMTP headers), so it is the same.

The one in the SMTP headers has indeed been messed up by the email
client, but it doesn't really matter.
