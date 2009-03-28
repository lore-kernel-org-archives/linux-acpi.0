From: Len Brown <lenb@kernel.org>
Subject: [PATCH 50/98] ACPICA: Fix PCI configuration space port address range
Date: Sat, 28 Mar 2009 00:31:25 -0400
Message-ID: <f28ad2c3daf0691081d91488df4d9d101e1a2b5d.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49601 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZC1Ecx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700KAW8MQ4KJD@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:51 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Microsoft website uses 0xCF8-0xD00. Should be 0xCF8-0xCFF (Two
32-bit registers.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwvalid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 105b818..bd3c937 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -100,7 +100,7 @@ static const struct acpi_port_info acpi_protected_ports[] = {
 	{"PIC1", 0x00A0, 0x00A1, ACPI_ALWAYS_ILLEGAL},
 	{"IDMA", 0x00C0, 0x00DF, ACPI_OSI_WIN_XP},
 	{"ELCR", 0x04D0, 0x04D1, ACPI_ALWAYS_ILLEGAL},
-	{"PCI", 0x0CF8, 0x0D00, ACPI_OSI_WIN_XP}
+	{"PCI", 0x0CF8, 0x0CFF, ACPI_OSI_WIN_XP}
 };
 
 #define ACPI_PORT_INFO_ENTRIES  ACPI_ARRAY_LENGTH (acpi_protected_ports)
-- 
1.6.0.6

