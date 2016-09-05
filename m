From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 06/21] ACPI-video: Move four assignments in
 acpi_video_get_levels()
Date: Mon, 5 Sep 2016 18:52:33 +0200
Message-ID: <ad78faeb-827f-3606-3723-49e730405867@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 14:40:46 +0200

Move the assignments for four local variables so that they will only
be performed if the corresponding data processing succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0799865..0fca196 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -758,10 +758,10 @@ int acpi_video_get_levels(struct acpi_device *device,
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
@@ -790,6 +790,8 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto free_brightness;
 	}
 
+	max_level = 0;
+	count = 0;
 	for (i = 0; i < obj->package.count; i++) {
 		o = (union acpi_object *)&obj->package.elements[i];
 		if (o->type != ACPI_TYPE_INTEGER) {
@@ -814,6 +816,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
+	level_ac_battery = 0;
 	for (i = 2; i < count; i++) {
 		if (br->levels[i] == br->levels[0])
 			level_ac_battery++;
@@ -843,6 +846,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	*dev_br = br;
 	if (pmax_level)
 		*pmax_level = max_level;
+	result = 0;
  free_object:
 	kfree(obj);
 	return result;
-- 
2.10.0
