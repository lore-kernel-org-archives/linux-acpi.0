From: =?utf-8?q?Pawe=C5=82=20Szlubecki?= <szlube-FWhLrETftxM@public.gmane.org>
Subject: problem wirh PCI Interrupt Link
Date: Sat, 14 Jun 2003 22:37:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306142237.43985.szlube@op.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
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

I have ISA sound card, which have been working on irq 5. Kernel ACPI unexpectedly allocated irq 5 for unused and disabled PCI interput link [LINKC]. 
It couse a lot of problems with stability of my linux box, befor I dicovered what was happend.
In /proc/interputs wasn't information about it.
I thing, It is good idea to turned it off (auto allocating irq for disabled and unused PCI interput link [LINK?] ) optionally via kernel command line.


syslog:
      Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
      Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
      Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
      Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
      Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
      Jun 14 19:52:17 zx kernel: PCI: Probing PCI hardware
!!!!!  Jun 14 19:52:17 zx kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
