From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/14] acpi-wmi: unsigned cannot be less than 0
Date: Mon, 16 Mar 2009 01:24:00 -0400
Message-ID: <da511997d2bbc09f5e39385e0ed209578db07c91.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:25340 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZCPFYT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00152308V53H@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:09 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

include/linux/pci-acpi.h:74:

typedef u32                 acpi_status;

result is unsigned, so an error returned by acpi_bus_register_driver()
will not be noticed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8a8b377..2f269e1 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -708,7 +708,7 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 
 static int __init acpi_wmi_init(void)
 {
-	acpi_status result;
+	int result;
 
 	INIT_LIST_HEAD(&wmi_blocks.list);
 
-- 
1.5.6.6

