From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPICA: Namespace: Fix lock order issue for namespace/interpreter
Date: Tue,  5 Jul 2016 13:53:12 +0800
Message-ID: <ab9f5511168df30d374e9e6426ae1cb81832f99f.1467697822.git.lv.zheng@intel.com>
References: <7ab2c9a68c936a6dadfdbf96dbdcfc924722c93a.1467697822.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ab2c9a68c936a6dadfdbf96dbdcfc924722c93a.1467697822.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There is a lock order issue in acpi_load_tables(). The namespace lock is held
before holding the interpreter lock.
With ACPI_MUTEX_DEBUG enabled in kernel, we can reproduce this during boot:
  [    0.885699] ACPI Error: Invalid acquire order: Thread 405884224 owns [ACPI_MTX_Namespace], wants [ACPI_MTX_Interpreter] (20160422/utmutex-263)
  [    0.885881] ACPI Error: Could not acquire AML Interpreter mutex (20160422/exutils-95)
  [    0.893846] ACPI Error: Mutex [0x0] is not acquired, cannot release (20160422/utmutex-326)
  [    0.894019] ACPI Error: Could not release AML Interpreter mutex (20160422/exutils-133)

The issue is introduced by the following commit:
  Commit: 2f38b1b16d9280689e5cfa47a4c50956bf437f0d
  ACPICA Commit: bfe03ffcde8ed56a7eae38ea0b188aeb12f9c52e
  Subject: ACPICA: Namespace: Fix a regression that MLC support triggers
           dead lock in dynamic table loading
Which fixes a dead lock issue for acpi_ns_load_table() in
acpi_ex_add_table() but doesn't take care of the lock order in
acpi_ns_load_table().

Originally (before applying the wrong fix), ACPICA uses the
namespace/interpreter locks in the following 2 key code paths:
1. Table loading (before applying 2f38b1b):
acpi_ns_load_table
	L(Namespace)
		acpi_ns_parse_table
			acpi_ns_one_complete_parse
	U(Namespace)
2. Object evaluation:
acpi_ns_evaluate
	L(Interpreter)
	acpi_ps_execute_method
		U(Interpreter)
		acpi_ns_load_table
			L(Namespace)
			U(Namespace)
		acpi_ev_initialize_region
			L(Namespace)
			U(Namespace)
		address_space.setup
			L(Namespace)
			U(Namespace)
		address_space.handler
			L(Namespace)
			U(Namespace)
		acpi_os_wait_semaphore
		acpi_os_acquire_mutex
		acpi_os_sleep
		L(Interpreter)
	U(Interpreter)
During runtime, while acpi_ns_evaluate is called, lock order is always
Interpreter -> Namespace.

While the wrong fix holds the lock in the following order:
3. Table loading (after applying 2f38b1b):
acpi_ns_load_table
	L(Namespace)
		acpi_ns_parse_table
		L(Interpreter)
			acpi_ns_one_complete_parse
		U(Interpreter)
	U(Namespace)

This patch further fixes the lock order issue by moving interpreter lock
to acpi_ns_load_table() to ensure the lock order correctness:
4. Table loading:
acpi_ns_load_table
	L(Interpreter)
	L(Namespace)
		acpi_ns_parse_table
			acpi_ns_one_complete_parse
	U(Namespace)
	U(Interpreter)

However, this fix is just a workaround which is compliant to the current
design but doesn't fix the current design issues related to the namespace
lock. For example, we can notice that in acpi_ns_evaluate(), outside of
acpi_ns_load_table(), the namespace objects may be created by the named
object creation control methods. And the creations of the method owned
namespace objects are not locked by the namespace lock. This patch doesn't
try to fix such kind of existing issues. Lv Zheng.

Fixes: 2f38b1b16d92 ("ACPICA: Namespace: Fix a regression that MLC support triggers dead lock in dynamic table loading")
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsload.c  |    7 ++++++-
 drivers/acpi/acpica/nsparse.c |    9 ++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index b5e2b0a..297f6aa 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -46,6 +46,7 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsload")
@@ -78,6 +79,8 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 
 	ACPI_FUNCTION_TRACE(ns_load_table);
 
+	acpi_ex_enter_interpreter();
+
 	/*
 	 * Parse the table and load the namespace with all named
 	 * objects found within. Control methods are NOT parsed
@@ -89,7 +92,7 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	 */
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto unlock_interp;
 	}
 
 	/* If table already loaded into namespace, just return */
@@ -130,6 +133,8 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 
 unlock:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+unlock_interp:
+	(void)acpi_ex_exit_interpreter();
 
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 1783cd7..f631a47 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -47,7 +47,6 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "actables.h"
-#include "acinterp.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsparse")
@@ -171,8 +170,6 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 
 	ACPI_FUNCTION_TRACE(ns_parse_table);
 
-	acpi_ex_enter_interpreter();
-
 	/*
 	 * AML Parse, pass 1
 	 *
@@ -188,7 +185,7 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
 					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
-		goto error_exit;
+		return_ACPI_STATUS(status);
 	}
 
 	/*
@@ -204,10 +201,8 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
 					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
-		goto error_exit;
+		return_ACPI_STATUS(status);
 	}
 
-error_exit:
-	acpi_ex_exit_interpreter();
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10
