From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/23] ACPI: Disable Fixed_RTC event when installing RTC handler
Date: Wed, 11 Jun 2008 03:59:04 -0400
Message-ID: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:57809 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYFKH7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A00KVWGV30N8B@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:28 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The Fixed_RTC event should be disabled when installing RTC handler.
Only when RTC alarm is set will it be enabled again. If it is not
disabled, maybe some machines will be powered on automatically after
the system is shutdown even when the RTC alarm is not set.

http://bugzilla.kernel.org/show_bug.cgi?id=10010

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c       |    6 ++++++
 drivers/acpi/sleep/proc.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 06f8634..2808dc6 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -272,6 +272,12 @@ static u32 rtc_handler(void *context)
 static inline void rtc_wake_setup(void)
 {
 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+	/*
+	 * After the RTC handler is installed, the Fixed_RTC event should
+	 * be disabled. Only when the RTC alarm is set will it be enabled.
+	 */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
 }
 
 static void rtc_wake_on(struct device *dev)
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 8a5fe87..224c57c 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -495,6 +495,12 @@ static int __init acpi_sleep_proc_init(void)
 		    acpi_root_dir, &acpi_system_alarm_fops);
 
 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+	/*
+	 * Disable the RTC event after installing RTC handler.
+	 * Only when RTC alarm is set will it be enabled.
+	 */
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 
 	/* 'wakeup device' [R/W] */
-- 
1.5.6.rc2.23.gea81e

