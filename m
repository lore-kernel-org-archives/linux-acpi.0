From: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: Never in C3
Date: Wed, 16 Jun 2004 13:36:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406161336.05667.fm3@os.inf.tu-dresden.de>
References: <16589.41686.480893.225338@aber.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_lCD0Apo5f1Bkwjf";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16589.41686.480893.225338-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_lCD0Apo5f1Bkwjf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Monday 14 June 2004 15:06, Fred Labrosse wrote:
> The following seems to suggest that my processor is never in C3 state:

BTW: It seems that my processor does not use the C1 state!

$ cat /proc/acpi/processor/CPU/power:
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:      promotion[C2] demotion[--] latency[000] usage[00000010]
                                                           ^^^^^^^^
   *C2:      promotion[C3] demotion[C1] latency[001] usage[04683642]
    C3:      promotion[--] demotion[C2] latency[085] usage[00004033]

Hardware: T40p with Pentium-M 1.6 GHz.
Everything seems to work perfectly well.

$ cat /proc/acpi/processor/CPU/performance:
state count:             6
active state:            P0
states:
   *P0:                  1600 MHz, 24500 mW, 500 uS
    P1:                  1400 MHz, 21000 mW, 500 uS
    P2:                  1200 MHz, 17000 mW, 500 uS
    P3:                  1000 MHz, 13500 mW, 500 uS
    P4:                  800 MHz, 9500 mW, 500 uS
    P5:                  600 MHz, 6000 mW, 500 uS

=46rank
=2D-=20
## Dept. of Computer Science, Dresden University of Technology, Germany ##
## http://os.inf.tu-dresden.de/~fm3                                     ##

--Boundary-02=_lCD0Apo5f1Bkwjf
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0DCl6z8pigLf3EcRAn92AJ4sgW5WAmmwAStv38hLU7z8M8baSQCeIhtc
eW6cwjI9dxJfiSBSMNAH/Aw=
=aGve
-----END PGP SIGNATURE-----

--Boundary-02=_lCD0Apo5f1Bkwjf--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
