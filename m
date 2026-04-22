Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7A3DE438
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861387; cv=pass; b=c0gEJkKXxzllJkleF1DnArPbVbDSYrsB3AJA5WDrcnYBu9B3xsKUEU1CDdo5CYzPl3jV+yEtFOhhtohu9K0TLa/IgpnSlkGTahmQlwOd3702gjKcuSyfwiAWV6y2iG+vP8FPUb9HIoet2aS40bbPJBLkHYEZFhAWFtyUghKnwlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861387; c=relaxed/simple;
	bh=Z+fpeHyzZDcw59xaiG77ldoRBDmq2F4C7+ZCK7janFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAcCxicCYNku0iUc3gJpJkuv6f435OW8Lx3VUF6kkf53TsjvyVXcFGOz2xQHLYodAgJwwgjvo2mBI1ArhxGpxOdexHCkA8hpfIvXGZEiWCdNwYMBGJ05RdaXY7z0PbnFucLOcmu5igWva7diID1U8+PaWKb+Selwc20VoURzmCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTEOF8M/; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTEOF8M/"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba6838e76f2so459936266b.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 05:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776861381; cv=none;
        d=google.com; s=arc-20240605;
        b=LJJGgVHlkvGNPVMiPmCdiktkkyssXFe8KQsPV3hH8EZ+q2sXDSQJIvF3txut9Xx/o7
         OXpeacJzv6+o29yR1MW5NNfb2+1KxBLDE+hgUsZqjGOLFdNDtv36Tf/lY2dKVGz8w0xO
         4D1fgiW+GZJI/Z5CJV/jpRf8OuII+pfP0ryOvSThYf4XaWK0IRzFVVVS+a1Bt9mio8mP
         JPxJjP9R3TTbV33m4LJUYbm0k+DcQtjd4B6w/xwpSVctdMtciFikcJ0o5EkJoGSvLtHX
         5T8Jlrc26w6IRW4c0tS4LyDX6Sx2m28KzNldRiJBUTWP1kgKHMo7c5xemwYEMY9F3taT
         6iyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6YjFqGBtJU0cul8X9lP9Xhlf/J/5zOSe7U09Cg9PaM=;
        fh=MFEoJK3akg87S0uBheEpCnJjPIW0VVJ77cW7kCT7J+k=;
        b=QNB4/vtMFvTDIu6jO1MVN0wvTu3NiVkchn6GZ1RcmsUFluuiDWkt99ETiMS44FrfPT
         l4hsVMstHkHnfQN8TsV7qw6qtv2ubl+y1VqKL6+S+9X1KgSbKBra26xgzf26riFl2fWN
         Zn7YI6vUmS2Wc/bf2PyGxeCR1YEXMkpVFv/Oi8ihYrravdiDURuK1vcp2lUTzmyU0mvJ
         NOh3rfeWuKtk+kCEgYrCKQssPQhuubMRvypoDJxIOW7yMtBVQ7quyq2nwIF0iJQcpnvy
         Pg0Z0E6qHJHhS6yUMPErXlqVqmkEP8s9GQ/Bw2RF2y9o+JGzLOzIziIwb8jl2vhw3Scl
         5MIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776861381; x=1777466181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6YjFqGBtJU0cul8X9lP9Xhlf/J/5zOSe7U09Cg9PaM=;
        b=HTEOF8M/RWBgmV1bjpK/g65QjBEwf23hYLcE0aLJ77qQmbcqUkZNzp/X335HQRKqMK
         erYniBFNBG2u4TONz9h+rVMJShsvtOOoas3OiR2vPIRPusQlTF6KHTrjI2ZDmuTw88Vs
         R79sZ96BHTdAjO1y7jgnBzM2CBrs8MLiIrKE90Nl8JqkQM9OJMn3wI/k+A5pUI6nFXgp
         YYR4L6vfKmhb/at8d0cZbjxU+nUFLzRaahoC2ZhqzPPZ345w8Nzlk4PKSEY2MJNYu7iB
         m5QSfCFMxZ+D87t40JronCF445wcUvBHwDT7qq1fFA66eodDH/AcsilK8sk+ZFmjdUCm
         R3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776861381; x=1777466181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6YjFqGBtJU0cul8X9lP9Xhlf/J/5zOSe7U09Cg9PaM=;
        b=p+rRfCgSDts3KT+xzUtzRegOwFo8g/tTHzRgjSHOT9b5oA/DqseaD6TMvWL5RdjMY0
         qVXFA9bjN7cpCu1ATBa8xX7o2Z/HkjMi+wWY1BFb8vflebguSQmkI60L3uinDdVeesvb
         aeMv2cvfGwZa77a6W1fwiCyHtk84rsBgypW0gejCwrE7Al3S5S5PePdzgjxqYpz5/ge0
         xJU4SDR7PwNCH2XZ7pViE42+C667DU9IjZdsDpYamMOX0bwi+EvzGMT4PTe5kKq9sfC0
         RGSB5q/KnBmLGQrbPcTtvDN1IuXTKq4v1dmUXoUWJaiVGEBCRNNZiN/fgBSsLntg37KG
         8Wdg==
X-Forwarded-Encrypted: i=1; AFNElJ9rmMLm8sWGZ43piFROLhjkxc/p76rmA89Wn8q9rgwEmU4Wvwp/iWHj0ERXJQZ4NSrENeJdQKh6OKDa@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPhNQAQB/dDg/BqvfjbS2iRBoeFiex5ouGR4l74L8mgxJtQZq
	UN3DXFN8ZNtBgm3qBQPC698Z9I4k5kuOM3o3A096ICYiZS/vjlXUIj1ia67PDtI20cjbDZCXQNG
	O/zPQHkucy9VTgvKb0/KZAOC0HshY3SiqV0aL
