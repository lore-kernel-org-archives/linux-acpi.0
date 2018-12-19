From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v12 3/7] ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date: Wed, 19 Dec 2018 22:46:55 +0000
Message-ID: <20181219224659.4802-4-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Anuj Mittal <anuj.mittal@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "open list:ACPI COMPONENT ARCHITECTURE ACPICA" <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Allow ACPI to be built without PCI support in place.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpica/Makefile    | 2 +-
 drivers/acpi/acpica/achware.h   | 9 +++++++++
 drivers/acpi/acpica/evhandler.c | 8 ++++----
 drivers/acpi/acpica/exregion.c  | 4 ++++
 drivers/acpi/osl.c              | 2 ++
 include/acpi/platform/aclinux.h | 4 ++++
 6 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index b14621da5413..59700433a96e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -77,13 +77,13 @@ acpi-y +=		\
 	hwacpi.o	\
 	hwesleep.o	\
 	hwgpe.o		\
-	hwpci.o		\
 	hwregs.o	\
 	hwsleep.o	\
 	hwvalid.o	\
 	hwxface.o	\
 	hwxfsleep.o
 
+acpi-$(CONFIG_PCI) += hwpci.o
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
 acpi-y +=		\
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 43ce67a9da1f..ef99e2fc37f8 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -106,11 +106,20 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
 				 void *context);
 
+#ifdef ACPI_PCI_CONFIGURED
 /*
  * hwpci - PCI configuration support
  */
 acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
+#else
+static inline acpi_status
+acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id, acpi_handle root_pci_device,
+		      acpi_handle pci_region)
+{
+	return AE_SUPPORT;
+}
+#endif
 
 #endif				/* __ACHWARE_H__ */
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index d319ee33d040..4ed1e67db6be 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -364,25 +364,25 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 			handler = acpi_ex_system_io_space_handler;
 			setup = acpi_ev_io_space_region_setup;
 			break;
-
+#ifdef ACPI_PCI_CONFIGURED
 		case ACPI_ADR_SPACE_PCI_CONFIG:
 
 			handler = acpi_ex_pci_config_space_handler;
 			setup = acpi_ev_pci_config_region_setup;
 			break;
-
+#endif
 		case ACPI_ADR_SPACE_CMOS:
 
 			handler = acpi_ex_cmos_space_handler;
 			setup = acpi_ev_cmos_region_setup;
 			break;
-
+#ifdef ACPI_PCI_CONFIGURED
 		case ACPI_ADR_SPACE_PCI_BAR_TARGET:
 
 			handler = acpi_ex_pci_bar_space_handler;
 			setup = acpi_ev_pci_bar_region_setup;
 			break;
-
+#endif
 		case ACPI_ADR_SPACE_DATA_TABLE:
 
 			handler = acpi_ex_data_table_space_handler;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 97bbfd07fcf7..2c58f5e00b1a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -311,6 +311,7 @@ acpi_ex_system_io_space_handler(u32 function,
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_PCI_CONFIGURED
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_pci_config_space_handler
@@ -387,6 +388,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 /*******************************************************************************
  *
@@ -420,6 +422,7 @@ acpi_ex_cmos_space_handler(u32 function,
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_PCI_CONFIGURED
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_pci_bar_space_handler
@@ -451,6 +454,7 @@ acpi_ex_pci_bar_space_handler(u32 function,
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..f29e427d0d1d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -769,6 +769,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 	return AE_OK;
 }
 
+#ifdef CONFIG_PCI
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
@@ -827,6 +828,7 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 	return (result ? AE_ERROR : AE_OK);
 }
+#endif
 
 static void acpi_os_execute_deferred(struct work_struct *work)
 {
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 7451b3bca83a..e3d21d014fcc 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -33,6 +33,10 @@
 
 /* Kernel specific ACPICA configuration */
 
+#ifdef CONFIG_PCI
+#define ACPI_PCI_CONFIGURED
+#endif
+
 #ifdef CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 #define ACPI_REDUCED_HARDWARE 1
 #endif
-- 
2.19.0
