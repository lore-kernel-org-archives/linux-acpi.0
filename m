From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] acpi/pci_link.c
Date: 04 Nov 2003 23:50:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068007845.6059.33.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-npUQvK1hNNSg9J4HZN10"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-npUQvK1hNNSg9J4HZN10
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please review this interrupt patch.
It applies to both 2.4 and 2.6.

thanks,
-Len

What the patch does:

Re-enables PCI Link Device programming by default.

This fixes systems that stopped working when we
stopped re-programming active PIRQs:
http://bugzilla.kernel.org/show_bug.cgi?id=1440

For systems that mark their PIRQ links active,
this allows the kernel to again distribute
PIRQs across all available IRQs:
http://bugzilla.kernel.org/show_bug.cgi?id=1391

Fixes an off-by-one bug in the PIRQ distribution
code that caused one of the possible IRQs to be
ignored on every PIRQ link.

To aid in minimizing IRQ sharing, added cmdline
"acpi_irq_pci=" to tell the kernel when it can
use an IRQ for PCI, even if the kernel default
is to reserve that IRQ for ISA use.

Conversely, added "acpi_irq_isa=" cmdline param
to reserve IRQs for ISA.
Workaround for SoundBlaster vs. ACPI PIRQ routing issues:
http://bugzilla.kernel.org/show_bug.cgi?id=430
http://bugzilla.kernel.org/show_bug.cgi?id=1139

Previously we had disabled re-programming active PIRQs to
address http://bugzilla.kernel.org/show_bug.cgi?id=1186
This change will break those broken systems again, unless
they've been fixed in other ways.

Mitigated the impact with a new cmdline parameter
"acpi_irq_static" that restores the previous behavior
of not moving PCI Link devices that are marked active.




--=-npUQvK1hNNSg9J4HZN10
Content-Disposition: attachment; filename=pci_link.patch
Content-Type: text/plain; name=pci_link.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.20 vs edited =====
--- 1.20/drivers/acpi/pci_link.c	Tue Sep 30 00:50:34 2003
+++ edited/drivers/acpi/pci_link.c	Tue Nov  4 23:40:44 2003
@@ -99,7 +99,7 @@
 	void			*context)
 {
 	struct acpi_pci_link	*link = (struct acpi_pci_link *) context;
-	int			i = 0;
+	u32			i = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_check_possible");
 
@@ -294,7 +294,10 @@
 
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource found\n"));
-		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for device (%s [%s]).\n", irq, acpi_device_name(link->device), acpi_device_bid(link->device));
+		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for"
+			"device (%s [%s]).\n", irq,
+			acpi_device_name(link->device),
+			acpi_device_bid(link->device));
 		link->irq.active = irq;
 	}
 	
@@ -429,30 +432,61 @@
                             PCI Link IRQ Management
    -------------------------------------------------------------------------- */
 
-#define ACPI_MAX_IRQS		256
-#define ACPI_MAX_ISA_IRQ	16
-
 /*
- * IRQ penalties are used to promote PCI IRQ balancing.  We set each ISA-
- * possible IRQ (0-15) with a default penalty relative to its feasibility
- * for PCI's use:
+ * Interrupt sharing can impact performance, so this code
+ * spreads the PCI link devices across the available IRQs.
+ *
+ * A tables of penalties avoids directing PCI interrupts to well known
+ * ISA IRQs. Boot params are available to over-ride the default table:
  *
- *   Never use:		0, 1, 2 (timer, keyboard, and cascade)
- *   Avoid using:	13, 14, and 15 (FP error and IDE)
- *   Penalize:		3, 4, 6, 7, 12 (known ISA uses)
+ * List interrupts that are free for PCI use.
+ * acpi_irq_pci=n[,m]
  *
- * Thus we're left with IRQs 5, 9, 10, 11, and everything above 15 (IO[S]APIC)
- * as 'best bets' for PCI use.
+ * List interrupts that should not be used for PCI:
+ * acpi_irq_isa=n[,m]
+ *
+ * Note that PCI IRQ routers have a list of possible IRQs,
+ * which may not include the IRQs this table says are available.
+ * 
+ * Since this heuristic can't tell the difference between a link
+ * that no device will attach to, vs. a link which may be shared
+ * by multiple active devices -- it is not optimal.
+ *
+ * If interrupt performance is that important, get an IO-APIC system
+ * with a pin dedicated to each device.  Or for that matter, an MSI
+ * enabled system.
  */
 
+#define ACPI_MAX_IRQS		256
+#define ACPI_MAX_ISA_IRQ	16
+
+#define PIRQ_PENALTY_PCI_AVAILABLE	(0)
+#define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
+#define PIRQ_PENALTY_PCI_USING		(16*16*16)
+#define PIRQ_PENALTY_ISA_TYPICAL	(16*16*16*16)
+#define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
+#define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
+
 static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
