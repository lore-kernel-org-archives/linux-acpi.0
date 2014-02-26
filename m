From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/18] ACPICA: Add text: ACPICA policy for new _OSI strings. No functional change.
Date: Wed, 26 Feb 2014 10:33:18 +0800
Message-ID: <cb13c61766bfcece32b82dbb7081135050e2f31e.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaBZCd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:33:29 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Adds further information about why new _OSI strings should be
adopted by all hosts as soon as possible.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utosi.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 1e5525e..685766f 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -47,6 +47,31 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utosi")
 
+/******************************************************************************
+ *
+ * ACPICA policy for new _OSI strings:
+ *
+ * It is the stated policy of ACPICA that new _OSI strings will be integrated
+ * into this module as soon as possible after they are defined. It is strongly
+ * recommended that all ACPICA hosts mirror this policy and integrate any
+ * changes to this module as soon as possible. There are several historical
+ * reasons behind this policy:
+ *
+ * 1) New BIOSs tend to test only the case where the host responds TRUE to
+ *    the latest version of Windows, which would respond to the latest/newest
+ *    _OSI string. Not responding TRUE to the latest version of Windows will
+ *    risk executing untested code paths throughout the DSDT and SSDTs.
+ *
+ * 2) If a new _OSI string is recognized only after a significant delay, this
+ *    has the potential to cause problems on existing working machines because
+ *    of the possibility that a new and different path through the ASL code
+ *    will be executed.
+ *
+ * 3) New _OSI strings are tending to come out about once per year. A delay
+ *    in recognizing a new string for a significant amount of time risks the
+ *    release of another string which only compounds the initial problem.
+ *
+ *****************************************************************************/
 /*
  * Strings supported by the _OSI predefined control method (which is
  * implemented internally within this module.)
-- 
1.7.10

