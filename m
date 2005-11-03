From: Kristen Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 2/4] apci: use pin stored in pci_dev
Date: Wed, 02 Nov 2005 16:24:35 -0800
Message-ID: <1130977475.8321.40.camel@whizzy>
References: <20051103001540.365407000@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Use the stored value of the Interrupt Pin, rather than try to read
it again.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
 
 drivers/acpi/pci_irq.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.13/drivers/acpi/pci_irq.c
===================================================================
--- linux-2.6.13.orig/drivers/acpi/pci_irq.c
+++ linux-2.6.13/drivers/acpi/pci_irq.c
@@ -361,8 +361,7 @@ acpi_pci_irq_derive(struct pci_dev *dev,
 
 		if ((bridge->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
 			/* PC card has the same IRQ as its cardbridge */
-			pci_read_config_byte(bridge, PCI_INTERRUPT_PIN,
-					     &bridge_pin);
+			bridge_pin = bridge->pin;
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "No interrupt pin configured for device %s\n",
@@ -412,7 +411,7 @@ int acpi_pci_irq_enable(struct pci_dev *
 	if (!dev)
 		return_VALUE(-EINVAL);
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No interrupt pin configured for device %s\n",
@@ -503,7 +502,7 @@ void acpi_pci_irq_disable(struct pci_dev
 	if (!dev || !dev->bus)
 		return_VOID;
 
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pin = dev->pin;
 	if (!pin)
 		return_VOID;
 	pin--;

--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
