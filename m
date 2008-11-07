From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/21] ACPI: fix de-reference bug in power resource driver
Date: Thu, 06 Nov 2008 23:39:08 -0500
Message-ID: <b1b57fbe9bb10d94682a975456de7a727d1dbc84.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59226 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYKGEj3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y00DKR4XST8T1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:29 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

change state to *state in the function of acpi_power_get_state()

Signed-off-by: yakui.zhao@intel.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index a1718e5..30d4a52 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -153,7 +153,8 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  acpi_ut_get_node_name(handle), state ? "on" : "off"));
+			  acpi_ut_get_node_name(handle),
+				*state ? "on" : "off"));
 
 	return 0;
 }
-- 
1.5.6.5

