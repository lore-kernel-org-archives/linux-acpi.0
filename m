From: Leonardo Macchia <macchia-oqfuaKpTAUu4UacQti+wdA@public.gmane.org>
Subject: Error overriding DSDT table
Date: Thu, 12 Sep 2002 10:18:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020912081803.GA1785@leo.anemos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello.

I'm trying to patch the DSDT table in 2.4.19's ACPI but I get some
errors. I have a Compaq Evo N600c.

I applied acpi-20020821-2.4.19.diff patch (and if I stop here the kernel
works... but I can't see any battery nor fan resources) and
linux-2.4.18-acpi-20020709-dsdt.patch.
With acpidump I got the original DSDT table where I changed the wrong
entries

Name(_HID, "*PNP....")

into

Name(_HID, "PNP....")

so I used iasm to create the hex file from the patched table... I got
some errors ("Object does not exist" and similar) but I've heard to
ignore them... so I moved this hex file into
drivers/acpi/tables/acpi_dsdt.c and compiled the kernel.

After starting the kernel, ACPI results disabled (no /proc/acpi) and the
kernel - during boot - says:

[...]
ACPI: Subsystem revision 20020815
PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=4
PCI: Using configuration type 1 Sep 11 13:24:45 eniac kernel:   
    ACPI-0272: *** Info: Table [DSDT] replaced by host OS
    ACPI-0107: *** Error: Acpi_load_tables: Could not load namespace: AE_AML_BAD_NAME
    ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: AE_AML_BAD_NAME
ACPI: Unable to load the System Description Tables
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
[...]

Any suggestion? I think the trouble is dumping/compiling the DSDT
tables. :(

Thank you, Leonardo.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
