From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPICA: delete check for AML access to port 0x81-83
Date: Tue, 07 Apr 2009 17:56:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:26226 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZDGV4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 17:56:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR006PS3LNNV2E@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 16:56:12 -0500 (CDT)
In-reply-to: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rodrigo Luiz <rodrigo@gus-mg.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Sony laptops apparently write 4-bytes (rather than 1 byte)
to debug port 0x80, which spews error messages:

Denied AML access to port 0x00000080/4 (DMA1 0x0081-0x0083) [20090320]

http://bugzilla.kernel.org/show_bug.cgi?id=13036

Signed-off-by: Len Brown <len.brown@intel.com>
---

Rodrigo,
Please verify that this makes the warnings go away.

thanks,
-Len

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
1.6.2.2.446.gfbdc

