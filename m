From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 8/9] ACPI, APEI, GHES: Add PCIe AER recovery support
Date: Tue, 17 May 2011 16:08:38 +0800
Message-ID: <1305619719-7480-9-git-send-email-ying.huang@intel.com>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

aer_recover_queue() is called when recoverable PCIe AER errors are
notified by firmware to do the recovery work.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/ghes.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -45,6 +45,8 @@
 #include <linux/irq_work.h>
 #include <linux/llist.h>
 #include <linux/genalloc.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
 #include <acpi/apei.h>
 #include <acpi/atomicio.h>
 #include <acpi/hed.h>
@@ -446,6 +448,27 @@ static void ghes_do_proc(const struct ac
 			}
 #endif
 		}
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+		else if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
+				      CPER_SEC_PCIE)) {
+			struct cper_sec_pcie *pcie_err;
+			pcie_err = (struct cper_sec_pcie *)(gdata+1);
+			if (sev == GHES_SEV_RECOVERABLE &&
+			    sec_sev == GHES_SEV_RECOVERABLE &&
+			    pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+			    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+				unsigned int devfn;
+				int aer_severity;
+				devfn = PCI_DEVFN(pcie_err->device_id.device,
+						  pcie_err->device_id.function);
+				aer_severity = cper_severity_to_aer(sev);
+				aer_recover_queue(pcie_err->device_id.segment,
+						  pcie_err->device_id.bus,
+						  devfn, aer_severity);
+			}
+
+		}
+#endif
 	}
 }
 
