From: Borislav Petkov <petkov@math.uni-muenster.de>
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
Date: Mon, 23 Oct 2006 19:08:58 +0200
Message-ID: <20061023170858.GA21995@gollum.tnic>
References: <20061022063924.GA7177@gollum.tnic> <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr> <20061022091054.3fc8596b.rdunlap@xenotime.net>
Reply-To: petkov@math.uni-muenster.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DENETHOR.UNI-MUENSTER.DE ([128.176.180.180]:4832 "EHLO
	denethor.uni-muenster.de") by vger.kernel.org with ESMTP
	id S964966AbWJWRJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Oct 2006 13:09:52 -0400
Content-Disposition: inline
In-Reply-To: <20061022091054.3fc8596b.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, Oct 22, 2006 at 09:10:54AM -0700, Randy Dunlap wrote:
> On Sun, 22 Oct 2006 12:54:30 +0200 (MEST) Jan Engelhardt wrote:
>=20
> >=20
> > >--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.00000000=
0 +0200
> > >+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +02=
00
> > >@@ -262,7 +262,6 @@ config ACPI_SONY
> > > 	tristate "Sony Laptop Extras"
> > > 	depends on X86 && ACPI
> > > 	select BACKLIGHT_CLASS_DEVICE
> > >-	default m
> > > 	  ---help---
> > > 	  This mini-driver drives the ACPI SNC device present in the
> > > 	  ACPI BIOS of the Sony Vaio laptops.
> >=20
> > Reason?
>=20
> This is the third such patch/request that I recall for this
> one.  It's =3Dm for Andrew (one of his machines).
> Otherwise the patch makes sense and should be merged...
>=20
> ---
> ~Randy

(sorry for the duplicate send but the yahoo mailserver is having proble=
ms. :()

We already turned off the Toshiba extras module some time ago since the=
 majority
of us don't necessarily have the aforementioned machine (see commit
f9a204e1de73a7007de66fb289e1d64a7665c9b4 in Linus' tree) but if this on=
e is
different, then so be it. I still think, though, that it makes more sen=
se to
leave stuff turned on in case it is needed in the most profiles of kern=
el usage
and leave not so common features off and let people turn them on only f=
or their
special case.

--=20
Regards/Gru=DF,
    Boris.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
