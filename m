From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/18] ACPICA: Update to version 20111123
Date: Sun, 11 Dec 2011 12:45:49 -0500
Message-ID: <2235332dbba855e204eadf462dedd14924f2729d.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36828 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1LKS0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 13:26:39 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW10020XXWDDIBB@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 12:26:38 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This version contains full support for the ACPI 5.0 specification.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5d8df1d..30f5bef 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110623
+#define ACPI_CA_VERSION                 0x20111123
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.7.rc0.72.g4b5ea

