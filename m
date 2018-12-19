From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v12 2/7] ACPI: Allow CONFIG_PCI to be unset for reboot
Date: Wed, 19 Dec 2018 22:46:54 +0000
Message-ID: <20181219224659.4802-3-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Make PCI reboot conditional on CONFIG_PCI set on the kernel configuration.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/reboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index d642a9dede52..ca707f5b521d 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -4,6 +4,7 @@
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
 
+#ifdef CONFIG_PCI
 static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
 {
 	unsigned int devfn;
@@ -21,6 +22,13 @@ static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
 	pci_bus_write_config_byte(bus0, devfn,
 			(rr->address & 0xffff), reset_value);
 }
+#else
+static inline void acpi_pci_reboot(struct acpi_generic_address *rr,
+				   u8 reset_value)
+{
+	pr_warn_once("PCI configuration space access is not supported\n");
+}
+#endif
 
 void acpi_reboot(void)
 {
-- 
2.19.0
