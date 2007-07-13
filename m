From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: remove /sys/firmware/acpi/namespace
Date: Fri, 13 Jul 2007 13:42:47 +0800
Message-ID: <1184305367.5816.7.camel@rzhang1-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49618 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbXGMFm6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2007 01:42:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The /sys/firmware/acpi/namespace has already been removed in 2.6.21.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/feature-removal-schedule.txt |   14 --------------
 1 file changed, 14 deletions(-)

Index: linux-2.6.22/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.22.orig/Documentation/feature-removal-schedule.txt	2007-07-12 17:52:12.000000000 +0800
+++ linux-2.6.22/Documentation/feature-removal-schedule.txt	2007-07-12 17:54:04.000000000 +0800
@@ -228,20 +228,6 @@
 
 ---------------------------
 
-What:	/sys/firmware/acpi/namespace
-When:	2.6.21
-Why:	The ACPI namespace is effectively the symbol list for
-	the BIOS.  The device names are completely arbitrary
-	and have no place being exposed to user-space.
-
-	For those interested in the BIOS ACPI namespace,
-	the BIOS can be extracted and disassembled with acpidump
-	and iasl as documented in the pmtools package here:
-	http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils
-Who:	Len Brown <len.brown@intel.com>
-
----------------------------
-
 What:	ACPI procfs interface
 When:	Jan 2008
 Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
