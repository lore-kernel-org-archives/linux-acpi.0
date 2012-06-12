From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Tue, 12 Jun 2012 10:43:28 +0200
Message-ID: <1339490608.21507.5.camel@amber.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35249 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab2FLInk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 04:43:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Many firmwares have a common register definition bug where 8-bit
access width is specified for a 32-bit register. Ideally this should
be fixed in the BIOS, but earlier versions of the kernel did not
complain, so fix that up silently.

This closes kernel bug #43282:
https://bugzilla.kernel.org/show_bug.cgi?id=43282

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: stable@vger.kernel.org [3.4+]
---
 drivers/acpi/apei/apei-base.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-3.4.orig/drivers/acpi/apei/apei-base.c	2012-06-08 10:02:06.000000000 +0200
+++ linux-3.4/drivers/acpi/apei/apei-base.c	2012-06-08 10:04:16.503779775 +0200
@@ -586,6 +586,11 @@ static int apei_check_gar(struct acpi_ge
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
 
+	/* Fixup common BIOS bug */
+	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
+	    *access_bit_width < 32)
+		*access_bit_width = 32;
+
 	if ((bit_width + bit_offset) > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
 			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",

-- 
Jean Delvare
Suse L3

