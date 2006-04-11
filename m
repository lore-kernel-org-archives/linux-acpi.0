From: akpm@osdl.org
Subject: [patch 12/13] acpi: memory leakages in drivers/acpi/thermal.c
Date: Mon, 10 Apr 2006 23:17:01 -0700
Message-ID: <200604110717.k3B7HgDu014929@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbWDKHSV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Apr 2006 03:18:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, vvs@sw.ru


From: Vasily Averin <vvs@sw.ru>

acpi_thermal_write_trip_points() and acpi_thermal_add() do not call kfree()
for allocated memory on the error path.

Signed-off-by: Vasily Averin <vvs@sw.ru>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/thermal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/thermal.c~acpi-memory-leakages-in-drivers-acpi-thermalc drivers/acpi/thermal.c
--- devel/drivers/acpi/thermal.c~acpi-memory-leakages-in-drivers-acpi-thermalc	2006-04-10 23:16:26.000000000 -0700
+++ devel-akpm/drivers/acpi/thermal.c	2006-04-10 23:16:26.000000000 -0700
@@ -1329,7 +1329,7 @@ static int acpi_thermal_add(struct acpi_
 
 	result = acpi_thermal_add_fs(device);
 	if (result)
-		return_VALUE(result);
+		goto end;
 
 	init_timer(&tz->timer);
 
_
