From: Pere =?ISO-8859-15?Q?Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: Acpi irq handler doesn't detect ICH4 sound device with ALSA. Is a
 known bug?
Date: Fri, 13 Aug 2004 21:16:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040813211607.0e8bce72@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__13_Aug_2004_21_16_07_+0200_pFC_YMv6Nlx16d+4"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Signature=_Fri__13_Aug_2004_21_16_07_+0200_pFC_YMv6Nlx16d+4
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I upgraded my kernel from 2.6.5 to 2.6.7  and then with 2.6.8rc3 with acpi =
patch from 15th of July. With all these kernels the latest acpi code has pr=
oblems to detect my onboard pci soundcard which uses snd-intel8x0m module (=
ICH4).
When I try to load it manually I receive this message:

-----------------------------------------------------------------
ACPI: PCI interrupt 0000:00.1f.5[B] GSI 7 (level,low)----> IRQ7
Intel ICH probe of 0000:00:1f.5 failed with error -16
unable to grab IRQ7
----------------------------------------------------------------

I suspect that ACPI has problems to handle the IRQ's at boot time. When I a=
ppend to boot loader the string pci=3Dnoacpi the pci IRQ handler detects my=
 soundcard nicely.

PS:Is a Dell Inspiron 8500.

PSS:Tested with kernel 2.6.8rc3 patched with acpi20040715-2.6.8rc2 patch.

--=20
"Master Rahl guide us. Master Rahl teach us. Master Rahl protect us.=20
In your light we thrive. In your mercy we are sheltered. In your wisdom
we are humbled. We live only to serve. Our lives are yours"
                                                Sword of the Truth Series,=
=20
                                                         by Terry Goodkind
------
Pere Casta=F1er Sard=E0=A0 - http://xarz.homelinux.net
GnuPG Public key available - http://xarz.homelinux.net/Public_key_block.asc
Computer Science Student on UOC - http://www.uoc.edu
Linux Registered User #232073=20
Debian/GNU User - http://www.debian.org
---------------------






--=20
"..la vida es una tormenta, joven amigo. Est=E1s bajo el sol tranquilamente=
 y
de pronto te lanza a las rocas. Lo que te convierte en hombre es tu conducta
cuando llega la tormenta, tienes que mirar a esa tormenta, y gritar: haced
lo que sea, que yo har=E9 lo mio."
------
Pere Casta=F1er Sard=E0 - http://xarz.no-ip.org
GnuPG Public key available - http://xarz.no-ip.org/keys.html
Computer Science Student on UOC - http://www.uoc.edu
Linux Registered User #232073=20
Debian/GNU User - http://www.debian.org
---------------------

--Signature=_Fri__13_Aug_2004_21_16_07_+0200_pFC_YMv6Nlx16d+4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHRN9z9pL9wbHcwIRAndwAKCVW/LIGCACm7XCKH5OGNmrOpNK3gCdHhxv
S2tg3iv5AUx4G4LCX1/g+Jw=
=19E/
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Aug_2004_21_16_07_+0200_pFC_YMv6Nlx16d+4--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
