From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/17] ACPICA: Fix mutex debug code for wrong loop termination
 value
Date: Thu, 12 Jun 2008 00:35:15 -0400
Message-ID: <84daa24ff4a917f92792212617ad5bc76359e1b9.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36493 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYFLEfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:25 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C00LKV22Z2AG0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:35:24 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Loop was terminating one iteration early, missing one of the
debugger handshake mutexes. Linn Crosetto.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utmutex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utilities/utmutex.c b/drivers/acpi/utilities/utmutex.c
index f7d602b..7331dde 100644
--- a/drivers/acpi/utilities/utmutex.c
+++ b/drivers/acpi/utilities/utmutex.c
@@ -218,7 +218,7 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 		 * the mutex ordering rule.  This indicates a coding error somewhere in
 		 * the ACPI subsystem code.
 		 */
-		for (i = mutex_id; i < ACPI_MAX_MUTEX; i++) {
+		for (i = mutex_id; i < ACPI_NUM_MUTEX; i++) {
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					ACPI_ERROR((AE_INFO,
@@ -315,7 +315,7 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 		 * ordering rule.  This indicates a coding error somewhere in
 		 * the ACPI subsystem code.
 		 */
-		for (i = mutex_id; i < ACPI_MAX_MUTEX; i++) {
+		for (i = mutex_id; i < ACPI_NUM_MUTEX; i++) {
 			if (acpi_gbl_mutex_info[i].thread_id == this_thread_id) {
 				if (i == mutex_id) {
 					continue;
-- 
1.5.6.rc2.26.g8c37

