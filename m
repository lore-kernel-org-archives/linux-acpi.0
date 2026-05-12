Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B6359A99
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581877; cv=none; b=R0/7vKZd6EWvmGXiUyIFIQNFyyOPFxD+3aJ7HJEpwBixNoToM8pucNlFw0pNHV6PiK4ifqULnl4oDgXG1l2l0baDTPEo7MrOPz9UquRpju39Weyk+R2cIn27h2rqQRcZS10djEVW2s34ueX7smBsIP1ALkHmv6Tp60F2t6KXpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581877; c=relaxed/simple;
	bh=C1gNCCHOCyF1JrqXYOWHE0ijJ7DHcfboPefm7j4rXS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlM5quM8xMi1WLvtiKs1MZi8wWqzNGx4arO2aslYtki62GaDhK1Z9CXS/6TChutD6RPC26kgl1+cbho1SrqlTNco2VpaAJptvFzMkVMkw+GIOoGF6nS5ZUCXRYvmEfFcsYMbGrKhPcQ8Ysz1ojm50HxMQRg5udEWRZNu4UXLqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLv5+5u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLv5+5u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B8C2BCFC
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778581877;
	bh=C1gNCCHOCyF1JrqXYOWHE0ijJ7DHcfboPefm7j4rXS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HLv5+5u3GOOf+eXZG6q4pJskMyXYuqXu+SJTrg5pvL2JKjGpPqDCe7yDSaULyc8Lk
	 5lTGwMuDWtfAepJoHtWYe1JqA4VLwSjw5AUV0/L9lZ2lomfujvT1uJxRHPRZxt3kRK
	 4cIT0f09XEeECxpu/VmU37kgxv6h2aRNo61gSnQhhscRLQlTLFh4NlnsB/4f1p+6A0
	 oIOp8Q6leN5c66yTmsz6TU1pnvyS2vBUL6mUiv466wIj+NFoOqXGzCRIAJDDdF1tT+
	 JrCJY6iRpgD16jwl6QvndR/EZyqOvLJ4n93NXf+ZDj3+5vf88A+jryQuv1DCwueKLI
	 Ki5SzrILT5h4w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so2790332e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 03:31:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9wiCPmPFNaJtzz6Ybgo2EgIBhlElScgw4EGgjz1c5PUycJ3NZGgx8tpLyWhJS+07/02uzHfJXf4Mrk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7unP7stBNm6Il9TGU0hwODdbJPqLhsqRQHyHu8ALbyCwBO6YM
	TjnUsfnMezOs/tTGPVaKhzONhrbs7O3bmAYor5YTIqtR/tYF/To797FKChXCcV6+xguOb3DcHP7
	dcPd/Vv2DEMeMZzIjkxv2AiqOWzGXd7I=
X-Received: by 2002:a05:6512:6d2:b0:5a8:a558:63b8 with SMTP id
 2adb3069b0e04-5a8a5586471mr6294020e87.17.1778581875556; Tue, 12 May 2026
 03:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5990022.DvuYhMxLoT@rafael.j.wysocki> <agLV5STILBnNNfWH@ashevche-desk.local>
 <2bb54d48-e06c-f187-4d0f-53d9c4567e74@linux.intel.com>
In-Reply-To: <2bb54d48-e06c-f187-4d0f-53d9c4567e74@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 12:31:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hA4Fi-6omUGNfFgmd4h4ts9-qTyhmiqX3dQsX5ssAzoA@mail.gmail.com>
X-Gm-Features: AVHnY4LCRJNQ0sKKL52ew_XywxiXE7-wYxNIEf5vlY8Vw1TGipDLLd7-twB8Fl8
Message-ID: <CAJZ5v0hA4Fi-6omUGNfFgmd4h4ts9-qTyhmiqX3dQsX5ssAzoA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: Check ACPI_COMPANION() against NULL
 during probe
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>, Matan Ziv-Av <matan@svgalib.org>, 
	Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>, 
	Jeremy Soller <jeremy@system76.com>, Azael Avalos <coproscefalo@gmail.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:53=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 12 May 2026, Andy Shevchenko wrote:
>
> > On Mon, May 11, 2026 at 09:48:26PM +0200, Rafael J. Wysocki wrote:
> >
> > > Every platform driver can be forced to match a device that doesn't ma=
tch
> > > its list of device IDs because of device_match_driver_override(), so
> > > platform drivers that rely on the existence of a device's ACPI compan=
ion
> > > object need to verify its presence.
> > >
> > > Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> > > against NULL to multiple platform/x86 drivers that have been converte=
d
> > > to platform drivers from ACPI drivers recently.
>
> I was already wondering about when the NULL check is necessary not that
> long ago, as some many places seemed to be lacking the check.

I have to admit that I overlooked the device_match_driver_override()
thing that is key here.

> > > Fixes: 578bc2a53ae2 ("platform/wmi: Convert drivers to use wmidev_inv=
oke_procedure()")
> > > Fixes: f7e648027d7e ("platform/x86: asus-wireless: Convert ACPI drive=
r to a platform one")
> > > Fixes: ba19eb10170b ("platform/x86: asus-laptop: Convert ACPI driver =
to a platform one")
> > > Fixes: 3a96c7915d93 ("platform/x86: toshiba_haps: Convert ACPI driver=
 to a platform one")
> > > Fixes: 553b2ac59fbb ("platform/x86: toshiba_bluetooth: Convert ACPI d=
river to a platform one")
> > > Fixes: 246d6cefe525 ("platform/x86: toshiba_acpi: Convert ACPI driver=
 to a platform one")
> > > Fixes: 19ebacfb442b ("platform/x86: dell/dell-rbtn: Convert ACPI driv=
er to a platform one")
> > > Fixes: 80b8f68b94ab ("platform/x86: system76: Convert ACPI driver to =
a platform one")
> > > Fixes: de6837243af0 ("platform/x86: panasonic-laptop: Convert ACPI dr=
iver to a platform one")
> > > Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to=
 a platform one")
> > > Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver=
 to a platform one")
> > > Fixes: bd13b265d386 ("platform/x86: fujitsu-tablet: Convert ACPI driv=
er to a platform one")
> > > Fixes: 8507277ef132 ("platform/x86: wireless-hotkey: Convert ACPI dri=
ver to a platform one")
> > > Fixes: 3471415c8186 ("platform/x86: topstar-laptop: Convert ACPI driv=
er to a platform one")
> > > Fixes: 138db7ee58c0 ("platform/x86: sony-laptop: Convert PIC driver t=
o a platform one")
> > > Fixes: 14004dd31caa ("platform/x86: sony-laptop: Convert NC driver to=
 a platform one")
> > > Fixes: 2d9cb20610f7 ("platform/x86: lg-laptop: Convert ACPI driver to=
 a platform one")
> > > Fixes: 8a44bd3ffdb2 ("platform/x86: intel/smartconnect: Convert ACPI =
driver to a platform one")
> > > Fixes: 163a68a31f74 ("platform/x86: intel/rst: Convert ACPI driver to=
 a platform one")
> > > Fixes: 079b59fd2d79 ("platform/x86: eeepc-laptop: Convert ACPI driver=
 to a platform one")
> > > Fixes: b30a462720ad ("platform/x86: acer-wireless: Convert ACPI drive=
r to a platform one")
> >
> > Looking at this I would rather see the series, but am not a maintainer =
here and
> > I'm fine with the result.
>
> It would probably be better to split this per driver. Lets say somewhere
> in future stable people want to backport some other fix which has this
> change as a prerequisite, it will be simpler for them to handle if they'r=
e
> not all together.

Sure.

> > As a single patch or as a series
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy!
