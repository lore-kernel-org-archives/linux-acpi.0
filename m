From: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Subject: Presario 2701US and Battery info
Date: Wed, 7 Aug 2002 11:34:16 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D8C1802AADD0D346BE5C0A1D117075CC02C1C9F0@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

No battery info (battery not present) on Presario 2701US

Also getting the repeating message (which fills dmesg):

VFS: Disk change detected on device sr(11,1)

Details:

dmesg and dsdt.asl posted here
http://www.cpqlinux.com/dmesg.txt
http://www.cpqlinux.com/dsdt_asl.txt
and compressed here
http://www.cpqlinux.com/dmesg.txt.tgz
http://www.cpqlinux.com/dsdt_asl.txt.tgz

Presario 2701US=20
Red Hat 7.2
Fresh 2.4.18 + acpi-20020726-2.4.18.diff
On this I have not modified my DSDT table.

For kernel configuration I did exactly the following:
cd /usr/src/linux-2.4.18-acpi
cp ../linux-2.4.7-10/configs/kernel-2.4.7-i686.config =
arch/i386/defconfig
make mrproper
yes "" | oldconfig
Then in xconfig I did:
1) change to PIII,=20
2) turn off Compaq PCI Hotplug driver (doesn't compile),=20
3) turn on ACPI support,=20
4) make everything in ACPI as "y" not "m" (will do modules=20
later once I get this working) - also turned on thermal zone=20
and debug statements.

I see battery entries in=20
cd /proc/acpi/battery/
find . -type f
./BAT2/alarm
./BAT2/state
./BAT2/info
./BAT1/alarm
./BAT1/state
./BAT1/info

cat BAT1/* BAT2/*
present:		no
present:		no
present:		no
present:		no
present:		no
present:		no

What works:
Lid button
fully powers off on shutdown


Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.geocities.com/rlcomp_1999
http://www.compaq.com/linux

P.S. Some (not all) bad messages from dmesg (see web page for full =
details):
http://www.cpqlinux.com/dmesg.txt
http://www.cpqlinux.com/dsdt_asl.txt


grep dsutils
 dsutils-0391 [23] Ds_create_operand     : Object name [\_SB_.OKEC] was =
not found in namespace
 dsutils-0554 [22] Ds_create_operands    : While creating Arg 2 - =
AE_AML_NAME_NOT_FOUND
 dsutils-0391 [27] Ds_create_operand     : Object name [\_SB_.ACOK] was =
not found in namespace
 dsutils-0554 [26] Ds_create_operands    : While creating Arg 1 - =
AE_AML_NAME_NOT_FOUND
 dsutils-0391 [28] Ds_create_operand     : Object name [\_SB_.OKEC] was =
not found in namespace
 dsutils-0391 [24] Ds_create_operand     : Object name [\_SB_.ACOK] was =
not found in namespace
 dsutils-0554 [23] Ds_create_operands    : While creating Arg 2 - =
AE_AML_NAME_NOT_FOUND


grep acpi
 pci_irq-0293 [13] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:04.0
 pci_irq-0293 [13] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:05.0
 pci_irq-0293 [13] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:06.0
 pci_irq-0293 [13] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:08.0
 acpi_ac-0082 [16] acpi_ac_get_state     : Error reading AC Adapter =
state
 pci_irq-0293 [14] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:08.0
 pci_irq-0293 [14] acpi_pci_irq_derive   : Unable to derive IRQ for =
device 02:06.0

grep -i bat
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
