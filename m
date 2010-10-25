From: Len Brown <lenb@kernel.org>
Subject: [PATCH 55/60] ACPI: Fix ioremap size for MMIO reads and writes
Date: Mon, 25 Oct 2010 02:21:03 -0400
Message-ID: <b3ba1efec2a58f4dc0647f4c0099c27d6ab92595.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50532 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:05 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

The size used for I/O remapping MMIO read and write accesses has not
accounted for the basis of ACPI's Generic Address Structure (GAS)
'Register Bit Width' field which is bits, not bytes.  This patch
adjusts the ioremap() 'size' argument accordingly.

ACPI "Generic Register" reference:
  ACPI Specification, Revision 4.0, Section 5.2.3.1, "Generic Address
  Structure".

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 65b25a3..58842fb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -496,7 +496,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u32 * value, u32 width)
 	u32 dummy;
 	void __iomem *virt_addr;
 
-	virt_addr = ioremap(phys_addr, width);
+	virt_addr = ioremap(phys_addr, width / 8);
 	if (!value)
 		value = &dummy;
 
@@ -524,7 +524,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
 
-	virt_addr = ioremap(phys_addr, width);
+	virt_addr = ioremap(phys_addr, width / 8);
 
 	switch (width) {
 	case 8:
-- 
1.7.3.2.90.gd4c43

