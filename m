From: Hrvoje Habjanic <hrvoje.habjanic-BSe0LARa/8o@public.gmane.org>
Subject: HP xw6000 problem - no solution/info yet?
Date: Mon, 23 Jun 2003 14:40:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306231440.13547.hrvoje.habjanic@hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org


OK, i would appreciate any kind of feedback or comment - is anybody reading/working on this?

In short - acpi-20030424 on 2.4.21 is working, but anything beyond that isn't.
The machine just stops - complaining about interrrupts:

PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................
Table [DSDT](id F012) - 122 Objects with 16 Devices 52 Methods 1 Regions
Parsing all Control Methods:..
Table [SSDT](id F010) - 2 Objects with 0 Devices 2 Methods 0 Regions
Parsing all Control Methods:...
Table [SSDT](id F00F) - 3 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id F00E) - 4 Objects with 0 Devices 0 Methods 0 Regions
 dswload-0183: *** Error: Looking up [\_SB_.PCI0.LPC_.FDC0] in namespace, AE_NOT_FOUND
 psparse-0589 [10] ps_parse_loop         : During name lookup/catalog, AE_NOT_FOUND
 psparse-1121: *** Error: , AE_NOT_FOUND
ACPI Namespace successfully loaded at root c03bdc7c

[snip]

PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
 pci_irq-0297 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 05:02.0
PCI: No IRQ known for interrupt pin A of device 05:02.0
 pci_irq-0297 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 05:0a.0
PCI: No IRQ known for interrupt pin A of device 05:0a.0
 pci_irq-0297 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 05:0b.0
PCI: No IRQ known for interrupt pin A of device 05:0b.0
 pci_irq-0297 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 05:0c.0
PCI: No IRQ known for interrupt pin A of device 05:0c.0
 pci_irq-0297 [19] acpi_pci_irq_derive   : Unable to derive IRQ for device 05:0c.1
PCI: No IRQ known for interrupt pin B of device 05:0c.1


Is normal that SSDT tables got loaded in revers order - is that also in acpi-20030424? 

I would like to help - but how? I know C programming language, and understand parts of
acpi driver - but anyting beyond that is wery confusing ... :-/

Again, on my web page can be seen additional info - and if anybody requires any additional
info about this problem - let me know.

I do not like to put presure on people or force them to do anything, but any progres info 
or "problem noted" or "working on issue" mail would be appreciated.

Hrvoje

p.s. http://free-zg.htnet.hr/HrvojeHabjanic/acpi and sorry for bad english



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
