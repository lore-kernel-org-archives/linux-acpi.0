From: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
Subject: Shuttle HOT-591P fails ACPI on 2.4.23
Date: Mon, 8 Dec 2003 06:24:24 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031208122424.GA18539@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

Shuttle HOT-591P with latest BIOS (591P025) and Cyrix CPU, kernel
2.4.23.  It is a Baby AT board with AT and ATX power.

Vendor: Award Software International, Inc.
Version: 4.51 PG
Release Date: 03/27/01

Manufacturer: Shuttle Inc.
Product Name: VIA APOLLO MVP3 (HOT-597)
Version: 2A5LEH2B
(It is actually a 591P, regardless of the DMI string)

It seems the ACPI tables are found, but the system does not properly
handle the SCI interrupt:

ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D3D1
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
=2E.......
Table [DSDT](id F004) - 227 Objects with 26 Devices 55 Methods 17 Regions
ACPI Namespace successfully loaded at root c02dba3c
ACPI: IRQ9 SCI: Level Trigger.  <---- PAUSES HERE
evxfevnt-0089: *** Error: Could not transition to ACPI mode.
 utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
ACPI: Unable to start the ACPI Interpreter
evxfevnt-0127 [06] acpi_disable          : System is already in legacy (non=
-ACPI) mode
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
=2E..

At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before
continuing.

A similar system with a Tyan ATX board and K6/III 400 works great.

any ideas?

--=20
Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1G14IonHnh+67jkRAn5QAKCtghpZgzbPiwzbLPtCXXREpKbyDACfU3vr
moA5qjwdPVSiYN/ME3LzZwc=
=0Y0G
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
