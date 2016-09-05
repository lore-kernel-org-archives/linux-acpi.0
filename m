From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 05/21] ACPI-video: Delete an unnecessary initialisation in
 acpi_video_get_levels()
Date: Mon, 5 Sep 2016 18:51:32 +0200
Message-ID: <9cf61b6f-e42f-25d1-3360-7747ed994b5a@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50227 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935088AbcIEQvs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 12:51:48 -0400
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 14:23:55 +0200

The local variable "br" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 82987db..0799865 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -760,7 +760,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
 	union acpi_object *o;
-	struct acpi_video_device_brightness *br = NULL;
+	struct acpi_video_device_brightness *br;
 	int result = 0;
 	u32 value;
 
-- 
2.10.0

