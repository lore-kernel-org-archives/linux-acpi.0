From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: Update some function headers, no funtional change
Date: Wed, 26 Apr 2017 16:17:50 +0800
Message-ID: <a046aec635802e547a1308a055c39c6d3595ce38.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35194 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1950267AbdDZIRy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:17:54 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 57c1b2d3e2f9ff7f465b0f08bfb38294101fe0b3

utxferror, update function headers.

Link: https://github.com/acpica/acpica/commit/57c1b2d3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxferror.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index a16bd9e..950a1e5 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -91,7 +91,7 @@ ACPI_EXPORT_SYMBOL(acpi_error)
  *
  * PARAMETERS:  module_name         - Caller's module name (for error output)
  *              line_number         - Caller's line number (for error output)
- *              status              - Status to be formatted
+ *              status              - Status value to be decoded/formatted
  *              format              - Printf format string + additional args
  *
  * RETURN:      None
@@ -132,8 +132,8 @@ ACPI_EXPORT_SYMBOL(acpi_exception)
  *
  * FUNCTION:    acpi_warning
  *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
+ * PARAMETERS:  module_name         - Caller's module name (for warning output)
+ *              line_number         - Caller's line number (for warning output)
  *              format              - Printf format string + additional args
  *
  * RETURN:      None
@@ -163,17 +163,13 @@ ACPI_EXPORT_SYMBOL(acpi_warning)
  *
  * FUNCTION:    acpi_info
  *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              format              - Printf format string + additional args
+ * PARAMETERS:  format              - Printf format string + additional args
  *
  * RETURN:      None
  *
  * DESCRIPTION: Print generic "ACPI:" information message. There is no
  *              module/line/version info in order to keep the message simple.
  *
- * TBD: module_name and line_number args are not needed, should be removed.
- *
  ******************************************************************************/
 void ACPI_INTERNAL_VAR_XFACE acpi_info(const char *format, ...)
 {
@@ -229,8 +225,8 @@ ACPI_EXPORT_SYMBOL(acpi_bios_error)
  *
  * FUNCTION:    acpi_bios_warning
  *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
+ * PARAMETERS:  module_name         - Caller's module name (for warning output)
+ *              line_number         - Caller's line number (for warning output)
  *              format              - Printf format string + additional args
  *
  * RETURN:      None
-- 
2.7.4

