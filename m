From: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/25] PNP: fix up after Lindent
Date: Fri, 24 Aug 2007 03:21:05 -0400
Message-ID: <1187940094867-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762944AbXHXHVg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:36 -0400
In-Reply-To: <11879400933976-git-send-email-len.brown@intel.com>
Message-Id: <1e0aa9ad721349781b728ec4226876247e3fd431.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

More manual fixups after Lindent.  No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Adam Belay <abelay@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/card.c             |   16 ++++++++--------
 drivers/pnp/driver.c           |    2 +-
 drivers/pnp/interface.c        |    9 +++++----
 drivers/pnp/isapnp/core.c      |   15 ++++++---------
 drivers/pnp/manager.c          |    4 ++--
 drivers/pnp/pnpacpi/core.c     |    4 ++--
 drivers/pnp/pnpacpi/rsparser.c |    1 +
 drivers/pnp/pnpbios/core.c     |    1 +
 drivers/pnp/pnpbios/proc.c     |    2 +-
 drivers/pnp/pnpbios/rsparser.c |    9 +++++----
 10 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index b6a4f02..6c0440c 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -25,13 +25,13 @@ static const struct pnp_card_device_id *match_card(struct pnp_card_driver *drv,
 				int found;
 				struct pnp_dev *dev;
 
-				if (i == PNP_MAX_DEVICES
-				    || !*drv_id->devs[i].id)
+				if (i == PNP_MAX_DEVICES ||
+				    !*drv_id->devs[i].id)
 					return drv_id;
 				found = 0;
 				card_for_each_dev(card, dev) {
-					if (compare_pnp_id
-					    (dev->id, drv_id->devs[i].id)) {
+					if (compare_pnp_id(dev->id,
+						   drv_id->devs[i].id)) {
 						found = 1;
 						break;
 					}
@@ -183,7 +183,7 @@ static int pnp_interface_attach_card(struct pnp_card *card)
 
 	return 0;
 
-      err_name:
+err_name:
 	device_remove_file(&card->dev, &dev_attr_name);
 	return rc;
 }
@@ -321,10 +321,10 @@ struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
 		pos = pos->next;
 	}
 
-      done:
+done:
 	return NULL;
 
-      found:
+found:
 	dev->card_link = clink;
 	dev->dev.driver = &drv->link.driver;
 	if (pnp_bus_type.probe(&dev->dev))
@@ -334,7 +334,7 @@ struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
 
 	return dev;
 
-      err_out:
+err_out:
 	dev->dev.driver = NULL;
 	dev->card_link = NULL;
 	return NULL;
diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 30b8f6f..9be01b0 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -118,7 +118,7 @@ static int pnp_device_probe(struct device *dev)
 		goto fail;
 	return error;
 
-      fail:
+fail:
 	pnp_device_detach(pnp_dev);
 	return error;
 }
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index fe6684e..a0cfb75 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -459,7 +459,8 @@ pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
 		up(&pnp_res_mutex);
 		goto done;
 	}
-      done:
+
+done:
 	if (retval < 0)
 		return retval;
 	return count;
@@ -499,10 +500,10 @@ int pnp_interface_attach_device(struct pnp_dev *dev)
 
 	return 0;
 
-      err_res:
+err_res:
 	device_remove_file(&dev->dev, &dev_attr_resources);
-      err_opt:
+err_opt:
 	device_remove_file(&dev->dev, &dev_attr_options);
-      err:
+err:
 	return rc;
 }
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index b4e2aa9..32386ce 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -335,7 +335,7 @@ static int __init isapnp_isolate(void)
 		} else if (iteration > 1) {
 			break;
 		}
-	      __next:
+__next:
 		if (csn == 255)
 			break;
 		checksum = 0x6a;
@@ -733,7 +733,7 @@ static int __init isapnp_create_device(struct pnp_card *card,
 			       "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n",
 			       type, dev->number, card->number);
 		}
-	      __skip:
+__skip:
 		if (size > 0)
 			isapnp_skip_bytes(size);
 	}
