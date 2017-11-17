From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 12/15] ACPICA: Update mutex error messages, no functional change
Date: Fri, 17 Nov 2017 15:42:27 -0800
Message-ID: <20171117234230.913-13-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39440 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759944AbdKQXqo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:44 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 22f2b0beb45d277841ed02bc613df1009e5b20cf

Add mutex name on certain acquire/release errors.

Link: https://github.com/acpica/acpica/commit/22f2b0be
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utmutex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 586354788018..524ba931d5e8 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -286,8 +286,9 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %u could not acquire Mutex [0x%X]",
-				(u32)this_thread_id, mutex_id));
+				"Thread %u could not acquire Mutex [%s] (0x%X)",
+				(u32)this_thread_id,
+				acpi_ut_get_mutex_name(mutex_id), mutex_id));
 	}
 
 	return (status);
@@ -322,8 +323,8 @@ acpi_status acpi_ut_release_mutex(acpi_mutex_handle mutex_id)
 	 */
 	if (acpi_gbl_mutex_info[mutex_id].thread_id == ACPI_MUTEX_NOT_ACQUIRED) {
 		ACPI_ERROR((AE_INFO,
-			    "Mutex [0x%X] is not acquired, cannot release",
-			    mutex_id));
+			    "Mutex [%s] (0x%X) is not acquired, cannot release",
+			    acpi_ut_get_mutex_name(mutex_id), mutex_id));
 
 		return (AE_NOT_ACQUIRED);
 	}
-- 
2.13.6