-	1000000,  1000000,  1000000,    10000, 
-	  10000,        0,    10000,    10000,
-	  10000,        0,        0,        0, 
-	  10000,   100000,   100000,   100000,
+	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
+	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
+	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ3	serial */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ4	serial */
+	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ5 PCI */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ6 */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ7 parallel, spurious */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ8 rtc, sometimes */
+	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
+	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
+	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
+	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ12 mouse */
+	PIRQ_PENALTY_ISA_USED,	/* IRQ13 fpe, sometimes */
+	PIRQ_PENALTY_ISA_USED,	/* IRQ14 ide0 */
+	PIRQ_PENALTY_ISA_USED,	/* IRQ15 ide1 */
+			/* >IRQ15 */
 };
 
-
 int
 acpi_pci_link_check (void)
 {
@@ -473,20 +507,27 @@
 			continue;
 		}
 
-		if (link->irq.active)
-			acpi_irq_penalty[link->irq.active] += 100;
-		else if (link->irq.possible_count) {
-			int penalty = 100 / link->irq.possible_count;
-			for (i=0; i<link->irq.possible_count; i++) {
+		/*
+		 * reflect the possible and active irqs in the penalty table --
+		 * useful for breaking ties.
+		 */
+		if (link->irq.possible_count) {
+			int penalty = PIRQ_PENALTY_PCI_POSSIBLE / link->irq.possible_count;
+
+			for (i = 0; i < link->irq.possible_count; i++) {
 				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
 					acpi_irq_penalty[link->irq.possible[i]] += penalty;
 			}
+
+		} else if (link->irq.active) {
+			acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_POSSIBLE;
 		}
 	}
-
 	return_VALUE(0);
 }
 
+static int acpi_irq_static;	/* don't re-program active IRQs */
+
 static int acpi_pci_link_allocate(struct acpi_pci_link* link) {
 	int irq;
 	int i;
@@ -500,12 +541,14 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
+	}
 
+	if (!(link->irq.active && acpi_irq_static)) {
 		/*
 		 * Select the best IRQ.  This is done in reverse to promote
 		 * the use of IRQs 9, 10, 11, and >15.
 		 */
-		for (i=(link->irq.possible_count-1); i>0; i--) {
+		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
 			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
 				irq = link->irq.possible[i];
 		}
@@ -518,13 +561,14 @@
 			acpi_device_bid(link->device));
 		return_VALUE(-ENODEV);
 	} else {
-		acpi_irq_penalty[link->irq.active] += 100;
+		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
 
 	link->irq.setonboot = 1;
+
 	return_VALUE(0);
 }
 
@@ -607,9 +651,12 @@
 	if (result)
 		goto end;
 
+	/* query and set link->irq.active */
 	acpi_pci_link_get_current(link);
 
-	printk(PREFIX "%s [%s] (IRQs", acpi_device_name(device), acpi_device_bid(device));
+//#ifdef CONFIG_ACPI_DEBUG
+	printk(PREFIX "%s [%s] (IRQs", acpi_device_name(device),
+		acpi_device_bid(device));
 	for (i = 0; i < link->irq.possible_count; i++) {
 		if (link->irq.active == link->irq.possible[i]) {
 			printk(" *%d", link->irq.possible[i]);
@@ -619,6 +666,7 @@
 			printk(" %d", link->irq.possible[i]);
 	}
 	printk(")\n");
+//#endif /* CONFIG_ACPI_DEBUG */
 
 	/* TBD: Acquire/release lock */
 	list_add_tail(&link->node, &acpi_link.entries);
@@ -670,5 +718,73 @@
 
 	return_VALUE(0);
 }
+
+/*
+ * modify acpi_irq_penalty[] from cmdline
+ */
+static int __init acpi_irq_penalty_update(char *str, int used)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		int retval;
+		int irq;
+
+		retval = get_option(&str,&irq);
+
+		if (!retval)
+			break;	/* no number found */
+
+		if (irq < 0)
+			continue;
+		
+		if (irq >= ACPI_MAX_IRQS)
+			continue;
+
+		if (used)
+			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+		else
+			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
+
+		if (retval != 2)	/* no next number */
+			break;
+	}
+	return 1;
+}
+
+/*
+ * Over-ride default table to reserve additional IRQs for use by ISA
+ * e.g. acpi_irq_isa=5
+ * Useful for telling ACPI how not to interfere with your ISA sound card.
+ */
+static int __init acpi_irq_isa(char *str)
+{
+	return(acpi_irq_penalty_update(str, 1));
+}
+__setup("acpi_irq_isa=", acpi_irq_isa);
+
+
+/*
+ * Over-ride default table to free additional IRQs for use by PCI
+ * e.g. acpi_irq_pci=7,15
+ * Useful for freeing up IRQs to reduce PCI IRQ sharing.
+ */
+static int __init acpi_irq_pci(char *str)
+{
+	return(acpi_irq_penalty_update(str, 0));
+}
+__setup("acpi_irq_pci=", acpi_irq_pci);
+
+/*
+ * Do not re-program active IRQs,
+ * keep the static active settings left by the BIOS.
+ * Useful for working around broken BIOS.
+ */
+static int __init acpi_irq_static_set(char *str)
+{
+	acpi_irq_static = 1;
+	return(1);
+}
+__setup("acpi_irq_static", acpi_irq_static_set);
 
 subsys_initcall(acpi_pci_link_init);

--=-npUQvK1hNNSg9J4HZN10--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
