From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] oqo: dev_set_name()
Date: Wed, 30 Dec 2009 19:14:33 -0500
Message-ID: <94c4b5977f33894cc316edf07c5cb72b5d193628.1262218269.git.len.brown@intel.com>
References: <1262218475-18104-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:65495 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZLaAOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 19:14:40 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH00JK9Q0FOAT8@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 18:14:39 -0600 (CST)
In-reply-to: <1262218475-18104-1-git-send-email-lenb@kernel.org>
In-reply-to: <9c82cd255907ad639bed4ffc8fcaf1bd59badb50.1262218269.git.len.brown@intel.com>
References: <9c82cd255907ad639bed4ffc8fcaf1bd59badb50.1262218269.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg@redhat.com, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/oqo-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/oqo-wmi.c b/drivers/platform/x86/oqo-wmi.c
index 940e605..0a88af8 100644
--- a/drivers/platform/x86/oqo-wmi.c
+++ b/drivers/platform/x86/oqo-wmi.c
@@ -592,7 +592,7 @@ static int __devinit oqo_kine_init(void)
 	    oqo_kine->absmax[ABS_Y] =
 	    oqo_kine->absmax[ABS_Z] = oqo_kine->absmax[ABS_MISC] = 32767;
 
-	memcpy(oqo_kine->dev.bus_id, "kine", 4);
+	dev_set_name(&oqo_kine->dev, "kine");
 
 	oqo_kine_polled = input_allocate_polled_device();
 	if (!oqo_kine_polled) {
-- 
1.6.0.6

