From: Cyril Bitterich <Cyril.Bitterich-jNDFPZUTrfTbB13WlS47kxGsIjC5xiiLhC4ANOJQIlc@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 14:57:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919145745.246daed7.Cyril.Bitterich@informatik.uni-muenchen.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.TNJs+s7WJwlean"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=.TNJs+s7WJwlean
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Having a sony Vaio PCG-SRX41P i can say 

> - DOES IT BOOT?

It does.

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

It DOES

/proc# cat interrupts
           CPU0
  0:      51258          XT-PIC  timer
  1:        313          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:        448          XT-PIC  acpi, Ricoh Co Ltd RL5c475, Texas Instruments PCI1410 PC card Cardbus Controller, eth0, orinoco_cs
 11:         10          XT-PIC  sonypi
 12:         92          XT-PIC  PS/2 Mouse
 14:      44636          XT-PIC  ide0
NMI:          0
ERR:          0

For Identification:

ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65152
zone(0): 4096 pages.
zone(1): 61056 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 SONY                       ) @ 0x000f6c70
ACPI: RSDT (v001 SONY   U2       08193.04119) @ 0x0fcf7f4a
ACPI: FADT (v002   SONY       U2 08193.04119) @ 0x0fcfbf54
ACPI: BOOT (v001   SONY       U2 08193.04119) @ 0x0fcfbfd8
ACPI: DSDT (v001   SONY       U2 08193.04119) @ 0x00000000
ACPI: BIOS passes blacklist
Sony Vaio laptop detected.

> Issues like whether the battery reports stats properly are of secondary
> importance.

Battery/AC OK.
Power Lid works.
sonypi still works
S3 seems not to work, but not much testing yet.

Cyril

--=.TNJs+s7WJwlean
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9icnJuUAfsvG5tJsRAi/tAKDGvJzpVyAhWT4r66Gpz/rucz8dVwCfSqef
MawuOSp6ujFUXJutwlseCS0=
=HzRe
-----END PGP SIGNATURE-----

--=.TNJs+s7WJwlean--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
