From: "Shay Elkin" <shayel-NSemkxREmS1YZAO8hgG6+w@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Sun, 22 Sep 2002 05:06:02 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2002.09.22.02.05.58.440247@cs.huji.ac.il>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 18 Sep 2002 23:27:01 +0000, Grover, Andrew wrote:

IBM ThinkPad 1161-93G, with a modified DSDT.

> - DOES IT BOOT?

Yes. 

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Yes,  but I find the following messages in my dmesg (00:10.0 is IDE,
01:00.0 is VGA):

 pci_irq-0293 [04] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 15
 pci_irq-0293 [04] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:00.0
PCI: No IRQ known for interrupt pin A of device 01:00.0 - using IRQ 10
 pci_irq-0293 [03] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 15

On the bright side, the CPU doesn't to stuck in C mode it can't get out
of, and this is the first release to recieve button events. Guess it's
time I'll look into ospmd's code.

	Shay.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
