From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: "irq 11: nobody cared" after S3
Date: Mon, 02 Aug 2004 10:17:41 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410E4D05.3020304@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F0376876A@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000106020009090603060802"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F0376876A-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106020009090603060802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Li, Shaohua wrote:
> I guess the bug is: ACPI sets LNKE's IRQ from 10 to 11 in boot time.
> LNKE's register is at LPC bridge offset 0x68, but current PCI config
> space save/restore code only handles first 0x40 bytes. After resume,
> LNKE's register doesn't recover. So LNKE will actually route to 10, but
> ACPI still thinks it routes to 11. Then you will get such error. I guess
> such error is unavoidable unless LPC bridge driver exists (it can
> save/restore all affected config space instead of first 0x40 bytes). 

Hi,

I agree with you, but I suspect a better fix is something like the 
attached diff, from my local tree. (My machine has similar problems, but 
this is not tested yet. Will test tonight and then send a patch to Len 
if it works out.)

--------------000106020009090603060802
Content-Type: text/plain;
 name="acpi-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-fixes.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/02 10:11:58-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   drivers/acpi/pci_link.c: remove setonboot from struct
#   acpi_pci_link_irq. Make acpi_pci_link_allocate() call the BIOS to
#   program the IRQ router every time it is called instead of only after
#   boot. This should hopefully fix problems with IRQ routing after
#   resume from S3 suspend. We can't rely on the bridge state being
#   saved/restored, because we don't have proper drivers for every
#   chipset, so instead we rely on the BIOS. Even pci_save_state only
#   saves the first 0x40 bytes of PCI config space; this is not enough
#   for PIIX.
# 
# drivers/acpi/pci_link.c
#   2004/08/02 10:11:50-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +0 -6
#   remove setonboot from struct
#   acpi_pci_link_irq. Make acpi_pci_link_allocate() call the BIOS to
#   program the IRQ router every time it is called instead of only after
#   boot. This should hopefully fix problems with IRQ routing after
#   resume from S3 suspend. We can't rely on the bridge state being
#   saved/restored, because we don't have proper drivers for every
#   chipset, so instead we rely on the BIOS. Even pci_save_state only
#   saves the first 0x40 bytes of PCI config space; this is not enough
#   for PIIX.
# 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-08-02 10:14:23 -04:00
+++ b/drivers/acpi/pci_link.c	2004-08-02 10:14:23 -04:00
@@ -71,7 +71,6 @@
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
 	u8			active_high_low;	/* All IRQs */
-	u8			setonboot;
 	u8			resource_type;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
@@ -517,9 +516,6 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
-	if (link->irq.setonboot)
-		return_VALUE(0);
-
 	/*
 	 * search for active IRQ in list of possible IRQs.
 	 */
@@ -570,8 +566,6 @@
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
-
-	link->irq.setonboot = 1;
 
 	return_VALUE(0);
 }

--------------000106020009090603060802--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
