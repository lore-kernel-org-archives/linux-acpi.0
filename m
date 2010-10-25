From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/60] ACPI: static sleep_states[] and acpi_gts_bfs_check
Date: Mon, 25 Oct 2010 02:20:46 -0400
Message-ID: <01eac60bccdb0ce49a2937d59da1e4749697a9aa.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0JYHLH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:07 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:06 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, Len Brown <len.brown@intel.com>

From: Stephen Hemminger <shemminger@vyatta.com>

Only used in one file so should be static.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    4 ++--
 drivers/acpi/sleep.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4754ff6..b9af2c2 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -25,7 +25,7 @@
 #include "internal.h"
 #include "sleep.h"
 
-u8 sleep_states[ACPI_S_STATE_COUNT];
+static u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
@@ -702,7 +702,7 @@ static void acpi_power_off(void)
  * paths through the BIOS, so disable _GTS and _BFS by default,
  * but do speak up and offer the option to enable them.
  */
-void __init acpi_gts_bfs_check(void)
+static void __init acpi_gts_bfs_check(void)
 {
 	acpi_handle dummy;
 
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index d882180..74d59c8 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -1,5 +1,4 @@
 
-extern u8 sleep_states[];
 extern int acpi_suspend(u32 state);
 
 extern void acpi_enable_wakeup_devices(u8 sleep_state);
-- 
1.7.3.2.90.gd4c43

