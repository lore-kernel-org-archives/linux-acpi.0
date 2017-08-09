From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 8/9] ACPI-video: Move four assignments in
 acpi_video_get_levels()
Date: Wed, 9 Aug 2017 17:45:32 +0200
Message-ID: <3a9c1c72-ec27-03a0-c3bd-15ae5915383b@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
 <CAJZ5v0hug9QfZHQosCFFXEcFMsDd=YvXkqMmQya3RSqmOnY4dg@mail.gmail.com>
 <3e0cdc5b-fd15-515a-82f2-2f44792664ed@users.sourceforge.net>
 <CAJZ5v0gWgxbtJ4m0eDkdOaR_usjTqmcWBWds5qprr+ydHhEjnA@mail.gmail.com>
 <6882cbb1-3f61-fb64-2972-30c277f28580@users.sourceforge.net>
 <CAJZ5v0hyhdUknW8RqpT6f4zAuPuMN1EN=P7C54Aa+VqEK2pcGw@mail.gmail.com>
 <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:52932 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdHIPpn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 11:45:43 -0400
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 16:21:17 +0200

Move the assignments for four local variables so that they will only
be performed if the corresponding data processing succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a899faf6ff84..3cc1798676ab 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -801,10 +801,10 @@ int acpi_video_get_levels(struct acpi_device *device,
 			  int *pmax_level)
 {
 	union acpi_object *obj = NULL;
-	int i, max_level = 0, count = 0, level_ac_battery = 0;
+	int i, max_level, count, level_ac_battery;
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br;
-	int result = 0;
+	int result;
 	u32 value;
 
 	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
@@ -838,6 +838,8 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out_free;
 	}
 
+	max_level = 0;
+	count = 0;
 	for (i = 0; i < obj->package.count; i++) {
 		o = (union acpi_object *)&obj->package.elements[i];
 		if (o->type != ACPI_TYPE_INTEGER) {
@@ -863,6 +865,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
+	level_ac_battery = 0;
 	for (i = ACPI_VIDEO_FIRST_LEVEL; i < count; i++) {
 		if (br->levels[i] == br->levels[ACPI_VIDEO_AC_LEVEL])
 			level_ac_battery++;
@@ -895,7 +898,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	*dev_br = br;
 	if (pmax_level)
 		*pmax_level = max_level;
-
+	result = 0;
 out:
 	kfree(obj);
 	return result;
-- 
2.13.4

