From: akpm@linux-foundation.org
Subject: [patch 6/6] Fix ACPI documentation in kernel-parameters.txt
Date: Tue, 06 Mar 2007 02:29:44 -0800
Message-ID: <200703061029.l26ATiiQ019139@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33923 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933234AbXCFKa7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 05:30:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bwalle@suse.de

From: Bernhard Walle <bwalle@suse.de>

Add hint that acpi=off doesn't work on IA64.

Signed-off-by: Bernhard Walle <bwalle@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/kernel-parameters.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN Documentation/kernel-parameters.txt~fix-acpi-documentation-in-kernel-parameterstxt Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt~fix-acpi-documentation-in-kernel-parameterstxt
+++ a/Documentation/kernel-parameters.txt
@@ -125,7 +125,8 @@ and is between 256 and 4096 characters. 
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.
 
-	acpi=		[HW,ACPI] Advanced Configuration and Power Interface
+	acpi=		[HW,ACPI,X86-64,i386]
+			Advanced Configuration and Power Interface
 			Format: { force | off | ht | strict | noirq }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
_
