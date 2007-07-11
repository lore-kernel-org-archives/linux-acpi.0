From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] Re: Hibernate after alarm wakes from STR
Date: Thu, 12 Jul 2007 08:48:53 +1000
Message-ID: <200707120848.54398.nigel@nigel.suspend2.net>
References: <20070330235759.GC4252@cosmic.amd.com> <200707110816.42114.nigel@nigel.suspend2.net> <200707110904.33696.david-b@pacbell.net>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3160234.rlXZoVkKrB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nigel.suspend2.net ([203.171.70.205]:36770 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762816AbXGKWsz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jul 2007 18:48:55 -0400
In-Reply-To: <200707110904.33696.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: nigel@suspend2.net, linux-pm@lists.linux-foundation.org, Marcelo Tosatti <marcelo@kvack.org>, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com

--nextPart3160234.rlXZoVkKrB
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 12 July 2007 02:04:33 David Brownell wrote:
> On Tuesday 10 July 2007, Nigel Cunningham wrote:
> > Yeah, the bit I consider to be ugly is opening the files from within th=
e=20
> > kernel, but it seemed to be necessary in order to provide the=20
functionality=20
> > without having to rely on userspace or do some sort of messy work to=20
figure=20
> > out how to access the lid button and so on.
>=20
> Perhaps there should be a formal API to such buttons.

That would be good.
=20
> > Re proc files, are the button files already exposed under sysfs and I j=
ust=20
> > don't know? If so, I'll happily shift to using them.
>=20
> ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$ ls -l=20
> total 0
> lrwxrwxrwx 1 root root    0 2007-07-11 08:58 bus -> ../../../../bus/acpi/
> lrwxrwxrwx 1 root root    0 2007-07-11 08:58=20
driver -> ../../../../bus/acpi/drivers/button/
> -r--r--r-- 1 root root 4096 2007-07-11 08:58 hid
> lrwxrwxrwx 1 root root    0 2007-07-11 08:58=20
input:event2 -> ../../../../class/input/input2/event2/
> lrwxrwxrwx 1 root root    0 2007-07-11 08:58=20
input:input2 -> ../../../../class/input/input2/
> -r--r--r-- 1 root root 4096 2007-07-11 08:58 path
> drwxr-xr-x 2 root root    0 2007-07-11 08:58 power/
> lrwxrwxrwx 1 root root    0 2007-07-11 08:58=20
subsystem -> ../../../../bus/acpi/
> -rw-r--r-- 1 root root 4096 2007-07-11 08:58 uevent
> db@ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$ cat path
> \_SB_.LID_
> ascent:/sys/devices/acpi_system:00/device:00/PNP0C0D:00$=20
>=20
> If the generic kernel doesn't show that, then it's likely
> a consequence of a submitted-but-not-yet-merged patch.

I have that too, but I can't seem to figure out which file contains the sta=
te=20
of the button. Is there one?

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart3160234.rlXZoVkKrB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlV5WN0y+n1M3mo0RAnraAKDlXHCn+jtLkH48DfPsdo7UqvwpFQCgw/mf
cxpDt3cywr2fhOJCXzhTWZE=
=gNIW
-----END PGP SIGNATURE-----

--nextPart3160234.rlXZoVkKrB--
