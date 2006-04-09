From: Vasily Averin <vvs@sw.ru>
Subject: [PATCH ACPI] memory leakages in drivers/acpi/thermal.c
Date: Sun, 09 Apr 2006 19:08:40 +0400
Message-ID: <44392378.3090400@sw.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050302050304010808070409"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:45124 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750769AbWDIPFk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 11:05:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>, devel@openvz.org

This is a multi-part message in MIME format.
--------------050302050304010808070409
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

acpi_thermal_write_trip_points() and acpi_thermal_add() do not call kfree() for
allocated memory on the error path.

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------050302050304010808070409
Content-Type: text/plain;
 name="diff-ms-acpi-thermal-20060409"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-acpi-thermal-20060409"

--- a/drivers/acpi/thermal.c	2006-04-09 17:03:50.000000000 +0400
+++ b/drivers/acpi/thermal.c	2006-04-09 17:46:41.000000000 +0400
@@ -942,8 +942,10 @@ acpi_thermal_write_trip_points(struct fi
 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
 
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
-	if (!active)
+	if (!active) {
+		kfree(limit_string);
 		return_VALUE(-ENOMEM);
+	}
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
@@ -1342,7 +1344,7 @@ static int acpi_thermal_add(struct acpi_
 
 	result = acpi_thermal_add_fs(device);
 	if (result)
-		return_VALUE(result);
+		goto end;
 
 	init_timer(&tz->timer);
 

--------------050302050304010808070409--
