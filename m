From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/18] ACPICA: Update for GCC 4
Date: Sun, 11 Dec 2011 12:45:32 -0500
Message-ID: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:35412 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab1LKRqF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 12:46:05 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW100JOEW0KO3U5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 11:46:02 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes several issues with GCC 4.6 related to the new checks for
unused variables.

http://www.acpica.org/bugzilla/show_bug.cgi?id=935

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utmutex.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 7d797e2..302c74e 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -293,14 +293,10 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 
 acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 {
-	acpi_thread_id this_thread_id;
-
 	ACPI_FUNCTION_NAME(ut_release_mutex);
 
-	this_thread_id = acpi_os_get_thread_id();
-
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Thread %u releasing Mutex [%s]\n",
-			  (u32)this_thread_id,
+			  (u32)acpi_os_get_thread_id(),
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
@@ -329,7 +325,8 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 		 * the ACPI subsystem code.
 		 */
 		for (i = mutex_id; i < ACPI_NUM_MUTEX; i++) {
-			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
+			if (acpi_gbl_mutex_info[i].thread_id ==
+			    acpi_os_get_thread_id()) {
 				if (i == mutex_id) {
 					continue;
 				}
-- 
1.7.7.rc0.72.g4b5ea

