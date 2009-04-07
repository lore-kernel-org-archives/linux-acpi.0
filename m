From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/17] ACPICA: delete check for AML access to port 0x81-83
Date: Tue, 07 Apr 2009 19:04:22 -0400
Message-ID: <fdbdc7fc79c02ae4ede869d514179a2c65633d28.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:26892 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZDGXFH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR0021L6SGC583@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:05:05 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Sony laptops apparently write 4-bytes (rather than 1 byte)
to debug port 0x80, which spews error messages:

Denied AML access to port 0x00000080/4 (DMA1 0x0081-0x0083) [20090320]

http://bugzilla.kernel.org/show_bug.cgi?id=13036

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwvalid.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index bd3c937..7737afb 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -90,7 +90,6 @@ static const struct acpi_port_info acpi_protected_ports[] = {
 	{"PIT2", 0x0048, 0x004B, ACPI_OSI_WIN_XP},
 	{"RTC", 0x0070, 0x0071, ACPI_OSI_WIN_XP},
 	{"CMOS", 0x0074, 0x0076, ACPI_OSI_WIN_XP},
-	{"DMA1", 0x0081, 0x0083, ACPI_OSI_WIN_XP},
 	{"DMA1L", 0x0087, 0x0087, ACPI_OSI_WIN_XP},
 	{"DMA2", 0x0089, 0x008B, ACPI_OSI_WIN_XP},
 	{"DMA2L", 0x008F, 0x008F, ACPI_OSI_WIN_XP},
-- 
1.6.0.6

