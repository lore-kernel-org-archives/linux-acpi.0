From: akpm@osdl.org
Subject: [patch 03/13] acpi/processor: prevent loading module on failures
Date: Mon, 04 Dec 2006 14:49:39 -0800
Message-ID: <200612042250.kB4Mommx007358@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:50339 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967728AbWLDWvy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 17:51:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, akinobu.mita@gmail.com, len.brown@intel.com

From: Akinobu Mita <akinobu.mita@gmail.com>

Make loading processor.ko fail when an error happens.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~acpi-processor-prevent-loading-module-on-failures
+++ a/drivers/acpi/processor_core.c
@@ -901,13 +901,13 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return 0;
+		return -ENOMEM;
 	acpi_processor_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return 0;
+		return result;
 	}
 
 	acpi_processor_install_hotplug_notify();
_
