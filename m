From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/30] ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue
Date: Thu,  4 Aug 2016 16:44:59 +0800
Message-ID: <16ff40db65bc227fae5cb6c011d6422092052630.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26949 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757439AbcHDIpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:16 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 9bb265c2afb9910e46f820d6759648580edabd09

When /Za is specified, headers of some Windows SDKs contain bugs breaking
VC builds, and MSVC9's default SDK is one of such header-buggy library.

In order to solve this issue, many VC developers stop using /Za. However
we've been asked to have this fixed without removing /Za.

In MSVC9 default SDK, this issue can be fixed by restricting <sys/stat.h>
to be the last standard file included by every source file in the projects.
This patch thus moves <sys/stat.h> inclusion to "acapps.h", so that this
issue can be fixed by ensuring that "acapps.h" is always the last standard
file included by all of the ACPICA source files. This is in fact also a
useful cleanup because applications can only include one header (e.x.,
acpidump.h) instead of including acapps.h separately. Lv Zheng.

Except some harmless header inclusion re-ordering, Linux kernel is not
affected by this change.

Link: https://github.com/acpica/acpica/commit/9bb265c2
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acapps.h               |    4 ++++
 include/acpi/platform/acenv.h              |    3 ++-
 tools/power/acpi/tools/acpidump/acpidump.h |    1 +
 tools/power/acpi/tools/acpidump/apfiles.c  |    1 -
 tools/power/acpi/tools/acpidump/apmain.c   |    1 -
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index 247f30c..bc38534 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -44,6 +44,10 @@
 #ifndef _ACAPPS
 #define _ACAPPS
 
+#ifdef ACPI_USE_STANDARD_HEADERS
+#include <sys/stat.h>
+#endif				/* ACPI_USE_STANDARD_HEADERS */
+
 /* Common info for tool signons */
 
 #define ACPICA_NAME                 "Intel ACPI Component Architecture"
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 1e2fe95..3dbfa27 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -350,7 +350,8 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <sys/stat.h>
+#include <time.h>
+#include <signal.h>
 #endif
 
 #endif				/* ACPI_USE_STANDARD_HEADERS */
diff --git a/tools/power/acpi/tools/acpidump/acpidump.h b/tools/power/acpi/tools/acpidump/acpidump.h
index 9f7db00..00423fc 100644
--- a/tools/power/acpi/tools/acpidump/acpidump.h
+++ b/tools/power/acpi/tools/acpidump/acpidump.h
@@ -55,6 +55,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
+#include "acapps.h"
 
 /* Globals */
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index c527521..44a0010 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -42,7 +42,6 @@
  */
 
 #include "acpidump.h"
-#include "acapps.h"
 
 /* Local prototypes */
 
diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index cd6c097..17ce0d7 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -43,7 +43,6 @@
 
 #define _DECLARE_GLOBALS
 #include "acpidump.h"
-#include "acapps.h"
 
 /*
  * acpidump - A portable utility for obtaining system ACPI tables and dumping
-- 
1.7.10

