From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [2/2] ACPI: report "Module Device" support via _OSI
Date: Tue, 18 Apr 2006 15:58:55 -0600
Message-ID: <200604181558.55296.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:14470 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750726AbWDRV7C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 17:59:02 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Moore, Robert" <robert.moore@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

Update _OSI strings to report that "Module Device" is supported.

This is Linux-specific, so it should be one of the Linux divergences
from the Intel ACPI CA.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/drivers/acpi/utilities/uteval.c
===================================================================
--- work-mm5.orig/drivers/acpi/utilities/uteval.c	2006-04-18 15:31:22.000000000 -0600
+++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18 15:32:38.000000000 -0600
@@ -69,6 +69,9 @@
 	/* Feature Group Strings */
 
 	"Extended Address Space Descriptor",
+#ifdef CONFIG_ACPI_CONTAINER
+	"Module Device",
+#endif
 };
 
 /* Local prototypes */
