From: Kristen Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Pcihpd-discuss] [patch 2/2] acpi: add ability to derive irq
 when doing a surprise removal of an adapter
Date: Fri, 07 Oct 2005 13:59:24 -0700
Message-ID: <1128718764.11020.22.camel@whizzy>
References: <1128707174.11020.12.camel@whizzy>
	 <20051007175253.GC22697@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051007175253.GC22697-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If an adapter is surprise removed, the interrupt pin must be guessed, as
any attempts to read it would obviously be invalid.  cycle through all
possible interrupt pin values until we can either lookup or derive the
right irq to disable.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

diff -uprN -X linux-2.6.14-rc3.orig/Documentation/dontdiff linux-2.6.14-rc3.orig/drivers/acpi/pci_irq.c linux-2.6.14-rc3/drivers/acpi/pci_irq.c
--- linux-2.6.14-rc3.orig/drivers/acpi/pci_irq.c	2005-10-07 13:37:50.000000000 -0700
+++ linux-2.6.14-rc3/drivers/acpi/pci_irq.c	2005-10-07 13:36:14.000000000 -0700
@@ -491,6 +491,81 @@ void __attribute__ ((weak)) acpi_unregis
 {
 }
 
+
+
+/*
+ * This function will be called only in the case of
+ * a "surprise" hot plug removal.  For surprise removals,
+ * the card has either already be yanked out of the slot, or
+ * the slot's been powered off, so we have to brute force 
+ * our way through all the possible interrupt pins to derive
+ * the GSI, then we double check with the value stored in the
+ * pci_dev structure to make sure we have the GSI that belongs
+ * to this IRQ.
+ */
+void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
+{
+	int gsi = 0;
+	u8  pin = 0;
+	int edge_level = ACPI_LEVEL_SENSITIVE;
+	int active_high_low = ACPI_ACTIVE_LOW;
+	int irq;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_irq_disable_nodev");
+
+	/* 
+	 * since our device is not present, we 
+	 * can't just read the interrupt pin
+	 * and use the value to derive the irq.
+	 * in this case, we are going to check
+	 * each returned irq value to make
+	 * sure it matches our already assigned
+	 * irq before we use it.
+	 */
+	for (pin = 0; pin < 4; pin++) {
+		/*
+	 	 * First we check the PCI IRQ routing table (PRT) for an IRQ.
+	 	 */
+		gsi = acpi_pci_irq_lookup(dev->bus, PCI_SLOT(dev->devfn), pin,
+				  &edge_level, &active_high_low, NULL,
+				  acpi_pci_free_irq);
+
+		/*
+	 	 * If no PRT entry was found, we'll try to derive an IRQ from the
+	 	 * device's parent bridge.
+	 	 */
+		if (gsi < 0)
+ 			gsi = acpi_pci_irq_derive(dev, pin,
+				&edge_level, &active_high_low, NULL, acpi_pci_free_irq);
+
+		/* 
+		 * If we could not derive the IRQ, give up on this pin number
+		 * and try a different one.
+		 */
+		if (gsi < 0)
+		 	continue;	
+		
+		if (acpi_gsi_to_irq(gsi, &irq) < 0)
+			continue;
+
+		/* 
+		 * make sure we got the right irq 
+		 */
+		if (irq == dev->irq) {
+			printk(KERN_INFO PREFIX 
+				"PCI interrupt for device %s disabled\n",
+	       			pci_name(dev));
+
+			acpi_unregister_gsi(gsi);
+			return_VOID;
+		}
+	}
+	return_VOID;
+}
+
+
+
+
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
 	int gsi = 0;
@@ -506,6 +581,14 @@ void acpi_pci_irq_disable(struct pci_dev
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin)
 		return_VOID;
+
+	/* 
+	 * Check to see if the device was present 
+	 */
+	if (pin == 0xff) {
+		acpi_pci_irq_disable_nodev(dev);
+		return_VOID;
+	}
 	pin--;
 
 	/*



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
