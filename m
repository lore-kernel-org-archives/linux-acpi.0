From: "Luis G.F" <luisgf@luisgf.es>
Subject: [PATCH 2/2] acpi / sbs: Fix incorrect sscanf() string
Date: Mon, 10 Feb 2014 11:36:42 +0100
Message-ID: <1392028602-21326-1-git-send-email-luisgf@luisgf.es>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.domainsvm.com ([37.77.82.227]:40839 "EHLO
	cp-nl-1.domainsvm.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbaBJKgv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 05:36:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwsocki.net, linux-acpi@vger.kernel.org
Cc: "Luis G.F" <luisgf@luisgf.es>

Fix incorrect sscanf() string in function acpi_battery_alarm_store().

Signed-off-by: Luis G.F <luisgf@luisgf.es>
---
 drivers/acpi/sbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index d465ae6..02d0c21 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -450,7 +450,7 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
-	if (sscanf(buf, "%ld\n", &x) == 1)
+	if (sscanf(buf, "%lu\n", &x) == 1)
 		battery->alarm_capacity = x /
 			(1000 * acpi_battery_scale(battery));
 	if (battery->present)
-- 
1.8.4.5

