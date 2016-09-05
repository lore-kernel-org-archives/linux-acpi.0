From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 02/21] ACPI-video: Return directly after a failed device query
Date: Mon, 5 Sep 2016 18:46:17 +0200
Message-ID: <b569e9c9-8720-a4e4-9456-b31b38f09562@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:60735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934024AbcIEQqf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 12:46:35 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 13:25:01 +0200

Return directly after a function call "acpi_video_device_lcd_query_levels"
failed at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3d39b53..8f0807a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -768,8 +768,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 								&obj))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
 						"LCD brightness level\n"));
-		result = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	if (obj->package.count < 2) {
-- 
2.10.0