@@ -788,7 +788,7 @@ static void __init isapnp_parse_resource_map(struct pnp_card *card)
 			       "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n",
 			       type, card->number);
 		}
-	      __skip:
+__skip:
 		if (size > 0)
 			isapnp_skip_bytes(size);
 	}
@@ -940,9 +940,6 @@ EXPORT_SYMBOL(isapnp_protocol);
 EXPORT_SYMBOL(isapnp_present);
 EXPORT_SYMBOL(isapnp_cfg_begin);
 EXPORT_SYMBOL(isapnp_cfg_end);
-#if 0
-EXPORT_SYMBOL(isapnp_read_byte);
-#endif
 EXPORT_SYMBOL(isapnp_write_byte);
 
 static int isapnp_read_resources(struct pnp_dev *dev,
@@ -993,6 +990,7 @@ static int isapnp_get_resources(struct pnp_dev *dev,
 				struct pnp_resource_table *res)
 {
 	int ret;
+
 	pnp_init_resource_table(res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	ret = isapnp_read_resources(dev, res);
@@ -1148,13 +1146,12 @@ static int __init isapnp_init(void)
 			}
 		}
 	}
-	if (cards) {
+	if (cards)
 		printk(KERN_INFO
 		       "isapnp: %i Plug & Play card%s detected total\n", cards,
 		       cards > 1 ? "s" : "");
-	} else {
+	else
 		printk(KERN_INFO "isapnp: No Plug & Play card found\n");
-	}
 
 	isapnp_proc_init();
 	return 0;
diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index 3bda513..329dc6c 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -390,7 +390,7 @@ static int pnp_assign_resources(struct pnp_dev *dev, int depnum)
 	up(&pnp_res_mutex);
 	return 1;
 
-      fail:
+fail:
 	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 	return 0;
@@ -444,7 +444,7 @@ int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res,
 	kfree(bak);
 	return 0;
 
-      fail:
+fail:
 	dev->res = *bak;
 	up(&pnp_res_mutex);
 	kfree(bak);
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 616fc72..a5a3722 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -248,9 +248,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	num++;
 
 	return AE_OK;
-      err1:
+err1:
 	kfree(dev_id);
-      err:
+err:
 	kfree(dev);
 	return -EINVAL;
 }
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index ce5027f..51478c0 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -35,6 +35,7 @@
 static int irq_flags(int triggering, int polarity)
 {
 	int flag;
+
 	if (triggering == ACPI_LEVEL_SENSITIVE) {
 		if (polarity == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWLEVEL;
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 3692a09..9892a6a 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -591,6 +591,7 @@ subsys_initcall(pnpbios_init);
 static int __init pnpbios_thread_init(void)
 {
 	struct task_struct *task;
+
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(PNPBIOS_BASE))
 		return 0;
diff --git a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
index 9c8c077..9d9841f 100644
--- a/drivers/pnp/pnpbios/proc.c
+++ b/drivers/pnp/pnpbios/proc.c
@@ -212,7 +212,7 @@ static int proc_write_node(struct file *file, const char __user * buf,
 		goto out;
 	}
 	ret = count;
-      out:
+out:
 	kfree(node);
 	return ret;
 }
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 04ecd7b..3fabf11 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -238,7 +238,7 @@ static unsigned char *pnpbios_parse_allocated_resource_data(unsigned char *p,
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -298,6 +298,7 @@ static void pnpbios_parse_fixed_mem32_option(unsigned char *p, int size,
 					     struct pnp_option *option)
 {
 	struct pnp_mem *mem;
+
 	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
@@ -468,7 +469,7 @@ static unsigned char *pnpbios_parse_resource_option_data(unsigned char *p,
 			return p + 2;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -562,7 +563,7 @@ static unsigned char *pnpbios_parse_compatible_ids(unsigned char *p,
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -756,7 +757,7 @@ static unsigned char *pnpbios_encode_allocated_resource_data(unsigned char *p,
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
-- 
1.5.3.rc6.17.g1911
