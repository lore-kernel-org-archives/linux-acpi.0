From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/84] ACPICA: Fix mutex debug code for wrong loop termination
 value
Date: Sat, 28 Jun 2008 01:43:50 -0400
Message-ID: <e80894d988fdd8e896f5df8f1b706aa12ed3c45b.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:50759 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYF1FpS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:18 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BI9RZEAD12@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:15 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
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
1.5.6.1.89.gd544

