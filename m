From: Nico Schottelius <nico-linux-acpi-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: [BUG] pdc202xx_new and ACPI fails
Date: Wed, 15 Dec 2004 09:27:32 +0100
Message-ID: <20041215082732.GA2273@schottelius.org>
References: <20041205211754.GB7695@schottelius.org> <1102286168.2308.13.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1102286168.2308.13.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning people!

First of all, I am sorry: The problem did not disappear 100%:

If I connect devices to channel 3 and 4, the same error=20
occurs again. If I only connect devices to the 1. and 2. channel,
it works.

What is the "IDE Busmaster setting" in the BIOS and should I enable it?

Should I change irq and mem i/o settings in the promise controller
menu? I can adjust irq and i/o base for every ide channel.

Nico

P.S.: I am now subscribed with this adress, please do not reply to
      nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org anymore.

P.P.S.: I'll delay the describtion of the other problems with the Transmeta=
 machine
        so I can concentrate on the K7VM2 and Promise controller problem.

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQb/1crOTBMvCUbrlAQISiQ//Y8zklnv54FzBz5HDIIwGqksZulDdwq05
NvDmTDTWKiGak0UAAJXo78zrQAxn8LR5NPR/GFJJbpVKoALCk9bR5+BjY244nFcK
wii5lZIA7uroxrW8CNo9nzP2fh7AYcOob1wSAR21XFM9Q0XbDSm2/NqmTbK1pJcl
vBFufR12AyuTCjFT6cfMg1iLpoOWnprMeIKBKC+SXT1M0W8Q4ZN1N4e+72j5SHdM
CJln2vyuuig9pbNMgaeP3GXKBukalR3C8oHHhde/u9VrptNpFNSAjXUOlukNHS1X
iAn/Ru4d9ji/S9xAeU1I/p2gu6LbKuc6CHqiJveePPSBb2UJA7qATbvDJI4ufyfa
gKBcuS1cnaSoDo4ZQK4dQiWXiQhIJOF9XG8J2t7mVRxP3ijmA/8SSG3Y4j2LjKT6
C6uJGh+4lZtTT6sgCa0Vm8u4ujBBDCZz5acJTbRdhdlqqTThgRupSA0DifaY/kIr
I3sfr30h9c4vEmPpk/LilI04pT4FHeNfwu0mtpbd2HlPaLnfpmAGAnecfD3UmJpp
XKyjN98mnRZkUh/Hof5oiXGNma7ABlE3UyZ976qErvSAGbeDY3dLZ/x5wVMwQ2j/
XCKO18D1WQ/VRJKHlvIqctTmihBrhaY/zjuMOk+rB1LwXQQJa0ab0ELGeGDJ2EVO
8IOMqAJLeNY=
=pTWD
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
