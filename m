From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Improve acpi_dbg_level= documentation
Date: Wed, 18 Apr 2007 12:21:37 +0200
Message-ID: <200704181221.37897.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59789 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbXDRKVo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Apr 2007 06:21:44 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org


First it was documented twice.

Since this is a fairly important option document it properly.
I kept myself looking for this information again and again.

In particular the individual bits are fairly important. And add some 
warnings.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -187,13 +187,16 @@ and is between 256 and 4096 characters. 
 			1: enable, 0: disable. It is useful for boot time
 			debugging. After system has booted up, it can be set
 			via /proc/acpi/debug_layer.
-
-	acpi_dbg_level=	[HW,ACPI]
-			Format: <int>
-			Each bit of the <int> indicates an ACPI debug level,
-			1: enable, 0: disable. It is useful for boot time
-			debugging. After system has booted up, it can be set
-			via /proc/acpi/debug_level.
+			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
+			Available bits (add the numbers together) to enable debug output
+			for specific parts of the ACPI subsystem:
+			1 utilities 2 hardware 4 events 8 tables 
+			0x10 namespace 0x20 parser 0x40 dispatcher
+			0x80 executer 0x100 resources 0x200 debugger
+			0x400 os services
+			The number can be in decimal or prefixed with 0x in hex.
+			Warning: Many of these options can produce a lot of 
+			output and make your system unusable. Be very careful.
 
 	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
 
