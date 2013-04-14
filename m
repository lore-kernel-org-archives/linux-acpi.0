From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: update comments for acpi_event_status
Date: Sun, 14 Apr 2013 22:31:37 +0800
Message-ID: <1365949897.2180.1.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab3DNObk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Apr 2013 10:31:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

>From 44504499041e944aae4ed577d9c99bdccf3d07c7 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Sun, 14 Apr 2013 22:25:07 +0800
Subject: [PATCH] ACPI: update comments for acpi_event_status

ACPI_EVENT_FLAG_HANDLE is a flag for acpi_event_status.
When it is set, it indicates that the ACPI event,
either GPE or fixed event, is associated with a handler.

Update the comments to reflect this flag.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/acpi/actypes.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 845e75f..de72f2b 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -650,13 +650,14 @@ typedef u32 acpi_event_type;
  * The encoding of acpi_event_status is illustrated below.
  * Note that a set bit (1) indicates the property is TRUE
  * (e.g. if bit 0 is set then the event is enabled).
- * +-------------+-+-+-+
- * |   Bits 31:3 |2|1|0|
- * +-------------+-+-+-+
- *          |     | | |
- *          |     | | +- Enabled?
- *          |     | +--- Enabled for wake?
- *          |     +----- Set?
+ * +-------------+-+-+-+-+
+ * |   Bits 31:4 |3|2|1|0|
+ * +-------------+-+-+-+-+
+ *          |     | | | |
+ *          |     | | | +- Enabled?
+ *          |     | | +--- Enabled for wake?
+ *          |     | +----- Set?
+ *          |     +------- Has a handler?
  *          +----------- <Reserved>
  */
 typedef u32 acpi_event_status;
-- 
1.7.9.5



