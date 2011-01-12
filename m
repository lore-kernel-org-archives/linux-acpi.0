From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/9] ACPICA: Update version to 20101209
Date: Wed, 12 Jan 2011 04:38:10 -0500
Message-ID: <1ae5ec903f71c0ffa583ec54d17415892036ee18.1294824789.git.len.brown@intel.com>
References: <1294825090-21150-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:44730 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab1ALJie (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 04:38:34 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW00JJNLG92ES0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 03:38:34 -0600 (CST)
In-reply-to: <1294825090-21150-1-git-send-email-lenb@kernel.org>
In-reply-to: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
References: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Version 20101209.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e8142d5..241b8a0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20101013
+#define ACPI_CA_VERSION                 0x20101209
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.4.rc1.7.g2cf08

