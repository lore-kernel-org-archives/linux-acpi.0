From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] ACPI SBS: Re-enable battery manager
Date: Wed, 22 Apr 2015 16:40:21 +0100
Message-ID: <20150422154021.GA16720@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36120 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbbDVPkZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2015 11:40:25 -0400
Received: by wgen6 with SMTP id n6so36413568wge.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2015 08:40:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Commit 9faf6136 introduced a regression disabling the SBS battery
manager. The battery manager should be marked as present when
acpi_manager_get_info returns 0.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/sbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index cd82762..01504c8 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -684,7 +684,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 	if (!sbs_manager_broken) {
 		result = acpi_manager_get_info(sbs);
 		if (!result) {
-			sbs->manager_present = 0;
+			sbs->manager_present = 1;
 			for (id = 0; id < MAX_SBS_BAT; ++id)
 				if ((sbs->batteries_supported & (1 << id)))
 					acpi_battery_add(sbs, id);
-- 
2.1.4

