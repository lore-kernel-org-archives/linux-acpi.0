From: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Subject: acpi_pci_link_check's attempt to find the _best_ irq prevents system from using ACPI irq routing
Date: Mon, 21 Apr 2003 03:30:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304210330.03812.malte.d@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Hi everybody,

After my Thinkpad R31 didn't want to boot without pci=noacpi, I tried today to 
find out, what the reason for this is. With pci=acpi it booted right away 
till 

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 29)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15

then it stoped without any warning or failure message. I had no clue, why the 
kernel behaved like this. 

The 'show stopper' is one nifty loop in the drivers/acpi/pci_link.c:
Actually its the part which has this comment: "Pass #2: Enable boot-disabled 
Links at 'best' IRQ."

/* 
* Select the best IRQ.  This is done in reverse to promote 
* the use of IRQs 9, 10, 11, and >15.
*/
for (i=(link->irq.possible_count-1); i>0; i--) {
	if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
 		irq = link->irq.possible[i];
	}

After commenting out this loop, the 'boot-disabled Links' got both irq 3 
(which isn't the best, but seemingly quite okay.) And the system started as 
expected with 'pci=acpi'. *hooray* It seems quite stable, though only S1 is 
working properly. S3 has still problems at wake-up-stadium. 

Maybe some brighter soul can review this... ;-)

thanks for this great work

cheers Malte



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
