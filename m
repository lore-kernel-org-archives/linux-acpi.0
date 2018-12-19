From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v12 1/7] ACPI: Move PCI reset to a separate function
Date: Wed, 19 Dec 2018 22:46:53 +0000
Message-ID: <20181219224659.4802-2-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Getting ready to factor out PCI specific code when CONFIG_PCI is unset.
Create a acpi_pci_reset() that kick starts PCI specific reset.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/reboot.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index 6fa9c2a4cfe9..d642a9dede52 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -4,11 +4,27 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
+{
+	unsigned int devfn;
+	struct pci_bus *bus0;
+
+	/* The reset register can only live on bus 0. */
+	bus0 = pci_find_bus(0, 0);
+	if (!bus0)
+		return;
+	/* Form PCI device/function pair. */
+	devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
+			  (rr->address >> 16) & 0xffff);
+	pr_debug("Resetting with ACPI PCI RESET_REG.\n");
+	/* Write the value that resets us. */
+	pci_bus_write_config_byte(bus0, devfn,
+			(rr->address & 0xffff), reset_value);
+}
+
 void acpi_reboot(void)
 {
 	struct acpi_generic_address *rr;
-	struct pci_bus *bus0;
-	unsigned int devfn;
 	u8 reset_value;
 
 	if (acpi_disabled)
@@ -33,17 +49,7 @@ void acpi_reboot(void)
 	 * on a device on bus 0. */
 	switch (rr->space_id) {
 	case ACPI_ADR_SPACE_PCI_CONFIG:
-		/* The reset register can only live on bus 0. */
-		bus0 = pci_find_bus(0, 0);
-		if (!bus0)
-			return;
-		/* Form PCI device/function pair. */
-		devfn = PCI_DEVFN((rr->address >> 32) & 0xffff,
-				  (rr->address >> 16) & 0xffff);
-		printk(KERN_DEBUG "Resetting with ACPI PCI RESET_REG.\n");
-		/* Write the value that resets us. */
-		pci_bus_write_config_byte(bus0, devfn,
-				(rr->address & 0xffff), reset_value);
+		acpi_pci_reboot(rr, reset_value);
 		break;
 
 	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-- 
2.19.0
