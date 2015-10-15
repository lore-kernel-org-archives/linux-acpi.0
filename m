From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/13] ACPICA: Debugger: Update mutexes used for multithreaded debugger
Date: Thu, 15 Oct 2015 10:08:06 +0800
Message-ID: <3813385f9e120f9348fccdac68b2bf3fe56a14d2.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6b2701f619040e803313363f516b200e362a9100

Make these mutex objects independent of the deadlock detection mechanism.
This mechanism caused failures with the multithread debugger.

This patch doesn't affect Linux kernel as debugger is currently not fully
functioning in the Linux kernel. And the further debugger cleanups will
take care of handling debugger command signalling correctly instead of
using such kind of mutexes. So it is safe to leave this patch as it is.

Link: https://github.com/acpica/acpica/commit/6b2701f6
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    3 +++
 drivers/acpi/acpica/aclocal.h  |    4 +---
 drivers/acpi/acpica/utdecode.c |    2 --
 drivers/acpi/acpica/utmutex.c  |   21 +++++++++++++++++++++
 include/acpi/platform/acenv.h  |    6 +++---
 5 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 09f37b5..593de41 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -357,6 +357,9 @@ ACPI_GLOBAL(u16, acpi_gbl_node_type_count_misc);
 ACPI_GLOBAL(u32, acpi_gbl_num_nodes);
 ACPI_GLOBAL(u32, acpi_gbl_num_objects);
 
+ACPI_GLOBAL(acpi_mutex, acpi_gbl_db_command_ready);
+ACPI_GLOBAL(acpi_mutex, acpi_gbl_db_command_complete);
+
 #endif				/* ACPI_DEBUGGER */
 
 /*****************************************************************************
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 8a66fef..918f70d 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -83,10 +83,8 @@ union acpi_parse_object;
 #define ACPI_MTX_EVENTS                 3	/* Data for ACPI events */
 #define ACPI_MTX_CACHES                 4	/* Internal caches, general purposes */
 #define ACPI_MTX_MEMORY                 5	/* Debug memory tracking lists */
-#define ACPI_MTX_DEBUG_CMD_COMPLETE     6	/* AML debugger */
-#define ACPI_MTX_DEBUG_CMD_READY        7	/* AML debugger */
 
-#define ACPI_MAX_MUTEX                  7
+#define ACPI_MAX_MUTEX                  5
 #define ACPI_NUM_MUTEX                  ACPI_MAX_MUTEX+1
 
 /* Lock structure for reader/writer interfaces */
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 988e23b..d452a78 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -407,8 +407,6 @@ static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Events",
 	"ACPI_MTX_Caches",
 	"ACPI_MTX_Memory",
-	"ACPI_MTX_CommandComplete",
-	"ACPI_MTX_CommandReady"
 };
 
 char *acpi_ut_get_mutex_name(u32 mutex_id)
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 37b8b58..ce406e3 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -108,6 +108,21 @@ acpi_status acpi_ut_mutex_initialize(void)
 	/* Create the reader/writer lock for namespace access */
 
 	status = acpi_ut_create_rw_lock(&acpi_gbl_namespace_rw_lock);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+#ifdef ACPI_DEBUGGER
+
+	/* Debugger Support */
+
+	status = acpi_os_create_mutex(&acpi_gbl_db_command_ready);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_os_create_mutex(&acpi_gbl_db_command_complete);
+#endif
+
 	return_ACPI_STATUS(status);
 }
 
@@ -147,6 +162,12 @@ void acpi_ut_mutex_terminate(void)
 	/* Delete the reader/writer lock */
 
 	acpi_ut_delete_rw_lock(&acpi_gbl_namespace_rw_lock);
+
+#ifdef ACPI_DEBUGGER
+	acpi_os_delete_mutex(acpi_gbl_db_command_ready);
+	acpi_os_delete_mutex(acpi_gbl_db_command_complete);
+#endif
+
 	return_VOID;
 }
 
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 15ef08c..056f245 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -304,11 +304,11 @@
  * multi-threaded if ACPI_APPLICATION is not set.
  */
 #ifndef DEBUGGER_THREADING
-#ifdef ACPI_APPLICATION
-#define DEBUGGER_THREADING          DEBUGGER_SINGLE_THREADED
+#if !defined (ACPI_APPLICATION) || defined (ACPI_EXEC_APP)
+#define DEBUGGER_THREADING          DEBUGGER_MULTI_THREADED
 
 #else
-#define DEBUGGER_THREADING          DEBUGGER_MULTI_THREADED
+#define DEBUGGER_THREADING          DEBUGGER_SINGLE_THREADED
 #endif
 #endif				/* !DEBUGGER_THREADING */
 
-- 
1.7.10
