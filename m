From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/9] ACPI suspend: build fix for ACPI_SLEEP=n &&
 XEN_SAVE_RESTORE=y.
Date: Sat, 25 Oct 2008 04:13:37 -0400
Message-ID: <92daa7b53b76984565dfdfda5d9c679884121fb2.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:55373 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbYJYINr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9A008QCC6WWHM4@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:45 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 26571ba..80c0868 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -163,6 +163,8 @@ static void acpi_pm_end(void)
 	acpi_target_sleep_state = ACPI_STATE_S0;
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
+#else /* !CONFIG_ACPI_SLEEP */
+#define acpi_target_sleep_state	ACPI_STATE_S0
 #endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
-- 
1.5.6.5

