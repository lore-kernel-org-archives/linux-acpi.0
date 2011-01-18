From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/6] ACPICA: Update version to 20110112
Date: Mon, 17 Jan 2011 20:23:03 -0500
Message-ID: <3a62ab4a188400201713d8477f27592baab5d155.1295313738.git.len.brown@intel.com>
References: <1295313783-3490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:62022 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1ARBX2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 20:23:28 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LF700L0A2IWYUJ0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 17 Jan 2011 19:23:21 -0600 (CST)
In-reply-to: <1295313783-3490-1-git-send-email-lenb@kernel.org>
In-reply-to: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
References: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20110112.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2f38e29..e46ec95 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20101209
+#define ACPI_CA_VERSION                 0x20110112
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.4.rc2

