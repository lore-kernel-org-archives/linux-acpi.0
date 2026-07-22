Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C040F75B
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718529; cv=none; b=U3B/jynbz54ZlM6Ev0kewIM5poyozsVaNWSxsV/dw1dbaECnBg6Bt+iVreJqURPMEN2WWEQ/EXrDsDci5+HG1FF6XvgZOfsRBhhu3uZRzjSY1Ct1bozBVguR0zMAANM2LH2BQuhAH6ZXl3Fa5gmZRXvyQrwCOSEWuOs0LzK3OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718529; c=relaxed/simple;
	bh=q9Vfp9+BUPgfM8McK/GKeoVJuJvwFGnq+DMLWcyhFRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9EDLMuOeR4fN4t75cfvAaq7DPneLAPh/TTBezNxMx29eX66ak7Nmzu4j4LeeYQyvlNFJo0l0DCKGGAxWZJL7QH8iJC0V16e+/grekGZ2bIqC5jGNd/rUpqTs2keYsVhQxwnnnS+HbEQ3hYNrOqS0KLbcImq7CJs4ff9wbaUK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhwfcgye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhwfcgye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ABA1F00A3D
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784718527;
	bh=q9Vfp9+BUPgfM8McK/GKeoVJuJvwFGnq+DMLWcyhFRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bhwfcgye4giAFIOokonXOk8ofx24Okh1ApRyP8QzBjqKWN/jKRvPuP97WfXky1Js5
	 61Ic/jhWSxf/k84OXvhWt5SIU76rS/b0RXVtZh9FQOhc8xzEgQdEPfUvYXmfBYkaTf
	 9nEHoXLEFftos+Dma4ghCIUdHk3yyYAhqHzh1GWFfzByUqTTMzv07ofxl0N+2/2a8z
	 O65PSbWvwb/ruJzoPMCMIC7bazmIy26pccwOdKtoVNvyXSi1cBa1M0rD/cVGJJ7PGC
	 GMZScOxraSh1jxn7wYdA37xZYDvSSfR5ZqvXPec8Q6BKQS1ejKYvV2H3zQBmNAwx5+
	 m3yvJedd9bs3A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b3931e259so109283181fa.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 04:08:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8scBL8W8Sj5b7lqpURK+SnBGxCBcDw0svBSTmWFgSRhuurHUP
	lrhWmwaZaNIpqtywrb43oOwdvegeMz+N1NdoiYY1L0G1A+YW5bntPuCfFSK+du3nw2ZXSmocVmW
	XIOYI3dEZ3Sx4BxDLz6zSzciGdSRVA44=
X-Received: by 2002:a05:6512:3f1a:b0:5ae:b99e:4c39 with SMTP id
 2adb3069b0e04-5b28fac2266mr5856621e87.61.1784718526247; Wed, 22 Jul 2026
 04:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69a1eaf0-4a58-47d5-ad94-2af958f84841@gmail.com> <cc383c33-d0ef-40fc-9c14-865a6d7f5d75@leemhuis.info>
In-Reply-To: <cc383c33-d0ef-40fc-9c14-865a6d7f5d75@leemhuis.info>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 13:08:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iv0FpUN=QRWSwDT6zs5tP_n0jif1jMVdOb5AHMQGs-yQ@mail.gmail.com>
X-Gm-Features: AUfX_mxrMFwyKjDfg9cxFfItcE_FULwSJ0DjeRl0pEylWNMudrviEz6jMynDFjk
Message-ID: <CAJZ5v0iv0FpUN=QRWSwDT6zs5tP_n0jif1jMVdOb5AHMQGs-yQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Regression=3A_Backlight_control_broken_on_HP_Omen_?=
	=?UTF-8?Q?15=E2=80=91ax246nf_with_kernel_7=2E0=2E0=E2=80=9128=E2=80=91generic?=
To: Thorsten Leemhuis <regressions@leemhuis.info>, harryblanc <garett26@gmail.com>
Cc: linux-acpi@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:26=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 7/18/26 11:05, harryblanc wrote:
> >
> > I would like to report a regression affecting backlight control on my H=
P
> > Omen laptop when using kernel 7.0.0=E2=80=9128=E2=80=91generic (Ubuntu =
24.04 base, Linux
> > Mint 22.3 XFCE).
>
> Hi! Thx for your report. But this is a heavily patched vendor kernel and
> also a series that is EOL. Please test latest vanilla 7.2-rc or and
> report back. Ciao, Thorsten

I was about to ask for that too, so thanks for mentioning it.

> > Summary of the issue:
> > With kernel 7.0, the screen backlight is stuck at maximum brightness.
> > Brightness keys show the OSD and the slider moves, but the actual
> > backlight does not change.
> > With kernel 6.17, brightness works normally.
> >
> > Hardware:
> > - HP Omen 15=E2=80=91ax246nf
> > - Intel i5=E2=80=917300HQ
> > - Intel HD Graphics 630 (i915)
> > - Nvidia GTX 1050 Mobile (disabled via Optimus)
> > - Linux Mint 22.3 XFCE (Ubuntu 24.04 base)
> >
> > Backlight controller:
> > /sys/class/backlight/ =E2=86=92 intel_backlight
> > acpi_video0 is no longer present under kernel 7.0.
> >
> > ACPI errors visible only with kernel 7.0:
> > ACPI BIOS Error (bug): Attempt to CreateField of length zero
> > ACPI Error: Aborting method \_SB.WMID.WQBK
> > ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT
> > ACPI Error: Aborting method \_SB.WMID.HWMC
> > ACPI: video: [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS

So it looks like 7.0 uses a different ACPI object as the video bus
representation.

Please send the output of "ls -l /sys/bus/auxiliary/devices/*/" from
the failing kernel.

If you are still able to boot the 6.17-based kernel on the affected
machine, please send the output of "ls -l
/sys/bus/acpi/drivers/video/" obtained while it is running.
