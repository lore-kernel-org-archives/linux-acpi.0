From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v11 6/7] ACPI/IORT: Stub out ACS functions when CONFIG_PCI is not set
Date: Tue, 18 Dec 2018 02:56:05 +0000
Message-ID: <20181218025606.32668-7-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
A quick search reveals the following functions:
1. pci_request_acs()
2. pci_domain_nr()
3. pci_is_root_bus()
4. to_pci_dev()

Both pci_domain_nr() and pci_is_root_bus() are defined in linux/pci.h.
pci_domain_nr() is a stub function when CONFIG_PCI is not set and
pci_is_root_bus() just returns a reference to a structure member which
is still valid without CONFIG_PCI set.

to_pci_dev() is a macro that expands to container_of.

pci_request_acs() is the only code that gets pulled in from drivers/pci/*.c

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/arm64/iort.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..beb7e4c05bf5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1435,8 +1435,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	return ret;
 }
 
-static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
+#ifdef CONFIG_PCI
+static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 {
+	static bool acs_enabled __initdata;
+
+	if (acs_enabled)
+		return;
+
 	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_node *parent;
 		struct acpi_iort_id_mapping *map;
@@ -1458,13 +1464,16 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
 				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
 				pci_request_acs();
-				return true;
+				acs_enabled = true;
+				return;
 			}
 		}
 	}
-
-	return false;
+	return;
 }
+#else
+static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
+#endif
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1472,7 +1481,6 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
-	bool acs_enabled = false;
 	const struct iort_dev_config *ops;
 
 	/*
@@ -1493,8 +1501,7 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		if (!acs_enabled)
-			acs_enabled = iort_enable_acs(iort_node);
+		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
-- 
2.19.0
