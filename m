From: Hanno Böck <hanno-Mmb7MZpHnFY@public.gmane.org>
Subject: Still error Messages with newest Patch
Date: Sat, 24 Aug 2002 10:46:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824104620.168dfdde.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have just installed the newest acpi-patch on kernel-2.4.20-pre4 and still get some strange messages at boot.
I have a Sony Vaio PCG-GR114MK (which is very similar to all GR214,314,...-Notebooks).

----

Executing all Device _STA and_INI methods:................evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
.evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
..........................evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
.....evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
....evrgnini-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS

----

pci_bind-0194 [05] acpi_pci_bind         : Device 00:00:02.00 not present in PCI namespace

----

pci_link-0219 [17] acpi_pci_link_get_curr: Blank IRQ resource

----

 pci_irq-0293 [12] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:1f.1
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

----

If you need my full dmesg-output, i have uploaded it to:
http://www.int21.de/dmesg.txt
If you need any more information, contact me.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
