From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/14] acpi-wmi: Unmark as 'experimental'
Date: Mon, 16 Mar 2009 01:23:57 -0400
Message-ID: <5fcdd177d063f1d8d569d746ab1bf206b0dfb2e8.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:45332 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbZCPFYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00IIH3078T2L@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:08 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

ACPI-WMI isn't experimental anymore, and there are other drivers that now
depend on it that aren't either.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f3ab401..c2319d9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -315,9 +315,8 @@ config EEEPC_LAPTOP
 
 
 config ACPI_WMI
-	tristate "WMI (EXPERIMENTAL)"
+	tristate "WMI"
 	depends on ACPI
-	depends on EXPERIMENTAL
 	help
 	  This driver adds support for the ACPI-WMI (Windows Management
 	  Instrumentation) mapper device (PNP0C14) found on some systems.
-- 
1.5.6.6

