From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/9] ACPI: Oops in ACPI with git latest
Date: Sat, 25 Oct 2008 04:13:38 -0400
Message-ID: <f8123381bae8d581d81f24b55719db3d9a6a262c.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:43594 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYJYIOA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:14:00 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9A00N8XC6X25M7@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:45 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI Warning (nseval-0168): Insufficient arguments - method [_OSC] needs 5, found 4 [20080926]
ACPI Warning (nspredef-0252): \_SB_.PCI0._OSC: Parameter count mismatch - ASL declared 5, expected 4 [20080926]
ACPI Error (nspredef-0163): \_SB_.PCI0._OSC: Missing expected return value [20080926]
BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<c0237671>] acpi_run_osc+0xa1/0x170

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Tested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dfe7c8e..b3a63ed 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -83,6 +83,9 @@ static acpi_status acpi_run_osc(acpi_handle handle,
 	if (ACPI_FAILURE(status))
 		return status;
 
+	if (!output.length)
+		return AE_NULL_OBJECT;
+
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
-- 
1.5.6.5

