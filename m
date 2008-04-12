From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/73] ACPICA: Undo accidental checkin of not-fully-tested mutex changes
Date: Sat, 12 Apr 2008 00:25:27 -0400
Message-ID: <a19391863a8f5dcab9bd950a4a18330ba8cadabd.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15947 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754018AbYDLE2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:12 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exmutex.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index 7c70938..b8d035c 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -85,7 +85,6 @@ void acpi_ex_unlink_mutex(union acpi_operand_object *obj_desc)
 	} else {
 		thread->acquired_mutex_list = obj_desc->mutex.next;
 	}
-	return;
 }
 
 /*******************************************************************************
@@ -299,17 +298,6 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 		return (AE_NOT_ACQUIRED);
 	}
 
-	/* No obj_desc->Mutex.owner_thread for Global Lock */
-
-	/*
-	 * Mutex to be released must be at the head of acquired list to prevent
-	 * deadlock. (The head of the list is the last mutex acquired.)
-	 */
-	if (obj_desc->mutex.owner_thread &&
-	    (obj_desc != obj_desc->mutex.owner_thread->acquired_mutex_list)) {
-		return (AE_AML_MUTEX_ORDER);
-	}
-
 	/* Match multiple Acquires with multiple Releases */
 
 	obj_desc->mutex.acquisition_depth--;
@@ -415,9 +403,6 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	}
 
 	status = acpi_ex_release_mutex_object(obj_desc);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
 	if (obj_desc->mutex.acquisition_depth == 0) {
 
@@ -426,7 +411,6 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 		walk_state->thread->current_sync_level =
 		    obj_desc->mutex.original_sync_level;
 	}
-
 	return_ACPI_STATUS(status);
 }
 
-- 
1.5.5.29.g7134

