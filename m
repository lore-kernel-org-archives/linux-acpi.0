From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Shuttle HOT-591P fails ACPI on 2.4.23
Date: Wed, 10 Dec 2003 11:26:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC88DE@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ryan Underwood <nemesis-lists-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> evxfevnt-0089: *** Error: Could not transition to ACPI mode.
> utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
> ACPI: Unable to start the ACPI Interpreter

The pause must be the 3000 retries in acpi_hw_set_mode().

Please file a bug with acpidmp output attached.
We'll need to take a look at the FADT and probably instrument
your kernel to figure out why it isn't working.
(I assume that Win 2k or Win XP is able to run in ACPI mode on this
box?)

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/ Category: Power Management, Component: ACPI

Please attach dmesg -s40000 output (or serial console log if dmesg
unavailable)
Please attach copy of /proc/interrupts if possible

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Please attach the output from dmidecode, available in /usr/sbin/, or
here:=20
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Please file a bug and include the putput
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Ryan Underwood
> Sent: Monday, December 08, 2003 11:51 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Shuttle HOT-591P fails ACPI on 2.4.23
>=20
>=20
>=20
> Hi,
>=20
> This is the first time I have booted an ACPI-enabled kernel on this
> machine.  So I wasn't expecting too much. ;)
>=20
> Shuttle's spec page for the board: http://de.shuttle.com/591p.htm
> does claim to support ACPI.
>=20
> I attached the files you asked for.  acpi_pic_sci=3Dedge didn't seem =
to
> make a difference (paused in same place, and same error)
>=20
>=20
> On Mon, Dec 08, 2003 at 10:14:20AM -0500, Len Brown wrote:
> > Has ACPI worked better on this box using any other releases?
> >=20
> > Does it work any better if you boot with "acpi_pic_sci=3Dedge"?
> >=20
> > I'd be interested in seing the complete dmesg -s40000 output
> > and the resulting /proc/interrupts.
> >=20
> > thanks,
> > -Len
> >=20
> > On Mon, 2003-12-08 at 07:24, Ryan Underwood wrote:
> > > Hello,
> > >=20
> > > Shuttle HOT-591P with latest BIOS (591P025) and Cyrix CPU, kernel
> > > 2.4.23.  It is a Baby AT board with AT and ATX power.
> > >=20
> > > Vendor: Award Software International, Inc.
> > > Version: 4.51 PG
> > > Release Date: 03/27/01
> > >=20
> > > Manufacturer: Shuttle Inc.
> > > Product Name: VIA APOLLO MVP3 (HOT-597)
> > > Version: 2A5LEH2B
> > > (It is actually a 591P, regardless of the DMI string)
> > >=20
> > > It seems the ACPI tables are found, but the system does=20
> not properly
> > > handle the SCI interrupt:
> > >=20
> > > ACPI: Subsystem revision 20031002
> > > PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3D3D1
> > > PCI: Using configuration type 1
> > >  tbxface-0117 [03] acpi_load_tables      : ACPI Tables=20
> successfully acquired
> > > Parsing all Control=20
> Methods:.......................................................
> > > Table [DSDT](id F004) - 227 Objects with 26 Devices 55=20
> Methods 17 Regions
> > > ACPI Namespace successfully loaded at root c02dba3c
> > > ACPI: IRQ9 SCI: Level Trigger.  <---- PAUSES HERE
> > > evxfevnt-0089: *** Error: Could not transition to ACPI mode.
> > >  utxface-0170 [03] acpi_enable_subsystem : acpi_enable failed.
> > > ACPI: Unable to start the ACPI Interpreter
> > > evxfevnt-0127 [06] acpi_disable          : System is=20
> already in legacy (non-ACPI) mode
> > >  utalloc-0986 [05] ut_dump_allocations   : No outstanding=20
> allocations.
> > > PCI: Probing PCI hardware
> > > PCI: ACPI tables contain no PCI IRQ routing entries
> > > ...
> > >=20
> > > At the "ACPI: IRQ9 SCI:" part, it pauses for a few seconds before
> > > continuing.
> > >=20
> > > A similar system with a Tyan ATX board and K6/III 400 works great.
> > >=20
> > > any ideas?
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?  SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
>=20
> --=20
> Ryan Underwood, <nemesis-RBwgCYbvQ+vk1uMJSBkQmQ@public.gmane.org>
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
