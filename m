From: Len Brown <lenb@kernel.org>
Subject: [PATCH 56/98] sony-laptop: Enable EC on newer hardware
Date: Sat, 28 Mar 2009 00:31:31 -0400
Message-ID: <82734bfc8622f3e8f015a5783b739739f97f89f9.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38236 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbZC1EdU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:20 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7001DR8ND3A9D@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:15 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The latest Vaios can execute certain codepaths in two ways - either using
system management mode or using pure ACPI methods. The latter is only used
if the OS has called the ECON method. Ensure that this is done where the
method is available.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3c52ec9..04deed8 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -948,6 +948,12 @@ static int sony_nc_resume(struct acpi_device *device)
 		}
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
 					 &handle))) {
 		dprintk("Doing SNC setup\n");
@@ -1005,6 +1011,12 @@ static int sony_nc_add(struct acpi_device *device)
 			dprintk("_INI Method failed\n");
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "ECON",
+					 &handle))) {
+		if (acpi_callsetfunc(sony_nc_acpi_handle, "ECON", 1, NULL))
+			dprintk("ECON Method failed\n");
+	}
+
 	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN00",
 					 &handle))) {
 		dprintk("Doing SNC setup\n");
-- 
1.6.0.6

