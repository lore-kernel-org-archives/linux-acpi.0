From: Patrick Dreker <patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] ACPI drop back to pic mode -- linux-2.6.0-test2-acpi-picmode.patch
Date: Thu, 31 Jul 2003 03:36:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307310336.07486.patrick@dreker.de>
References: <200307302100.01386.adq_dvb@lidskialf.net> <200307310228.35207.patrick@dreker.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307310228.35207.patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 31. Juli 2003 02:28 schrieb Patrick Dreker <patrick-G8S07CpUG8o@public.gmane.org=
e>=20
zum Thema Re: [ACPI] [PATCH] ACPI drop back to pic mode --=20
linux-2.6.0-test2-acpi-picmode.patch:

Replying to myself...
> Before patching the kernel with the picmode.patch booting with acpi=3Doff=
 was
> no problem (aside from some devices not getting an IRQ assigned). Whether=
 I
> enable or disable the APIC (at compile time, as well as with the "noapic"
> kernel option) does not matter. If ACPI is enabled all is fine. The APIC =
is
> enabled and all devices are assigned IRQs (which is not the case without
> ACPI).
Booting with ACPI enabled and "noapic" outputs a long flood of APIC errors =
on=20
boot. Did not test any further.

> with all interrupts disabled, and the watchdog does not kick in, Magic

> OK...). Any tipps, how I can find out where or when it locks up?
OK, the NMI watchdog was disabled in my config for some reason. I re-enable=
d=20
it, and I'll see what happens next...

=2D --=20
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
=46ingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KHKHcERm2vzC96cRAqnAAJ98Un2D+KG2ixyJ+/NXWZ6njZ4VQACbB26S
XLTbhNAzIMP3KL9bppzF+dQ=3D
=3DxiSM
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
