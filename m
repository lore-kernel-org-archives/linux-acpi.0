From: Len Brown <lenb@kernel.org>
Subject: [PATCH 068/122] ACPI: Add expand acpi.debug_layer in
 kernel-parameters.txt
Date: Thu, 23 Oct 2008 02:38:42 -0400
Message-ID: <36eec5e29cf31011a7fbe121badfed7efb2a4ebb.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbYJWGkh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006YAIIV3BU1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:08 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   47 ++++++++++++++++++++++++----------
 1 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1150444..44d1bd1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -217,20 +217,39 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi.debug_level=	[HW,ACPI]
 			Format: <int>
 			Each bit of the <int> indicates an ACPI debug level,
-			1: enable, 0: disable. It is useful for boot time
-			debugging. After system has booted up, it can be set
-			via /sys/module/acpi/parameters/debug_level.
-			CONFIG_ACPI_DEBUG must be enabled for this to produce any output.
-			Available bits (add the numbers together) to enable different
-			debug output levels of the ACPI subsystem:
-			0x01 error 0x02 warn 0x04 init 0x08 debug object
-			0x10 info 0x20 init names 0x40 parse 0x80 load
-			0x100 dispatch 0x200 execute 0x400 names 0x800 operation region
-			0x1000 bfield 0x2000 tables 0x4000 values 0x8000 objects
-			0x10000 resources 0x20000 user requests 0x40000 package.
-			The number can be in decimal or prefixed with 0x in hex.
-			Warning: Many of these options can produce a lot of
-			output and make your system unusable. Be very careful.
+			which corresponds to the level in an ACPI_DEBUG_PRINT
+			statement.  After system has booted up, this mask
+			can be set via /sys/module/acpi/parameters/debug_level.
+
+			CONFIG_ACPI_DEBUG must be enabled for this to produce
+			any output.  The number can be in decimal or prefixed
+			with 0x in hex.  Some of these options produce so much
+			output that the system is unusable.
+
+			The following global components are defined by the
+			ACPI CA:
+			       0x01 error
+			       0x02 warn
+			       0x04 init
+			       0x08 debug object
+			       0x10 info
+			       0x20 init names
+			       0x40 parse
+			       0x80 load
+			      0x100 dispatch
+			      0x200 execute
+			      0x400 names
+			      0x800 operation region
+			     0x1000 bfield
+			     0x2000 tables
+			     0x4000 values
+			     0x8000 objects
+			    0x10000 resources
+			    0x20000 user requests
+			    0x40000 package
+ 			The number can be in decimal or prefixed with 0x in hex.
+ 			Warning: Many of these options can produce a lot of
+ 			output and make your system unusable. Be very careful.
 
 	acpi_pm_good	[X86-32,X86-64]
 			Override the pmtimer bug detection: force the kernel
-- 
1.5.5.1

