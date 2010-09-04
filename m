From: Luis Henriques <luis.henrix@gmail.com>
Subject: [PATCH 1/1] ACPI: fan: Fix more unbalanced code block
Date: Sat, 4 Sep 2010 15:24:09 +0100
Message-ID: <20100904142409.GA19040@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34329 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab0IDO3J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Sep 2010 10:29:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is a resend -- there was no feedback from previous patch submission
so I assume no one took a look at this.

commit 934231de706d2579fae14f5857fcd8de991009ff fixes an unbalanced
CONFIG_ACPI_PROCFS code block during module initialisation.  This
patch fixes similar issue but for the module exit.

Signed-off-by: Luis Henriques <luis.henrix@gmail.com>
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
1.7.1

