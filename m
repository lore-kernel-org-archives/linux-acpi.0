From: Len Brown <lenb@kernel.org>
Subject: [PATCH 066/122] ACPI suspend: Fix CONFIG_ACPI_SLEEP dependence and
 some compilation warnings
Date: Thu, 23 Oct 2008 02:38:40 -0400
Message-ID: <5d1e072b6b9cffebefa681faca1c6d608310d4b2.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62933 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbYJWGkT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KJ5IIUZDY2@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:07 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Initially CONFIG_PM_SLEEP was defined as
CONFIG_SUSPEND || CONFIG_HIBERNATION and some ACPI code, most
importantly the code in drivers/acpi/main.c, was written with this
assumption.  Currently, however, CONFIG_PM_SLEEP is also set when
CONFIG_XEN_SAVE_RESTORE is set.

This causes some compilation warnings to appear in
drivers/acpi/main.c if both CONFIG_SUSPEND and CONFIG_HIBERNATION
are unset and CONFIG_PM_SLEEP is set (this was impossible before).
To fix this problem, redefine CONFIG_ACPI_SLEEP do depend directly
on CONFIG_SUSPEND || CONFIG_HIBERNATION, as originally intended, and
use it instead of CONFIG_PM_SLEEP in drivers/acpi/main.c, wherever
appropriate.

Additionally, move the acpi_target_sleep_state definition from under
the #ifdef to prevent compilation from failing in some cases.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig      |    2 +-
 drivers/acpi/sleep/main.c |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 79540db..325b4b5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -42,7 +42,7 @@ if ACPI
 
 config ACPI_SLEEP
 	bool
-	depends on PM_SLEEP
+	depends on SUSPEND || HIBERNATION
 	default y
 
 config ACPI_PROCFS
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index d13194a..4c21480 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -23,6 +23,7 @@
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 static int acpi_sleep_prepare(u32 acpi_state)
 {
@@ -45,9 +46,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-
+#ifdef CONFIG_ACPI_SLEEP
 /*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
  * user to request that behavior by using the 'acpi_old_suspend_ordering'
@@ -132,7 +131,7 @@ static void acpi_pm_end(void)
 	 */
 	acpi_target_sleep_state = ACPI_STATE_S0;
 }
-#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
 extern void do_suspend_lowlevel(void);
-- 
1.5.5.1

