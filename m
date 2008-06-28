From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/84] PNP: improve resource assignment debug
Date: Sat, 28 Jun 2008 01:44:15 -0400
Message-ID: <99bc99d3bcc726e596d5724ad9770d45eafe92e0.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:51161 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbYF1FrL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:47:11 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001DSS2F7N3I@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:47:10 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When we fail to assign an I/O or MEM resource, include the min/max
in the debug output to help match it with the options.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/manager.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/manager.c b/drivers/pnp/manager.c
index e758dd2..c706dd2 100644
--- a/drivers/pnp/manager.c
+++ b/drivers/pnp/manager.c
@@ -47,7 +47,10 @@ static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 		res->start += rule->align;
 		res->end = res->start + rule->size - 1;
 		if (res->start > rule->max || !rule->align) {
-			dev_dbg(&dev->dev, "  couldn't assign io %d\n", idx);
+			dev_dbg(&dev->dev, "  couldn't assign io %d "
+				"(min %#llx max %#llx)\n", idx,
+				(unsigned long long) rule->min,
+				(unsigned long long) rule->max);
 			return 0;
 		}
 	}
@@ -96,7 +99,10 @@ static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 		res->start += rule->align;
 		res->end = res->start + rule->size - 1;
 		if (res->start > rule->max || !rule->align) {
-			dev_dbg(&dev->dev, "  couldn't assign mem %d\n", idx);
+			dev_dbg(&dev->dev, "  couldn't assign mem %d "
+				"(min %#llx max %#llx)\n", idx,
+				(unsigned long long) rule->min,
+				(unsigned long long) rule->max);
 			return 0;
 		}
 	}
-- 
1.5.6.1.89.gd544

