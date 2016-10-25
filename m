From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 1/6] ACPICA: Dispatcher: Fix order issue of method termination
Date: Tue, 25 Oct 2016 13:21:09 +0800
Message-ID: <0114a27d924164974733acd655c1f433d4ede4fe.1477372449.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35090 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbcJYFWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2016 01:22:00 -0400
In-Reply-To: <cover.1477372449.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The last step of the method termination should be the end of the method
serialization. Otherwise, the steps happening after it will face the race
issues that cannot be protected by the method serialization mechanism.

This patch fixes this issue by moving the per-method-object deletion code
prior than the end of the method serialization. Otherwise, the possible
race issues may result in AE_ALREADY_EXISTS error in a parallel
environment.

Reported-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 32e9ddc..c4028a8 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -731,26 +731,6 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		acpi_ds_method_data_delete_all(walk_state);
 
 		/*
-		 * If method is serialized, release the mutex and restore the
-		 * current sync level for this thread
-		 */
-		if (method_desc->method.mutex) {
-
-			/* Acquisition Depth handles recursive calls */
-
-			method_desc->method.mutex->mutex.acquisition_depth--;
-			if (!method_desc->method.mutex->mutex.acquisition_depth) {
-				walk_state->thread->current_sync_level =
-				    method_desc->method.mutex->mutex.
-				    original_sync_level;
-
-				acpi_os_release_mutex(method_desc->method.
-						      mutex->mutex.os_mutex);
-				method_desc->method.mutex->mutex.thread_id = 0;
-			}
-		}
-
-		/*
 		 * Delete any namespace objects created anywhere within the
 		 * namespace by the execution of this method. Unless:
 		 * 1) This method is a module-level executable code method, in which
@@ -786,6 +766,26 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 				    ~ACPI_METHOD_MODIFIED_NAMESPACE;
 			}
 		}
+
+		/*
+		 * If method is serialized, release the mutex and restore the
+		 * current sync level for this thread
+		 */
+		if (method_desc->method.mutex) {
+
+			/* Acquisition Depth handles recursive calls */
+
+			method_desc->method.mutex->mutex.acquisition_depth--;
+			if (!method_desc->method.mutex->mutex.acquisition_depth) {
+				walk_state->thread->current_sync_level =
+				    method_desc->method.mutex->mutex.
+				    original_sync_level;
+
+				acpi_os_release_mutex(method_desc->method.
+						      mutex->mutex.os_mutex);
+				method_desc->method.mutex->mutex.thread_id = 0;
+			}
+		}
 	}
 
 	/* Decrement the thread count on the method */
-- 
2.7.4

