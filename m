From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/10] ACPICA: Events: Update GPE handler removal, match behavior of handler install.
Date: Fri, 10 Oct 2014 10:39:51 +0800
Message-ID: <7f15be1e81a8e07cf6a5ba1753776f51de498864.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52161 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaJJCpo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:45:44 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The originally_enabled check is not paired between
acpi_install_gpe_handler() and acpi_remove_gpe_handler().

In ACPICA upstream, there is code to protect original enabled state for
ACPI_GPE_DISPATCH_NOTIFY and this commit fixes an issue for this feature.
Since this ACPICA commit doesn't contain the code that is already in the
ACPICA upstream, the linuxized result has included such code to reduce the
source code differences between the Linux and ACPICA upstream. This also
allows us to revert this feature as a whole when we see regressions
triggered by this feature.

Link: https://github.com/acpica/acpica/commit/967f314c
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evxface.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 79b6ed2..55a58f3 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -793,8 +793,9 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	 * automatically during initialization, in which case it has to be
 	 * disabled now to avoid spurious execution of the handler.
 	 */
-	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && gpe_event_info->runtime_count) {
+	if (((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
+	     (handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
+	    gpe_event_info->runtime_count) {
 		handler->originally_enabled = TRUE;
 		(void)acpi_ev_remove_gpe_reference(gpe_event_info);
 
@@ -908,7 +909,8 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	 * enabled, it should be enabled at this point to restore the
 	 * post-initialization configuration.
 	 */
-	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) &&
+	if (((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
+	     (handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
 	    handler->originally_enabled) {
 		(void)acpi_ev_add_gpe_reference(gpe_event_info);
 	}
-- 
1.7.10

