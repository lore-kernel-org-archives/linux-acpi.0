From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] Document ACPI_NUMA component in
	Documentation/acpi/debug.txt
Date: Fri, 17 Jul 2009 22:41:44 +0200
Message-ID: <20090717204144.GA607@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:58789 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbZGQUlq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2009 16:41:46 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org

Document ACPI_NUMA component in Documentation/acpi/debug.txt

The numerical hole suggests there is one more component
missing, but I didn't find it on a quick grep.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
 Documentation/acpi/debug.txt |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.31-rc3-ak/Documentation/acpi/debug.txt
===================================================================
--- linux-2.6.31-rc3-ak.orig/Documentation/acpi/debug.txt
+++ linux-2.6.31-rc3-ak/Documentation/acpi/debug.txt
@@ -63,6 +63,7 @@ shows the supported mask values, current
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
     ACPI_VIDEO_COMPONENT            0x10000000
     ACPI_PROCESSOR_COMPONENT        0x20000000
+    ACPI_NUMA                       0x80000000
 
 debug_level
 -----------
