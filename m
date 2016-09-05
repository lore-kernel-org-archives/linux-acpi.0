From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 04/21] ACPI-video: Rename jump labels in
 acpi_video_get_levels()
Date: Mon, 5 Sep 2016 18:50:25 +0200
Message-ID: <38d7268d-4166-6df0-06fd-c66456a2d544@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:58343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935081AbcIEQuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 12:50:46 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 14:11:43 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 420d125..82987db 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -773,13 +773,13 @@ int acpi_video_get_levels(struct acpi_device *device,
 
 	if (obj->package.count < 2) {
 		result = -EINVAL;
-		goto out;
+		goto free_object;
 	}
 
 	br = kzalloc(sizeof(*br), GFP_KERNEL);
 	if (!br) {
 		result = -ENOMEM;
-		goto out;
+		goto free_object;
 	}
 
 	br->levels = kmalloc_array(obj->package.count + 2,
@@ -787,7 +787,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 				   GFP_KERNEL);
 	if (!br->levels) {
 		result = -ENOMEM;
-		goto out_free;
+		goto free_brightness;
 	}
 
 	for (i = 0; i < obj->package.count; i++) {
@@ -843,13 +843,12 @@ int acpi_video_get_levels(struct acpi_device *device,
 	*dev_br = br;
 	if (pmax_level)
 		*pmax_level = max_level;
-
-out:
+ free_object:
 	kfree(obj);
 	return result;
-out_free:
+ free_brightness:
 	kfree(br);
-	goto out;
+	goto free_object;
 }
 EXPORT_SYMBOL(acpi_video_get_levels);
 
-- 
2.10.0

