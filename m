From: Martijn Pieters <mj-a5Jd59zECFiB+jHODAdFcQ@public.gmane.org>
Subject: Re: ASL fixing questions
Date: Thu, 12 Feb 2004 16:34:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402BF14A.8040406@zopatista.com>
References: <402AF9FF.3020706@zopatista.com> <20040212093732.GP13262@poupinou.org> <402B7917.2090505@zopatista.com> <20040212211615.GV13262@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20A5822944445763D9FA8ECC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040212211615.GV13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20A5822944445763D9FA8ECC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bruno Ducrot wrote:
> The 3 first errors are due to this:
> 
>                 OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
>                 Field (CCRD, DWordAcc, Lock, Preserve)
>                 {
>                     Offset (0x04),
>                     TI04,   8,
>                     Offset (0x44),
>                     TI44,   16,
>                     Offset (0x80),
>                     PMEE,   1,
>                     Offset (0x81),
>                     Offset (0xA4),
>                     PWST,   2,
>                     Offset (0xA5),
>                     PMEN,   1,
>                         ,   6,
>                     PMST,   1
>                 }
> 
> You have the option to change the length for the OR (that is,
> replace the 0xA7 with 0xA8 (that will give you in fact the same
> behaviour if you enable the ACPI_RELAX compile kernel option), or
> you can change the DWordAcc by WordAcc in the Field.
> 
> Unfortunately, that is hard to know what is correct though,
> other than to bug the OEM, or to look if those fields can be accessed
> as double word in this PCI config space by looking the data book for
> this pci device.  It's the only (stable) solution unfortunately, even
> though there are some ACPI_PEDANTIC that need to be defined those days
> ;(

OEM is Arima (it's an eMachines W6805, motherbord is a W720-K8). The PCI 
Bridge is an onboard VIA chipset:

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188 (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00002000-00002fff
         Memory behind bridge: d0100000-d01fffff
         Prefetchable memory behind bridge: d8000000-dfffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

The 'unknown' b188 in there is said to be the VIA K8HTB chipset.

Should I just experiment and hope it doesn't blow up?

> The second is:
>                 Field (ERAM, AnyAcc, NoLock, Preserve)
>                 {
>                     Offset (0x80),
>                     NMSG,   8,
>                     SLED,   4,
>                     ...
>                     ...
> 
>                 }
> but since ERAM is an EC OR, it need byte access by ACPI specs.
> So replace the offending line with:
> 
>                 Field (ERAM, ByteAcc, NoLock, Preserve)
> 
> 
> I don't see where is the trouble doing so, btw.

Thanks about that. I'll change that to ByteAcc and cross my fingers. :)

Martijn

--------------enig20A5822944445763D9FA8ECC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK/FK3xaj2GOvgP0RAnQjAKClmcRtvCGvSZnWyAINz5ECtAhmUgCffGWS
dk1H41wMnhKWueD9R/hsLP4=
=mhgC
-----END PGP SIGNATURE-----

--------------enig20A5822944445763D9FA8ECC--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
