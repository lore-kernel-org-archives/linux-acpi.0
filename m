From: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Subject: Problems installing ACPI
Date: 20 Jan 2003 18:28:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043083690.1702.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm running RedHat 8.0 on my Compaq EVO N160 laptop.

To install ACPI i downloaded the linux-2.4.20 kernel from www.kernel.org
and patched it with acpi-20021212-2.4.20.diff.gz.

I had some promblems compilling the kernel but when I left out scsi
support the problem disappeard. However when I boot the new kernel it
hangs with this message:

ACPI: Interpreter enabled
ACPI: Using PIG for interrupt routine
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI root bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bug 00)
Tranparent bridge-Intelcorp. 82801BAM/CAM PCI bridge
ACPI: PCI interrupt link [LNKA] (IRQs 3 4 5 7 9 10 11 14 15) 
ACPI: PCI interrupt link [LNKB] (IRQs 3 4 *5 7 9 10 11 14 15) 
ACPI: PCI interrupt link [LNKC] (IRQs 3 4 5 7 9 10 11 14 15, disabled) 
ACPI: PCI interrupt link [LNKD] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI interrupt link [LNKE] (IRQs 3 4 5 7 *9 10 11 14 15)
ACPI: PCI interrupt link [LNKF] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: PCI interrupt link [LNKG] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: PCI interrupt link [LNKH] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: Embedded Controler [H8] (gpc2a)
Schedule_task(): keventd has not started
PCI: Probing PCI hardware
ACPI: PCI interrupt link [LNKC] enabled at IRQ11
ACPI: PCI interrupt link [LNKF] enabled at IRQ10

What might be the problem?






-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
