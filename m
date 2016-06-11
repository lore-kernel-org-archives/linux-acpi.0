From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Sat, 11 Jun 2016 13:49:22 +0300
Message-ID: <20160611104922.GA2368@nest>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36624 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcFKKt0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Jun 2016 06:49:26 -0400
Content-Disposition: inline
In-Reply-To: <3027571.8eTQaleASL@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Jun, Rafael J. Wysocki wrote:
> On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > Hi,
> >=20
> > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to RAM.
> > Laptop doesn't finish suspend to RAM process (disks are off, but WiFi
> > and Power LEDs are still on). The only way to get it out of this
> > state, is to turn the power off.
> >=20
> > I've bisected the issue to commit 66b1ed5aa8dd25
> > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for ac=
pi_h=3D
> > w_write()].
> >=20
> > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM is
> > working again.
> >=20
> > The cause of this problem is that after this commit write to PM1A Contr=
ol B=3D
> > lock
> > (16-bit register) is done using two 8-bit writes. If I force this write
> > to be 16-bit, then all is working as before.
> >=20
> > To get it working 'access_width' for PM1A Control Block needs to be 2 (=
16-b=3D
> > it), but it's=3D20
> > 1 (8-bit).
> >=20
> > The root of the problem seems to be not the commit 66b1ed5aa8dd25 itsel=
f, b=3D
> > ut the ACPI
> > tables in BIOS where wrong access_width comes from. I fixed problem in =
FACP=3D
> >  table,
> > put it in initrd to override FACP table from BIOS. This fixed the issue,
> > suspend to RAM is working now again.
> >=20
> > But I'm not sure whether is this proper fix for this problem.
> > Is there any place in the kernel, where such ACPI quirks are placed?
>=20
> Well, if the commit in question caused a problem to happen for you, it al=
so
> might cause similar problems to happen elsewhere.
>=20
> It looks like we'll need to revert that commit.
Hi,

or maybe to reset access_width AnyAcc from FACP table only for PM1A control
register or even for all registers? This will fix the issue too.

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 6208069..a476e94 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -714,7 +714,14 @@ static void acpi_tb_setup_fadt_registers(void)
                        }
                }
        }

+       /*
+        * Reset access_width in the GAS for PM1A control register to
+        * undefined value. Because in some cases this field contains
+        * wrong value.
+        */
+       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;


--=20
Best regards,
Andrey Skvortsov



--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXW+yyAAoJEAF8y6L1SLCtv+IP/RKUvQpQhud/TMflPfc4hhsI
XK3iqgV/3ee+B6NSG9EITY6nqDwyB36QibO4XT4IMIUqYyH7eCNMJE60+3adNTYX
IDM/DhkYG0F7KIrJ1G/AqAHVy9f2wEPyK2rljh9sgxTyvLhUCy3Hd+mUj/6vcI9V
ltW3kL0l+GBDACuvZ5JSFDKxeNe7SgxLfYD+zr6B+jOzyJCQT6QWKJYba5hLtYBE
/auw+bJaS4H1rOVw8KUIlPnOrEY9+12Zb4S8pqPtAHI82qKbc9Lvnbjo5w8mqg6o
2vNzrfDaBlLf+tHfL5Avgm7uJW/vVc6GlVQAkNUpJFF9pIkqtSyQbXcc3ewzBJOK
Z6XFacXNIrbFwC7ytgBE8GrFH0irM/UQXd+pwbouhJKH9wNCdRwyxPRF7bIbOnbu
BWAyitWNqetz2e9gBxoJAGc8qDf1EA1u2EDM5jNWiWBWceow/hoCzOVK2ZsmME7c
a/Q4rZd88QZ6orkzFZyC77IDukuSmbt8jB8Sh1Xd7VuH3rAG6M/8D/ZcdMdiB9pS
o83VmHZ9V9FAv4xB742LlPUDIfwrDrKUTZiMRLUqYTEy9+g0LNlLNEYVVzejYT4O
qYWM6QK0X/sVt12NARd1mSXYLP/KyOurrK+KJEDeQ2PvJRw5NaBJW7iISo8SZd/2
1txi9Iq+9gUFzKwEgDac
=W5Mh
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
