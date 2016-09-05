From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 17/21] ACPI-video: Delete an unnecessary initialisation in
 acpi_video_init_brightness()
Date: Mon, 5 Sep 2016 19:04:12 +0200
Message-ID: <15b5739e-3dd1-cb20-eb7f-e1bab36391c1@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:65274 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938880AbcIERE3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 13:04:29 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 17:20:22 +0200

The local variable "result" will be assigned with a statement that follows
it directly. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 2fc775a..5f1ef6e 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -872,7 +872,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	int i, max_level = 0;
 	unsigned long long level, level_old;
 	struct acpi_video_device_brightness *br = NULL;
-	int result = -EINVAL;
+	int result;
 
 	result = acpi_video_get_levels(device->dev, &br, &max_level);
 	if (result)
-- 
2.10.0

