From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ACPI: use after free in acpi_battery_add()
Date: Tue, 29 Mar 2011 06:12:10 +0300
Message-ID: <20110329031210.GA9856@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39379 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab1C2DMp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Mar 2011 23:12:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

"battery" was dereferenced on the error path here.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fcc13ac..cfc7a5b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -988,6 +988,7 @@ static int acpi_battery_add(struct acpi_device *device)
 		acpi_battery_remove_fs(device);
 #endif
 		kfree(battery);
+		return result;
 	}
 
 	battery->pm_nb.notifier_call = battery_notify;
