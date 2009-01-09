From: Len Brown <lenb@kernel.org>
Subject: [PATCH 65/94] ACPI: wakeup.c: remove ACPI_FUNCTION_TRACE
Date: Fri, 09 Jan 2009 04:27:07 -0500
Message-ID: <c1e3523ccbeca312e11557d2a75f90632a2fb5c7.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbZAIJ23 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004396BA39ID@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:23 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

ACPI_FUNCTION_TRACE is an internal acpica function.
remove ACPI_FUNCTION_TRACE

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/wakeup.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
index dea4c23..db325c2 100644
--- a/drivers/acpi/sleep/wakeup.c
+++ b/drivers/acpi/sleep/wakeup.c
@@ -28,8 +28,6 @@ void acpi_enable_wakeup_device_prep(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
-	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev = container_of(node,
@@ -61,7 +59,6 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 	 * Caution: this routine must be invoked when interrupt is disabled 
 	 * Refer ACPI2.0: P212
 	 */
-	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
@@ -103,8 +100,6 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 {
 	struct list_head *node, *next;
 
-	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device");
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
-- 
1.5.6.6

