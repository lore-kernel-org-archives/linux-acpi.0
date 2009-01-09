From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/94] ACPICA: Fix namestring for the SystemCMOS address space
Date: Fri, 09 Jan 2009 04:26:27 -0500
Message-ID: <34830726c9761f66299f4d82c4357e5faec54013.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbZAIJ2V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:21 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LFI6AMLFF7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:59 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This fixes the name of this address space, changing it from the
incorrect CMOS to the correct SystemCMOS.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utglobal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 17ed5ac..3dc5311 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -352,7 +352,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"PCI_Config",
 	"EmbeddedControl",
 	"SMBus",
-	"CMOS",
+	"SystemCMOS",
 	"PCIBARTarget",
 	"DataTable"
 };
-- 
1.5.6.6

