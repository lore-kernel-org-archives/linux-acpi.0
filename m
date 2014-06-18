From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/9] ACPICA: Events: Reduce divergences to honor notify handler enabled GPEs.
Date: Wed, 18 Jun 2014 11:17:49 +0800
Message-ID: <3b7093cd4e187a72185a86acd28d01586bd8523c.1403060601.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1403060601.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The back port result of a divergence fix that the origianlly_enabled check
is not paired between acpi_install_gpe_handler() and
acpi_remove_gpe_handler(). Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxface.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index fc075a5..e090dd1 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -794,11 +794,19 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	 * automatically during initialization, in which case it has to be
 	 * disabled now to avoid spurious execution of the handler.
 	 */
-
-	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && gpe_event_info->runtime_count) {
-		handler->originally_enabled = 1;
+	if (((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
+	     (handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
+	    gpe_event_info->runtime_count) {
+		handler->originally_enabled = TRUE;
 		(void)acpi_ev_remove_gpe_reference(gpe_event_info);
+
+		/* Sanity check of original type against new type */
+
+		if (type !=
+		    (u32)(gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK)) {
+			ACPI_WARNING((AE_INFO,
+				      "GPE type mismatch (level/edge)"));
+		}
 	}
 
 	/* Install the handler */
@@ -903,7 +911,8 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
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
