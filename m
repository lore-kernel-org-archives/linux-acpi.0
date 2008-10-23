From: Len Brown <lenb@kernel.org>
Subject: [PATCH 035/122] PNP: use new vsprintf symbolic function pointer format
Date: Thu, 23 Oct 2008 02:38:09 -0400
Message-ID: <668b21de141edcba3fb13a4f810641eea4740fd7.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51251 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbYJWGj4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006NJIIJ32T1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:56 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Use the '%pF' format to get rid of an "#ifdef DEBUG".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/quirks.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index 0bdf9b8..414bb09 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -337,10 +337,8 @@ void pnp_fixup_device(struct pnp_dev *dev)
 	for (f = pnp_fixups; *f->id; f++) {
 		if (!compare_pnp_id(dev->id, f->id))
 			continue;
-#ifdef DEBUG
-		dev_dbg(&dev->dev, "%s: calling ", f->id);
-		print_fn_descriptor_symbol("%s\n", f->quirk_function);
-#endif
+		dev_dbg(&dev->dev, "%s: calling %pF\n", f->id,
+			f->quirk_function);
 		f->quirk_function(dev);
 	}
 }
-- 
1.5.5.1

