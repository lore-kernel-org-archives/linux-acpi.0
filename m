From: Simon Derr <simon.derr-6ktuUTfB/bM@public.gmane.org>
Subject: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Wed, 28 Apr 2004 16:18:46 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi,

On our 4-way and 2-way IA-64 systems, the PCI bus with id 0xff does not
appear anymore on recent Linux 2.6 kernels. This is a problem because we
use it to find out the revision of the chipset of the system.

It used to work fine "before", i.e. running lspci showed the 0xff bus.

It hunted this change and found the culprit to be this patch (that was
introduced between 2.6.1 and 2.6.2):

https://sourceforge.net/mailarchive/message.php?msg_id=6923348

This patch seems to have received no feedback at all, and is a source of
trouble for us.

I propose a patch that reverts to the 2.6.1 situation, with a somewhat
more good-looking code.

	Simon.

--- linux-2.6.5-vanilla/drivers/acpi/scan.c	Sun Apr  4 05:36:57 2004
+++ linux-2.6.5/drivers/acpi/scan.c	Wed Apr 28 15:17:57 2004
@@ -706,7 +706,7 @@
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		result = acpi_bus_get_status(device);
-		if (ACPI_FAILURE(result) || !device->status.present) {
+		if (ACPI_FAILURE(result)) {
 			result = -ENOENT;
 			goto end;
 		}


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
