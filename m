From: akpm-3NddpPZAyC0@public.gmane.org
Subject: acpi_register_gsi-change-ia64-iosapic-code.patch added to -mm tree
Date: Thu, 28 Jul 2005 11:42:20 -0700
Message-ID: <200507281843.j6SIhHc7012118@shell0.pdx.osdl.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     acpi_register_gsi(): change ia64 iosapic code

has been added to the -mm tree.  Its filename is

     acpi_register_gsi-change-ia64-iosapic-code.patch

Patches currently in -mm which might be from kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

acpi_register_gsi-change-acpi_register_gsi-interface.patch
acpi_register_gsi-change-acpi-pci-code.patch
acpi_register_gsi-change-hpet-driver.patch
acpi_register_gsi-change-phpacpi-driver.patch
acpi_register_gsi-change-acpi-based-8250-driver.patch
acpi_register_gsi-change-ia64-iosapic-code.patch



From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

Change iosapic_register_intr(), which called by acpi_register_gsi(), to return
negative value on error instead of panic.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/ia64/kernel/iosapic.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff -puN arch/ia64/kernel/iosapic.c~acpi_register_gsi-change-ia64-iosapic-code arch/ia64/kernel/iosapic.c
--- devel/arch/ia64/kernel/iosapic.c~acpi_register_gsi-change-ia64-iosapic-code	2005-07-28 11:42:19.000000000 -0700
+++ devel-akpm/arch/ia64/kernel/iosapic.c	2005-07-28 11:42:19.000000000 -0700
@@ -561,7 +561,7 @@ static inline int vector_is_shared (int 
 	return (iosapic_intr_info[vector].count > 1);
 }
 
-static void
+static int
 register_intr (unsigned int gsi, int vector, unsigned char delivery,
 	       unsigned long polarity, unsigned long trigger)
 {
@@ -576,7 +576,7 @@ register_intr (unsigned int gsi, int vec
 	index = find_iosapic(gsi);
 	if (index < 0) {
 		printk(KERN_WARNING "%s: No IOSAPIC for GSI %u\n", __FUNCTION__, gsi);
-		return;
+		return -ENODEV;
 	}
 
 	iosapic_address = iosapic_lists[index].addr;
@@ -587,7 +587,7 @@ register_intr (unsigned int gsi, int vec
 		rte = iosapic_alloc_rte();
 		if (!rte) {
 			printk(KERN_WARNING "%s: cannot allocate memory\n", __FUNCTION__);
-			return;
+			return -ENOMEM;
 		}
 
 		rte_index = gsi - gsi_base;
@@ -603,7 +603,7 @@ register_intr (unsigned int gsi, int vec
 		struct iosapic_intr_info *info = &iosapic_intr_info[vector];
 		if (info->trigger != trigger || info->polarity != polarity) {
 			printk (KERN_WARNING "%s: cannot override the interrupt\n", __FUNCTION__);
-			return;
+			return -EINVAL;
 		}
 	}
 
@@ -623,6 +623,7 @@ register_intr (unsigned int gsi, int vec
 			       __FUNCTION__, vector, idesc->handler->typename, irq_type->typename);
 		idesc->handler = irq_type;
 	}
+	return 0;
 }
 
 static unsigned int
@@ -710,7 +711,7 @@ int
 iosapic_register_intr (unsigned int gsi,
 		       unsigned long polarity, unsigned long trigger)
 {
-	int vector, mask = 1;
+	int vector, mask = 1, err;
 	unsigned int dest;
 	unsigned long flags;
 	struct iosapic_rte_info *rte;
@@ -738,7 +739,7 @@ again:
 	if (vector < 0) {
 		vector = iosapic_find_sharable_vector(trigger, polarity);
 		if (vector < 0)
-			panic("%s: out of interrupt vectors!\n", __FUNCTION__);
+			return -ENOSPC;
 	}
 
 	spin_lock_irqsave(&irq_descp(vector)->lock, flags);
@@ -753,8 +754,13 @@ again:
 		}
 
 		dest = get_target_cpu(gsi, vector);
-		register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY,
+		err = register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY,
 			      polarity, trigger);
+		if (err < 0) {
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&irq_descp(vector)->lock, flags);
+			return err;
+		}
 
 		/*
 		 * If the vector is shared and already unmasked for
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
