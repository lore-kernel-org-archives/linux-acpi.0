From: Alex Williamson <alex.williamson@hp.com>
Subject: [PATCH] Enable _OSI(Linux) for Xen HVM domains
Date: Tue, 06 Nov 2007 12:05:06 -0700
Message-ID: <1194375906.31834.211.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel10.hp.com ([156.153.255.245]:33268 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbXKFTby (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Nov 2007 14:31:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Keir Fraser <keir@xensource.com>


   I'd like to enable _OSI(Linux) for Xen HVM domains.  As I understand
it, the main reason for disabling _OSI(Linux) by default is to avoid
dealing with a myriad of systems with broken Linux code paths in their
BIOS (while we know the Windows code path is functional).  With fully
virtualized Xen domains, the "BIOS" code is provided from the Xen
project (or separate open source tree in the case on ia64).  We can
therefore verify the Linux code path works and we can take advantage of
the _OSI call to make optimization in the hypervisor based on the
guest's response.  The patch below enables this feature on both x86 and
ia64 Xen via the existing DMI hook.  Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
Acked-by: Keir Fraser <keir@xensource.com>
--

diff -r c7f1be4e5832 drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Thu Nov 01 12:09:33 2007 -0700
+++ b/drivers/acpi/osl.c	Fri Nov 02 15:30:23 2007 -0700
@@ -1225,6 +1225,14 @@ static struct dmi_system_id acpi_osl_dmi
 		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
 		     },
 	 },
+	{
+	 .callback = dmi_osi_linux,
+	 .ident = "Xen HVM domU",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Xen"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "HVM domU"),
+		     },
+	 },
 	{}
 };
 #endif /* CONFIG_DMI */


