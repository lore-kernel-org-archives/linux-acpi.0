From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/70] ACPICA: Update version to 20080609
Date: Fri, 20 Jun 2008 03:43:32 -0400
Message-ID: <bfc1f310b4731f765f002cbc3ec8a4e6b1a2dc17.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38101 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYFTHos (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:48 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00D3L46AS7T1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:35 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Update version to 20080609.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acconfig.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 2ced0e1..e66aabd 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -63,7 +63,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20080514
+#define ACPI_CA_VERSION                 0x20080609
 
 /*
  * OS name, used for the _OS object.  The _OS object is essentially obsolete,
-- 
1.5.6

