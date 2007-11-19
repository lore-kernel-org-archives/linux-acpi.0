From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] Fix segfault when printing battery status
Date: Mon, 19 Nov 2007 11:29:26 +0100
Message-ID: <200711191129.35144.eike-kernel@sf-tec.de>
References: <200711182049.33355.eike-kernel@sf-tec.de> <47415B46.4020709@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2184877.l21UsChA7X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:34254 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbXKSK3m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 05:29:42 -0500
In-Reply-To: <47415B46.4020709@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, kernel list <linux-kernel@vger.kernel.org>

--nextPart2184877.l21UsChA7X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alexey Starikovskiy wrote:
> Rolf Eike Beer wrote:
> > cat
> > /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:19/PNP0C0A:00/power_
> >supply/BAT1/status
> >
> > This leads to a stacktrace as acpi_battery_get_property() returns 0 for a
> > case where it does not set val->intval. These value is used as an array
> > index in
> > drivers/power/power_supply_sysfs.c::power_supply_show_property(). I had a
> > situation where the value was 4096 which caused a problem as the array
> > only has 5 entries.
> >
> > Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>
> Rolf, thanks for remainding.

Huh? This one is unrelated to the problem I reported two weeks ago...

Eike

--nextPart2184877.l21UsChA7X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHQWWPXKSJPmm5/E4RAgNlAKCHRIwRVuigu0lk2RE97xYYDzBycwCaAui6
TevAlfFcnWQjjycise8vP34=
=QEBS
-----END PGP SIGNATURE-----

--nextPart2184877.l21UsChA7X--
