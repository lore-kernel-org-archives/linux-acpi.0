From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 1/6] PNP: fix up after Lindent
Date: Wed, 15 Aug 2007 10:32:08 -0600
Message-ID: <20070815163432.109206003@ldl.fc.hp.com>
References: <20070815163207.062263984@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:51683 "EHLO
	tayrelbas04.tay.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbXHOQyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Aug 2007 12:54:08 -0400
Content-Disposition: inline; filename=pnp-lindent-fixup2
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

More manual fixups after Lindent.  No functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/card.c
===================================================================
--- w.orig/drivers/pnp/card.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/card.c	2007-08-14 10:08:15.000000000 -0600
@@ -25,13 +25,13 @@
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
@@ -183,7 +183,7 @@
 
 	return 0;
 
-      err_name:
+err_name:
 	device_remove_file(&card->dev, &dev_attr_name);
 	return rc;
 }
@@ -321,10 +321,10 @@
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
@@ -334,7 +334,7 @@
 
 	return dev;
 
-      err_out:
+err_out:
 	dev->dev.driver = NULL;
 	dev->card_link = NULL;
 	return NULL;
Index: w/drivers/pnp/driver.c
===================================================================
--- w.orig/drivers/pnp/driver.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/driver.c	2007-08-14 10:26:12.000000000 -0600
@@ -118,7 +118,7 @@
 		goto fail;
 	return error;
 
-      fail:
+fail:
 	pnp_device_detach(pnp_dev);
 	return error;
 }
Index: w/drivers/pnp/interface.c
===================================================================
--- w.orig/drivers/pnp/interface.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/interface.c	2007-08-14 10:08:48.000000000 -0600
@@ -459,7 +459,8 @@
 		up(&pnp_res_mutex);
 		goto done;
 	}
-      done:
+
+done:
 	if (retval < 0)
 		return retval;
 	return count;
@@ -499,10 +500,10 @@
 
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
Index: w/drivers/pnp/isapnp/core.c
===================================================================
--- w.orig/drivers/pnp/isapnp/core.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/isapnp/core.c	2007-08-14 10:26:12.000000000 -0600
@@ -335,7 +335,7 @@
 		} else if (iteration > 1) {
 			break;
 		}
-	      __next:
+__next:
 		if (csn == 255)
 			break;
 		checksum = 0x6a;
@@ -733,7 +733,7 @@
 			       "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n",
 			       type, dev->number, card->number);
 		}
-	      __skip:
+__skip:
 		if (size > 0)
 			isapnp_skip_bytes(size);
 	}
@@ -788,7 +788,7 @@
 			       "isapnp: unexpected or unknown tag type 0x%x for device %i, ignored\n",
 			       type, card->number);
 		}
-	      __skip:
+__skip:
 		if (size > 0)
 			isapnp_skip_bytes(size);
 	}
@@ -940,9 +940,6 @@
 EXPORT_SYMBOL(isapnp_present);
 EXPORT_SYMBOL(isapnp_cfg_begin);
 EXPORT_SYMBOL(isapnp_cfg_end);
-#if 0
-EXPORT_SYMBOL(isapnp_read_byte);
-#endif
 EXPORT_SYMBOL(isapnp_write_byte);
 
 static int isapnp_read_resources(struct pnp_dev *dev,
@@ -993,6 +990,7 @@
 				struct pnp_resource_table *res)
 {
 	int ret;
+
 	pnp_init_resource_table(res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	ret = isapnp_read_resources(dev, res);
@@ -1148,13 +1146,12 @@
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
Index: w/drivers/pnp/manager.c
===================================================================
--- w.orig/drivers/pnp/manager.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/manager.c	2007-08-14 10:26:12.000000000 -0600
@@ -390,7 +390,7 @@
 	up(&pnp_res_mutex);
 	return 1;
 
-      fail:
+fail:
 	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 	return 0;
@@ -444,7 +444,7 @@
 	kfree(bak);
 	return 0;
 
-      fail:
+fail:
 	dev->res = *bak;
 	up(&pnp_res_mutex);
 	kfree(bak);
Index: w/drivers/pnp/pnpacpi/core.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/core.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/pnpacpi/core.c	2007-08-14 10:08:15.000000000 -0600
@@ -248,9 +248,9 @@
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
Index: w/drivers/pnp/pnpbios/proc.c
===================================================================
--- w.orig/drivers/pnp/pnpbios/proc.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/pnpbios/proc.c	2007-08-14 10:08:15.000000000 -0600
@@ -212,7 +212,7 @@
 		goto out;
 	}
 	ret = count;
-      out:
+out:
 	kfree(node);
 	return ret;
 }
Index: w/drivers/pnp/pnpbios/rsparser.c
===================================================================
--- w.orig/drivers/pnp/pnpbios/rsparser.c	2007-08-14 10:01:11.000000000 -0600
+++ w/drivers/pnp/pnpbios/rsparser.c	2007-08-14 10:23:45.000000000 -0600
@@ -238,7 +238,7 @@
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -298,6 +298,7 @@
 					     struct pnp_option *option)
 {
 	struct pnp_mem *mem;
+
 	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
@@ -468,7 +469,7 @@
 			return p + 2;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -562,7 +563,7 @@
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
@@ -756,7 +757,7 @@
 			break;
 
 		default:	/* an unkown tag */
-		      len_err:
+len_err:
 			printk(KERN_ERR
 			       "PnPBIOS: Unknown tag '0x%x', length '%d'.\n",
 			       tag, len);
Index: w/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- w.orig/drivers/pnp/pnpacpi/rsparser.c	2007-08-14 10:26:16.000000000 -0600
+++ w/drivers/pnp/pnpacpi/rsparser.c	2007-08-14 10:33:20.000000000 -0600
@@ -35,6 +35,7 @@
 static int irq_flags(int triggering, int polarity)
 {
 	int flag;
+
 	if (triggering == ACPI_LEVEL_SENSITIVE) {
 		if (polarity == ACPI_ACTIVE_LOW)
 			flag = IORESOURCE_IRQ_LOWLEVEL;
Index: w/drivers/pnp/pnpbios/core.c
===================================================================
--- w.orig/drivers/pnp/pnpbios/core.c	2007-08-14 10:33:24.000000000 -0600
+++ w/drivers/pnp/pnpbios/core.c	2007-08-14 10:33:47.000000000 -0600
@@ -591,6 +591,7 @@
 static int __init pnpbios_thread_init(void)
 {
 	struct task_struct *task;
+
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(PNPBIOS_BASE))
 		return 0;

--
