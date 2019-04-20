From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [PATCH 1/3] PCI: Cleanup printk logging
Date: Sat, 20 Apr 2019 07:03:46 +0300
Message-ID: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/pci-acpi.c | 11 ++++-------
 drivers/pci/quirks.c   |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7..3ada026 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -140,8 +140,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 		hpx->t0->enable_perr     = fields[5].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 0 Revision %d record not supported\n",
+		pr_warn("%s: Type 0 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -169,8 +168,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 		hpx->t1->tot_max_split = fields[4].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 1 Revision %d record not supported\n",
+		pr_warn("%s: Type 1 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -211,8 +209,7 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
 		break;
 	default:
-		printk(KERN_WARNING
-		       "%s: Type 2 Revision %d record not supported\n",
+		pr_warn("%s: Type 2 Revision %d record not supported\n",
 		       __func__, revision);
 		return AE_ERROR;
 	}
@@ -272,7 +269,7 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 				goto exit;
 			break;
 		default:
-			printk(KERN_ERR "%s: Type %d record not supported\n",
+			pr_err("%s: Type %d record not supported\n",
 			       __func__, type);
 			status = AE_ERROR;
 			goto exit;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f9cd4d4..06af0c3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x74, &cfg);
 
 	if (cfg & ((1 << 2) | (1 << 15))) {
-		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
+		pr_info("Rewriting IRQ routing register on MCP55\n");
 		cfg &= ~((1 << 2) | (1 << 15));
 		pci_write_config_dword(dev, 0x74, cfg);
 	}
-- 
2.7.4
