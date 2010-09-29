From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/16] ACPI: fan: Fix more unbalanced code block
Date: Tue, 28 Sep 2010 23:44:44 -0400
Message-ID: <a43848947db46a6a87f72b60b9e510ae161d10af.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab0I2DyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:04 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luis Henriques <luis.henrix@gmail.com>, Len Brown <len.brown@intel.com>

From: Luis Henriques <luis.henrix@gmail.com>

commit 934231de706d2579fae14f5857fcd8de991009ff fixes an unbalanced
CONFIG_ACPI_PROCFS code block during module initialisation.  This
patch fixes similar issue but for the module exit.

Signed-off-by: Luis Henriques <luis.henrix@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 8a3b840..d94d295 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -369,7 +369,9 @@ static void __exit acpi_fan_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_fan_driver);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
+#endif
 
 	return;
 }
-- 
1.7.3.2.g9027fa

