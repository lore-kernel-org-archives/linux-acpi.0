From: Len Brown <lenb@kernel.org>
Subject: [PATCH 84/98] ACPI: remove unused acpi_bus_ops flags
Date: Sat, 28 Mar 2009 00:31:59 -0400
Message-ID: <8308e8ab70fd5d7b78afb133c51c5079548ba84f.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:8537 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbZC1Edr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7000NL8O7WGR9@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:44 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

In acpi_bus_ops, only the acpi_op_add and acpi_op_start flags are used,
so remove all the rest.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_bus.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fb91bc2..08ec60c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -98,17 +98,7 @@ typedef int (*acpi_op_unbind) (struct acpi_device * device);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
-	u32 acpi_op_remove:1;
-	u32 acpi_op_lock:1;
 	u32 acpi_op_start:1;
-	u32 acpi_op_stop:1;
-	u32 acpi_op_suspend:1;
-	u32 acpi_op_resume:1;
-	u32 acpi_op_scan:1;
-	u32 acpi_op_bind:1;
-	u32 acpi_op_unbind:1;
-	u32 acpi_op_shutdown:1;
-	u32 reserved:21;
 };
 
 struct acpi_device_ops {
-- 
1.6.0.6

