From: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>
Subject: [patch] 2.6.1-mm3 acpi frees free irq0
Date: Thu, 15 Jan 2004 09:56:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16390.43574.867869.286685@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
find the interrupt source for the ACPI System Control Interrupt Handler,
it end up trying to free irq 0.

Included patch fixes the problem.

Cheers,
Jes

--- linux-2.6.1-mm3/drivers/acpi/osl.c~	Wed Jan 14 05:00:25 2004
+++ linux-2.6.1-mm3/drivers/acpi/osl.c	Thu Jan 15 06:43:28 2004
@@ -257,13 +257,13 @@
 		return AE_OK;
 	}
 #endif
-	acpi_irq_irq = irq;
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_irq_irq = irq;
 
 	return AE_OK;
 }
@@ -271,12 +271,13 @@
 acpi_status
 acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
 {
-	if (acpi_irq_handler) {
+	if (irq) {
 #if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
 		irq = acpi_irq_to_vector(irq);
 #endif
 		free_irq(irq, acpi_irq);
 		acpi_irq_handler = NULL;
+		acpi_irq_irq = 0;
 	}
 
 	return AE_OK;


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
