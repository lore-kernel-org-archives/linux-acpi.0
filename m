From: Len Brown <lenb@kernel.org>
Subject: [PATCH 051/103] dell-laptop: Fix rfkill state queries
Date: Wed, 16 Dec 2009 03:36:02 -0500
Message-ID: <e1fbf346c7c56d6b2f9d835d297bcb088baaff3a.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761871AbZLPJGI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:08 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

The current code in dell-laptop is confused about the hardware rfkill
state. Fix it up such that it's always reported correctly.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Tested-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 74909c4..9061111 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -197,8 +197,8 @@ static void dell_rfkill_query(struct rfkill *rfkill, void *data)
 	dell_send_request(&buffer, 17, 11);
 	status = buffer.output[1];
 
-	if (status & BIT(bit))
-		rfkill_set_hw_state(rfkill, !!(status & BIT(16)));
+	rfkill_set_sw_state(rfkill, !!(status & BIT(bit)));
+	rfkill_set_hw_state(rfkill, !(status & BIT(16)));
 }
 
 static const struct rfkill_ops dell_rfkill_ops = {
-- 
1.6.0.6

