From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/17] ACPICA: Update version to 20080609
Date: Thu, 12 Jun 2008 00:35:16 -0400
Message-ID: <3f869524875060bf215e13d494f87c566ad356e6.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60400 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYFLEfZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:25 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C00KLE1RW23O3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:28:45 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
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
1.5.6.rc2.26.g8c37

