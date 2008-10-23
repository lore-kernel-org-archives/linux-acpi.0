From: Len Brown <lenb@kernel.org>
Subject: [PATCH 036/122] PNP: remove some uses of DEBUG ifdef
Date: Thu, 23 Oct 2008 02:38:10 -0400
Message-ID: <2663f60d434139298835af690f4891cec5c1e501.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37866 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbYJWGj5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:57 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600K0OIIJ3M32@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:56 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Use scnprintf() to build up a buffer of PNP IDs to print.  This
makes the printk atomic and helps get rid of an #ifdef.

Also remove an "#ifdef DEBUG" from some debug functions.  The
functions only produce debug output, so it's OK to run the
function and just have the output be dropped at the end.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/core.c    |   18 ++++++++----------
 drivers/pnp/support.c |    4 ----
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index a411582..7cb1ffc 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -185,6 +185,9 @@ int __pnp_add_device(struct pnp_dev *dev)
 int pnp_add_device(struct pnp_dev *dev)
 {
 	int ret;
+	char buf[128];
+	int len = 0;
+	struct pnp_id *id;
 
 	if (dev->card)
 		return -EINVAL;
@@ -193,17 +196,12 @@ int pnp_add_device(struct pnp_dev *dev)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_PNP_DEBUG
-	{
-		struct pnp_id *id;
+	buf[0] = '\0';
+	for (id = dev->id; id; id = id->next)
+		len += scnprintf(buf + len, sizeof(buf) - len, " %s", id->id);
 
-		dev_printk(KERN_DEBUG, &dev->dev, "%s device, IDs",
-			dev->protocol->name);
-		for (id = dev->id; id; id = id->next)
-			printk(" %s", id->id);
-		printk(" (%s)\n", dev->active ? "active" : "disabled");
-	}
-#endif
+	dev_dbg(&dev->dev, "%s device, IDs%s (%s)\n",
+		dev->protocol->name, buf, dev->active ? "active" : "disabled");
 	return 0;
 }
 
diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index b42df16..7149186 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -75,7 +75,6 @@ char *pnp_resource_type_name(struct resource *res)
 
 void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 {
-#ifdef DEBUG
 	char buf[128];
 	int len;
 	struct pnp_resource *pnp_res;
@@ -118,7 +117,6 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 		}
 		dev_dbg(&dev->dev, "%s\n", buf);
 	}
-#endif
 }
 
 char *pnp_option_priority_name(struct pnp_option *option)
@@ -136,7 +134,6 @@ char *pnp_option_priority_name(struct pnp_option *option)
 
 void dbg_pnp_show_option(struct pnp_dev *dev, struct pnp_option *option)
 {
-#ifdef DEBUG
 	char buf[128];
 	int len = 0, i;
 	struct pnp_port *port;
@@ -209,5 +206,4 @@ void dbg_pnp_show_option(struct pnp_dev *dev, struct pnp_option *option)
 		break;
 	}
 	dev_dbg(&dev->dev, "%s\n", buf);
-#endif
 }
-- 
1.5.5.1

