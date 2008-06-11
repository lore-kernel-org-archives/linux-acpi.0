From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/23] dock.c remove trailing printk whitespace
Date: Wed, 11 Jun 2008 03:59:17 -0400
Message-ID: <636c37d56785398dc0c01ca432377f7ed2e132cf.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59179 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbYFKH7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:35 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00G3PGK7XTG5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:52:56 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Tim Pepper <lnxninja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Tim Pepper <lnxninja@linux.vnet.ibm.com>

Signed-off-by: Tim Pepper <lnxninja@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index fa44fb9..96c542f 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -834,7 +834,7 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
 
-	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
+	printk(KERN_INFO PREFIX "%s\n", ACPI_DOCK_DRIVER_DESCRIPTION);
 
 	return 0;
 
-- 
1.5.6.rc2.23.gea81e

