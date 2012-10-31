From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/26] ACPICA: Add debug print message for mutex objects that are force-released
Date: Wed, 31 Oct 2012 10:27:24 +0800
Message-ID: <60c53f9cd41f2681b6ae0ae9270c436a5d84e1af.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24067 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaC1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:30 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

At control method termination, any currently acquired mutex
objects are force-released. Add a new message for each one that
is released.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exmutex.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 4723974..d1f449d 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -461,7 +461,7 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 	union acpi_operand_object *next = thread->acquired_mutex_list;
 	union acpi_operand_object *obj_desc;
 
-	ACPI_FUNCTION_ENTRY();
+	ACPI_FUNCTION_NAME(ex_release_all_mutexes);
 
 	/* Traverse the list of owned mutexes, releasing each one */
 
@@ -473,6 +473,10 @@ void acpi_ex_release_all_mutexes(struct acpi_thread_state *thread)
 		obj_desc->mutex.next = NULL;
 		obj_desc->mutex.acquisition_depth = 0;
 
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Force-releasing held mutex: %p\n",
+				  obj_desc));
+
 		/* Release the mutex, special case for Global Lock */
 
 		if (obj_desc == acpi_gbl_global_lock_mutex) {
-- 
1.7.10

