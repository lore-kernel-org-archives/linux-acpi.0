From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/42] ACPICA: Fix SyncLevel support interaction with method auto-serialization
Date: Tue, 29 Dec 2015 13:53:57 +0800
Message-ID: <1ff2ab61afc190738c60815e45f1a8b205dcc477.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 253e3c03efc1a495d2aa61eee09ab1d0842a3dce

The control method auto-serialization can interfere with existing
ASL code that makes use of Mutex/Method SyncLevel support. This
change makes the auto-serialization transparent to the SyncLevel
support and management. David Box.

Link: https://github.com/acpica/acpica/commit/253e3c03
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index bc32f31..49ba082 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -411,8 +411,19 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 
 				obj_desc->method.mutex->mutex.thread_id =
 				    walk_state->thread->thread_id;
-				walk_state->thread->current_sync_level =
-				    obj_desc->method.sync_level;
+
+				/*
+				 * Update the current sync_level only if this is not an auto-
+				 * serialized method. In the auto case, we have to ignore
+				 * the sync level for the method mutex (created for the
+				 * auto-serialization) because we have no idea of what the
+				 * sync level should be. Therefore, just ignore it.
+				 */
+				if (!(obj_desc->method.info_flags &
+				      ACPI_METHOD_IGNORE_SYNC_LEVEL)) {
+					walk_state->thread->current_sync_level =
+					    obj_desc->method.sync_level;
+				}
 			} else {
 				obj_desc->method.mutex->mutex.
 				    original_sync_level =
-- 
1.7.10
