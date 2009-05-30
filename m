From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/65] oqo: dev_set_name()
Date: Fri, 29 May 2009 21:42:15 -0400
Message-ID: <94c4b5977f33894cc316edf07c5cb72b5d193628.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60019 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbZE3Bmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:54 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF007L3ORJXDL0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:56 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
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

