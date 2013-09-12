From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/14] ACPICA: SCI Handlers: Update handler interface, eliminate unnecessary argument.
Date: Thu, 12 Sep 2013 16:55:45 +0800
Message-ID: <9599724a703dbe79b911db8fe5d22a91023d28ce.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1642 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab3ILI4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:56:08 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

The SCI interrupt number is not needed for the SCI handlers, and was
just unnecessary overhead.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evsci.c |    4 +---
 include/acpi/actypes.h      |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index b2f0fb2..94d9ebd 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -87,9 +87,7 @@ u32 acpi_ev_sci_dispatch(void)
 
 		/* Invoke the installed handler (at interrupt level) */
 
-		int_status |= sci_handler->address((u32)acpi_gbl_FADT.
-						   sci_interrupt,
-						   sci_handler->context);
+		int_status |= sci_handler->address(sci_handler->context);
 
 		sci_handler = sci_handler->next;
 	}
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 5400672..f6abf23 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -951,7 +951,7 @@ typedef void
  * Various handlers and callback procedures
  */
 typedef
-u32 (*acpi_sci_handler) (u32 interrupt_number, void *context);
+u32 (*acpi_sci_handler) (void *context);
 
 typedef
 void (*acpi_gbl_event_handler) (u32 event_type,
-- 
1.7.10

