From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] ACPI: fix a section mismatch
Date: Wed, 08 Dec 2010 10:40:36 +0800
Message-ID: <1291776036.19296.703.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34182 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848Ab0LHCkg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Dec 2010 21:40:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


WARNING: drivers/acpi/acpi.o(.text+0xeda): Section mismatch in reference from the function acpi_os_initialize1() to the function .init.text:set_osi_linux()
The function acpi_os_initialize1() references
the function __init set_osi_linux().
This is often because acpi_os_initialize1 lacks a __init 
annotation or the annotation of set_osi_linux is wrong.

Fix this section mismatch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -1530,7 +1530,7 @@ acpi_status __init acpi_os_initialize(vo
 	return AE_OK;
 }
 
-acpi_status acpi_os_initialize1(void)
+acpi_status __init acpi_os_initialize1(void)
 {
 	kacpid_wq = create_workqueue("kacpid");
 	kacpi_notify_wq = create_workqueue("kacpi_notify");


