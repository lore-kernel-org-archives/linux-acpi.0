From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/10] ACPICA: Events: Reduce source code difference in acpi_install_gpe_handler().
Date: Fri, 10 Oct 2014 10:39:45 +0800
Message-ID: <4832e98fb5408c18fcee694a94e41c9044665703.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7929 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJJCjs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:39:48 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

There is a sanity check in ACPICA upstream, complaining mis-matched
interrupt type for originally enabled GPEs that are going to be dispatched
by OSPM handlers. This is only a warning message noting developers such
conflict between BIOS and OSPM. This patch ports this warning message from
ACPICA upstream to reduce source code difference between Linux and ACPICA
upstream.

This patch is required before applying a follow-up linuxized event patch in
20140926 release. It also contains one line divergence reduction to make
the follow-up change simpler and easier to be maintained.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxface.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 935fd76..79b6ed2 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -795,8 +795,16 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	 */
 	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
 	    && gpe_event_info->runtime_count) {
-		handler->originally_enabled = 1;
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
-- 
1.7.10

