From: Zhihui Zhang <zzhsuny@gmail.com>
Subject: [PATCH] ACPI: Fixed wrong variable usage in thermal driver
Date: Sat, 29 Mar 2014 09:25:47 -0400
Message-ID: <1396099547-3394-1-git-send-email-zzhsuny@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:64067 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC2NZ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Mar 2014 09:25:56 -0400
Received: by mail-qc0-f177.google.com with SMTP id w7so7082104qcr.36
        for <linux-acpi@vger.kernel.org>; Sat, 29 Mar 2014 06:25:55 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Zhihui Zhang <zzhsuny@gmail.com>
---
 drivers/acpi/thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 08626c8..6afe95b 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -338,7 +338,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			tz->trips.hot.flags.valid = 1;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					"Found hot threshold [%lu]\n",
-					tz->trips.critical.temperature));
+					tz->trips.hot.temperature));
 		}
 	}
 
-- 
1.8.1.2

