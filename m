From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/15] ACPI: eliminate unused variable warning for !ACPI_SLEEP
Date: Sat, 11 Dec 2010 02:06:39 -0500
Message-ID: <091aad6af4ab29af693ced5d6970ceee9d5981c8.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33724 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab0LKHww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:52:52 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900699780NVJ2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:52:51 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <JBeulich@novell.com>

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 721d93b..2182c55 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -27,8 +27,6 @@
 
 static u8 sleep_states[ACPI_S_STATE_COUNT];
 
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
-
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
 	union acpi_object in_arg = { ACPI_TYPE_INTEGER };
@@ -81,6 +79,8 @@ static int acpi_sleep_prepare(u32 acpi_state)
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
  * and to restore them during the subsequent resume.  Windows does that also for
-- 
1.7.3.3.480.g2f76a

