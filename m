From: Len Brown <lenb@kernel.org>
Subject: [PATCH 72/84] PNP: in debug resource dump, make empty list obvious
Date: Sat, 28 Jun 2008 01:44:16 -0400
Message-ID: <27139106aa3c5f297532d13af9f52cbc4b40daa9.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:51174 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbYF1FrM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:47:12 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001JXS2I7OUH@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:47:12 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

If the resource list is empty, say that explicitly.  Previously,
it was confusing because often the heading was followed by zero
resource lines, then some "add resource" lines from auto-assignment,
so the "add" lines looked like current resources.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/support.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index 1566e4a..0ad42db 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -79,7 +79,12 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 	struct pnp_resource *pnp_res;
 	struct resource *res;
 
-	dev_dbg(&dev->dev, "current resources: %s\n", desc);
+	if (list_empty(&dev->resources)) {
+		dev_dbg(&dev->dev, "%s: no current resources\n", desc);
+		return;
+	}
+
+	dev_dbg(&dev->dev, "%s: current resources:\n", desc);
 	list_for_each_entry(pnp_res, &dev->resources, list) {
 		res = &pnp_res->res;
 
-- 
1.5.6.1.89.gd544

