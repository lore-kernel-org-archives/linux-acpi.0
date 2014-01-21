From: "Luis G.F" <luisgf@luisgf.es>
Subject: [PATCH 1/1] acpi: Fix incorrect sscanf() string in acpi_battery_init_alarm()
Date: Tue, 21 Jan 2014 15:40:43 +0100
Message-ID: <1390315243-11653-1-git-send-email-luisgf@luisgf.es>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.domainsvm.com ([37.77.82.227]:48239 "EHLO
	cp-nl-1.domainsvm.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbaAUPeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jan 2014 10:34:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, "Luis G.F" <luisgf@luisgf.es>

Fix incorrect sscanf() string in acpi_battery_init_alarm function.
Change from %ld to %lu that's 'x' variable is unsigned long.

Signed-off-by: Luis G.F <luisgf@luisgf.es>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 5876a49..95aa5d0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -550,7 +550,7 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
-	if (sscanf(buf, "%ld\n", &x) == 1)
+	if (sscanf(buf, "%lu\n", &x) == 1)
 		battery->alarm = x/1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
-- 
1.8.4

