From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI source patches updated (20021101)
Date: Mon, 4 Nov 2002 16:08:11 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4AC@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=27Hanno_B=F6ck=27?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Hanno B=F6ck [mailto:hanno-Mmb7MZpHnFY@public.gmane.org]=20
> The Problem I reported in the mail below is still in the=20
> current version.
> As I already said, it worked with previous versions. Can=20
> anyone have a look at it? How can I help you solve the problem.

Wait, it worked in *which* previous version, exactly? This is a pretty
serious error, and I don't think we changed anything relating to =
finding the
RSDP lately...

Could you have disabled ACPI in the BIOS?

Regards -- Andy

> ---------------------------
>=20
> Begin forwarded message:
>=20
> Date: Sun, 27 Oct 2002 10:15:23 +0100
> From: Hanno B=F6ck <hanno-Mmb7MZpHnFY@public.gmane.org>
> To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Subject: [ACPI] Computer with SIS-Chipset doesn't work - worked =
before
>=20
>=20
> I have a computer with a SIS-Chipset that worked with=20
> previous versions of the ACPI-Patch, but doesn't work with=20
> the latest one.
> (It is the second system i found recently that doesn't work=20
> and worked with older versions).
>=20
> dmesg and lspci output are at
> www.int21.de/dmesg.txt
> www.int21.de/lspci.txt
>=20
> The important part is probably:
> ACPI: Subsystem revision 20021022
> PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=3D1
> PCI: Using configuration type 1
> tbxfroot-0305 [04] Acpi_find_root_pointer: RSDP structure not found
> ACPI: System description tables not found
>  tbxface-0066: *** Error: Acpi_load_tables: Could not get=20
> RSDP, AE_NOT_FOUND
>  tbxface-0116: *** Error: Acpi_load_tables: Could not load=20
> tables: AE_NOT_FOUND
> ACPI: Unable to load the System Description Tables
> PCI: Probing PCI hardware
> PCI: ACPI tables contain no PCI IRQ routing entries
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router SIS [1039/0008] at 00:01.0
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: ApacheCon, November 18-21 in
> Las Vegas (supported by COMDEX), the only Apache event to be
> fully supported by the ASF. http://www.apachecon.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
