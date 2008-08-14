From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] [DMAR] Fix endless "Unknown DMAR structure type" loop
Date: Thu, 14 Aug 2008 14:34:35 -0400
Message-ID: <48A47ABB.1090805@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host64.cybernetics.com ([98.174.209.230]:3823 "EHLO
	mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYHNTFG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Aug 2008 15:05:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ashok.raj@intel.com, shaohua.li@intel.com, anil.s.keshavamurthy@intel.com

I have a SuperMicro C2SBX motherboard with BIOS revision 1.0b.  With
vt-d enabled in the BIOS, Linux gets into an endless loop printing
"DMAR:Unknown DMAR structure type" when booting.  Here is the DMAR ACPI
table:

DMAR @ 0x7fe86dec
  0000: 44 4d 41 52 98 00 00 00 01 6f 49 6e 74 65 6c 20  DMAR.....oIntel 
  0010: 4f 45 4d 44 4d 41 52 20 00 00 04 06 4c 4f 48 52  OEMDMAR ....LOHR
  0020: 01 00 00 00 23 00 00 00 00 00 00 00 00 00 00 00  ....#...........
  0030: 01 00 58 00 00 00 00 00 00 a0 e8 7f 00 00 00 00  ..X.............
  0040: ff ff ef 7f 00 00 00 00 01 08 00 00 00 00 1d 00  ................
  0050: 01 08 00 00 00 00 1d 01 01 08 00 00 00 00 1d 02  ................
  0060: 01 08 00 00 00 00 1d 07 01 08 00 00 00 00 1a 00  ................
  0070: 01 08 00 00 00 00 1a 01 01 08 00 00 00 00 1a 02  ................
  0080: 01 08 00 00 00 00 1a 07 01 08 00 00 00 00 1a 07  ................
  0090: c0 00 68 00 04 10 66 60                          ..h...f`

Here are the messages printed by the kernel:

DMAR:Host address width 36
DMAR:RMRR base: 0x000000007fe8a000 end: 0x000000007fefffff
DMAR:Unknown DMAR structure type
DMAR:Unknown DMAR structure type
DMAR:Unknown DMAR structure type
...

Although I not very familiar with ACPI, to me it looks like
struct acpi_dmar_header::length == 0x0058 is incorrect, causing
parse_dmar_table() to look at an invalid offset on the next loop.  This
offset happens to have struct acpi_dmar_header::length == 0x0000, which
prevents the loop from ever terminating.  This patch checks for this
condition and bails out instead of looping forever.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
--- linux-2.6.27-rc3-git2/drivers/pci/dmar.c.orig	2008-08-14 13:29:32.000000000 -0400
+++ linux-2.6.27-rc3-git2/drivers/pci/dmar.c	2008-08-14 14:14:13.000000000 -0400
@@ -277,6 +277,14 @@ parse_dmar_table(void)
 	entry_header = (struct acpi_dmar_header *)(dmar + 1);
 	while (((unsigned long)entry_header) <
 			(((unsigned long)dmar) + dmar_tbl->length)) {
+		/* Avoid looping forever on bad ACPI tables */
+		if (entry_header->length == 0) {
+			printk(KERN_WARNING PREFIX
+				"Invalid 0-length structure\n");
+			ret = -EINVAL;
+			break;
+		}
+
 		dmar_table_print_dmar_entry(entry_header);
 
 		switch (entry_header->type) {


