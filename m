From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] acpi/doc: add missing param value
Date: Sun, 22 Feb 2009 17:05:22 -0800
Message-ID: <20090222170522.02db8b69.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:18619 "EHLO
	rgminet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZBWBEl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Feb 2009 20:04:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, akpm <akpm@linux-foundation.org>, torvalds <torvalds@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Add missing parameter value to list of available values
for acpi=<value>.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20090220.orig/Documentation/kernel-parameters.txt
+++ linux-next-20090220/Documentation/kernel-parameters.txt
@@ -136,7 +136,7 @@ and is between 256 and 4096 characters. 
 
 	acpi=		[HW,ACPI,X86-64,i386]
 			Advanced Configuration and Power Interface
-			Format: { force | off | ht | strict | noirq }
+			Format: { force | off | ht | strict | noirq | rsdt }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
