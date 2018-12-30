From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v4 01/11] ACPI / LPSS: Make PCI dependency explicit
Date: Sun, 30 Dec 2018 19:56:02 +0000
Message-ID: <20181230195612.6657-2-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This code depends on PCI. Compile only when PCI is present.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/Makefile   | 3 ++-
 drivers/acpi/internal.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 7c6afc111d76..bb857421c2e8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,7 +41,8 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
-acpi-y				+= acpi_lpss.o acpi_apd.o
+acpi-$(CONFIG_PCI)		+= acpi_lpss.o
+acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 7e6952edb5b0..6a9e1fb8913a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -81,7 +81,11 @@ void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
 #endif
+#ifdef CONFIG_PCI
 void acpi_lpss_init(void);
+#else
+static inline void acpi_lpss_init(void) {}
+#endif
 
 void acpi_apd_init(void);
 
-- 
2.19.0