X-Gm-Gg: AeBDietUMlqJv8/SOgQUDrYSuGEaWaSuXWgjBBMLI7TUAvFFCi7uJJcG3wTkov77Pfa
	ugUAscGyK3IzZw/o1IynLMoPYWnppXfeV/Est5z4goSV4bnSJVODycrUo1WKHqgmusLQJmafTj5
	bbA6vBUIC4bP2ChUIxFy7UrZBTlpI987vFRA9db7BfL4oRAWbMHoW6/GWWcQWodL6idtbMo2JrP
	baFWrQbeBt5aosXeSnlBYDIyUmAxDvofzG4xAnlUS0ADUL6PKpHjIVlHdogRYo0ndovRHKYSU5y
	ShlKHVTM0SQcseEWcQ==
X-Received: by 2002:a17:907:96a1:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-ba7fbfb4d91mr657508366b.43.1776861380344; Wed, 22 Apr 2026
 05:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <168591776860440@mail.yandex.ru>
In-Reply-To: <168591776860440@mail.yandex.ru>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Wed, 22 Apr 2026 15:36:08 +0300
X-Gm-Features: AQROBzDtGf9k7R1EsVMKW6DV83lURu0DqePYdX100Md0YGa0t--tWKYIatVxa1A
Message-ID: <CAGAxtY1QDN_vkXEzdT8yUC5ZR3W+18TypEcJLR+-=kUkaBOdTw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Rafael,

I applied the patch that you sent.
The PC isn't responding to the power button press. It doesn't freeze.

I just want to clarify, did you receive messages where we found the
first broken commit using git bisect?

> 8c94ccc7cd691472461448f98e2372c75849406c    good
> e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27    good
> b0d326da462e20285236e11e4cbc32085de9f363    bad

I'm getting messages that my emails couldn't be delivered, so I'm
using another email address.

----
Sincerely, Evgeny Sagatov

> On Tuesday, April 21, 2026 5:11:36 PM CEST Wysocki, Rafael J wrote:
>
>  Hi,
>
>  On 4/13/2026 6:46 PM, Evgeny Sagatov wrote:
>  > Hello,
>  > I have a PC with a motherboard GA-EP45T-UD3LR (Rev. 1.0)
>  > <https://www.gigabyte.com/Motherboard/GA-EP45T-UD3LR-rev-10> and
>  > processor Intel Core 2 Quad Q9550.
>  > Previously, I had Debian 12 with kernel 6.1 installed, and pressing
>  > the power button would shut down the PC as usual.
>  > I updated to Debian 13 with kernel 6.12.74, and now pressing the power
>  > button causes the PC to freeze completely.
>  > I see that systemd doesn't even begin to shut down. It freezes
>  > immediately after pressing the button. There's no error message in
>  > console. There's no error message in the logs either. Netconsole
>  > doesn't report any errors, and the kernel doesn't panic. It just
>  > freezes completely.
>
>  It looks like the ACPI button notify handler crashes on your system for
>  some obscure reason.
>
>  It should be possible to get to the bottom of it, but it will require
>  some investigation if you have the motivation and time to run debug patc=
hes.
>
>
>  > I checked that Live CD with Debian 12 continue to shut down normally,
>  > but Live CD with Debian 13 freeze.
>  > I tried updating and resetting the BIOS. I tried various kernel
>  > parameters related to ACPI settings. I also tried kernels 6.18 and
>  > 6.19. Nothing fixed the problem.
>  > If I unload the "button" module, the system doesn't freeze, but it
>  > also doesn't shut down.
>
>  This is a useful data point, thanks!
>
>
>  > I built "button" module by rolling back its version to commit 1a20d40
>  > <https://github.com/torvalds/linux/commit/1a20d409c874255086e2f42a7298=
26d490294c91>,
>  > which corresponds to kernel version 6.1. This module does not freeze,
>  > but does not turn off the PC either.
>  > I've found that the freezes have been occurring since commit 0d51157
>  > <https://github.com/torvalds/linux/commit/0d51157dfaac05ea66616d8a250d=
ce04bef49a4f>.
>
>  The main difference made by it is the fixed events handling and if there
>  is a problem with that, a few debug patches should suffice to find out
>  what's going on. I'll send you one to try shortly.
>
>
> First off, on top of 7.0.0 (since the issue is present in this one, I thi=
nk
> it's better to focus the debugging on it), let's first check what happens=
 if
> the ACPI fixed event handler is not installed for the power button at all=
.
>
> This should be similar to using a 6.1 version of the button driver (that =
is,
> no crash, but pressing the power button will have no effect).
>
> Please test the patch below and let me know what happens.
>
> ---
>  drivers/acpi/button.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -628,9 +628,7 @@ static int acpi_button_probe(struct plat
>
>          switch (device->device_type) {
>          case ACPI_BUS_TYPE_POWER_BUTTON:
> - status =3D acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> - acpi_button_event,
> - button);
> + status =3D AE_OK;
>                  break;
>          case ACPI_BUS_TYPE_SLEEP_BUTTON:
>                  status =3D acpi_install_fixed_event_handler(ACPI_EVENT_S=
LEEP_BUTTON,
>
>
>
>
>
> -------- =D0=9A=D0=BE=D0=BD=D0=B5=D1=86 =D0=BF=D0=B5=D1=80=D0=B5=D1=81=D1=
=8B=D0=BB=D0=B0=D0=B5=D0=BC=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D0=BE=D0=B1=D1=
=89=D0=B5=D0=BD=D0=B8=D1=8F --------
