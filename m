From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/20] ACPICA: Add EXPORT_ACPI_INTERFACES macro to external interface modules.
Date: Tue, 29 Oct 2013 09:29:51 +0800
Message-ID: <09a493dbdcdc523343e449cd12fbe574c657fd7c.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13216 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2BaA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:00 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

For Linux, there is no functional changes /binary generation differences
introduced by this patch.

This change adds this new macro to all files that contain external ACPICA
interfaces. It can be detected and used by the host (via the host-specific
header) for any special processing required for such modules. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxface.c   |    3 ++-
 drivers/acpi/acpica/evxfevnt.c  |    3 ++-
 drivers/acpi/acpica/evxfgpe.c   |    3 ++-
 drivers/acpi/acpica/evxfregn.c  |    3 ++-
 drivers/acpi/acpica/hwtimer.c   |    3 ++-
 drivers/acpi/acpica/hwxface.c   |    3 ++-
 drivers/acpi/acpica/hwxfsleep.c |    3 ++-
 drivers/acpi/acpica/nsxfeval.c  |    3 ++-
 drivers/acpi/acpica/nsxfname.c  |    3 ++-
 drivers/acpi/acpica/nsxfobj.c   |    3 ++-
 drivers/acpi/acpica/rsxface.c   |    3 ++-
 drivers/acpi/acpica/tbxface.c   |    3 ++-
 drivers/acpi/acpica/tbxfload.c  |    3 ++-
 drivers/acpi/acpica/utdebug.c   |    3 ++-
 drivers/acpi/acpica/utdecode.c  |    1 -
 drivers/acpi/acpica/utexcep.c   |    3 ++-
 drivers/acpi/acpica/utglobal.c  |    2 +-
 drivers/acpi/acpica/utxface.c   |    3 ++-
 drivers/acpi/acpica/utxferror.c |    3 ++-
 drivers/acpi/acpica/utxfinit.c  |    3 ++-
 include/acpi/platform/aclinux.h |   12 ++++++++----
 21 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 6f56146..6d88b13 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 7039606..39d06af 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 7662f1a..fab40d9 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acevents.h"
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 80cecf8..1bd3225 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -42,7 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index 2d7d22e..3c498dc 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index d3682c2..b156848 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index f2e669d..4895fca 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 481a6b4..a6e3bca 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -42,7 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 83c1644..3a6d78a 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -42,7 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index c0853ef..94e961c 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -42,7 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 94e3517..01e4769 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acresrc.h"
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index ad11162..2ad8532 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 0ba9e32..2620dbe 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index ffd0db5..1a67b39 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 11e2e02..b3f31dd 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -41,7 +41,6 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index ff6d9e8..3cf7b59 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -41,8 +41,9 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#define EXPORT_ACPI_INTERFACES
+
 #define ACPI_DEFINE_EXCEPTION_TABLE
-#include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 046d5b0..4f59784 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -41,9 +41,9 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#define EXPORT_ACPI_INTERFACES
 #define DEFINE_ACPI_GLOBALS
 
-#include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 03a211e..2178da8 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acdebug.h"
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index e966a2e..f7edb88 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 41ebaaf..dda18e6 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -41,7 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/export.h>
+#define EXPORT_ACPI_INTERFACES
+
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acevents.h"
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 7346a92..0e6e73c 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -74,7 +74,7 @@
 #define acpi_spinlock                       spinlock_t *
 #define acpi_cpu_flags                      unsigned long
 
-#else /* !__KERNEL__ */
+#else				/* !__KERNEL__ */
 
 #include <stdarg.h>
 #include <string.h>
@@ -102,7 +102,7 @@
 #define __cdecl
 #endif
 
-#endif /* __KERNEL__ */
+#endif				/* __KERNEL__ */
 
 /* Linux uses GCC */
 
@@ -183,6 +183,10 @@ static inline void acpi_os_free(void *a)
 	lock ? AE_OK : AE_NO_MEMORY;				\
 })
 
-#endif /* __KERNEL__ */
+#ifdef EXPORT_ACPI_INTERFACES
+#include <linux/export.h>
+#endif
+
+#endif				/* __KERNEL__ */
 
-#endif /* __ACLINUX_H__ */
+#endif				/* __ACLINUX_H__ */
-- 
1.7.10

