From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/9] ACPICA: Update version to 20100121.
Date: Mon, 01 Mar 2010 01:56:17 -0500
Message-ID: <aea9c04bcc257caad9841c283b90ec1b28267fae.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:42835 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0CAG4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL003FJCLXH8I1@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:56:24 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20100121.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2bf965a..06adbac 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20091214
+#define ACPI_CA_VERSION                 0x20100121
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.6.0.6

