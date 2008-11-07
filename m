From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/21] intel_menlow: Add comment documenting legal GTHS values
Date: Thu, 06 Nov 2008 23:39:17 -0500
Message-ID: <d65dcdcf0cd55b4be1fd1f5025388e91042d63fc.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59259 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYKGEjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y009XW4XVQQ46@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:32 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Thomas, Sujith" <sujith.thomas@intel.com>, Len Brown <len.brown@intel.com>

From: Thomas, Sujith <sujith.thomas@intel.com>

Signed-off-by: Sujith Thomas <sujith.thomas@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/intel_menlow.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index 124b37d..27b7662 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -52,6 +52,11 @@ MODULE_LICENSE("GPL");
 #define MEMORY_ARG_CUR_BANDWIDTH 1
 #define MEMORY_ARG_MAX_BANDWIDTH 0
 
+/*
+ * GTHS returning 'n' would mean that [0,n-1] states are supported
+ * In that case max_cstate would be n-1
+ * GTHS returning '0' would mean that no bandwidth control states are supported
+ */
 static int memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
 					unsigned long *max_state)
 {
-- 
1.5.6.5

