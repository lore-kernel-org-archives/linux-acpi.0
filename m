From: Hanno Böck <hanno-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI source patches updated (20021101)
Date: Sun, 3 Nov 2002 11:10:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103111026.3d4fc731.hanno@gmx.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The Problem I reported in the mail below is still in the current version.
As I already said, it worked with previous versions. Can anyone have a look at it? How can I help you solve the problem.

cu,

Hanno

---------------------------

Begin forwarded message:

Date: Sun, 27 Oct 2002 10:15:23 +0100
From: Hanno Böck <hanno-Mmb7MZpHnFY@public.gmane.org>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [ACPI] Computer with SIS-Chipset doesn't work - worked before


I have a computer with a SIS-Chipset that worked with previous versions of the ACPI-Patch, but doesn't work with the latest one.
(It is the second system i found recently that doesn't work and worked with older versions).

dmesg and lspci output are at
www.int21.de/dmesg.txt
www.int21.de/lspci.txt

The important part is probably:
ACPI: Subsystem revision 20021022
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
tbxfroot-0305 [04] Acpi_find_root_pointer: RSDP structure not found
ACPI: System description tables not found
 tbxface-0066: *** Error: Acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
 tbxface-0116: *** Error: Acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router SIS [1039/0008] at 00:01.0


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
