From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/23] ACPI: thinkpad-acpi: update documents for the new
 location
Date: Fri, 16 Jan 2009 15:24:50 -0500
Message-ID: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:52853 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759871AbZAPUZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK00MKTZE2KZV4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:15 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update documentation to reflect the new location of the
thinkpad-acpi driver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 898b498..ddc371e 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -16,7 +16,8 @@ supported by the generic Linux ACPI drivers.
 This driver used to be named ibm-acpi until kernel 2.6.21 and release
 0.13-20070314.  It used to be in the drivers/acpi tree, but it was
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
-2.6.22, and release 0.14.
+2.6.22, and release 0.14.  It was moved to drivers/platform/x86 for
+kernel 2.6.29.
 
 The driver is named "thinkpad-acpi".  In some places, like module
 names, "thinkpad_acpi" is used because of userspace issues.
-- 
1.5.6.6

