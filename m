From: Len Brown <lenb@kernel.org>
Subject: [PATCH 9/9] ACPICA: Update version to 20101209
Date: Wed, 12 Jan 2011 00:54:56 -0500
Message-ID: <e88731b1b5a4e1d34f9025f136ab32655b97b395.1294811633.git.len.brown@intel.com>
References: <1294811696-19966-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:59224 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab1ALFzT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 00:55:19 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW004MQB46RXQ0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 11 Jan 2011 23:55:19 -0600 (CST)
In-reply-to: <1294811696-19966-1-git-send-email-lenb@kernel.org>
In-reply-to: <3bfa77e8004c7f2516afc05b4aea2a0c07ed196d.1294811633.git.len.brown@intel.com>
References: <3bfa77e8004c7f2516afc05b4aea2a0c07ed196d.1294811633.git.len.brown@intel.com>
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

