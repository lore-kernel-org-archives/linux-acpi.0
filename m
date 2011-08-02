From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/27] ACPICA: Update to version 20110623
Date: Tue, 02 Aug 2011 16:53:08 -0400
Message-ID: <3eb208f0a36cf7a86953afa7a4eb6776294e6768.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:38790 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab1HBUx4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:53:56 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00DICJDTESE3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:53:54 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20110623.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d42d7ce..f554a93 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110527
+#define ACPI_CA_VERSION                 0x20110623
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.6.396.ge0613

