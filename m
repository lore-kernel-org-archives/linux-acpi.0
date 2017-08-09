From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 7/9] ACPI-video: Delete an unnecessary initialisation in
 three functions
Date: Wed, 9 Aug 2017 17:44:07 +0200
Message-ID: <7a5b6015-2b04-ef31-1765-b00386238aa9@users.sourceforge.net>
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
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 15:55:35 +0200

Three local variables will be set to appropriate values a bit later.
Thus omit the explicit initialisation at the beginning of these functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index e279ed221961..a899faf6ff84 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -803,7 +803,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
 	union acpi_object *o;
-	struct acpi_video_device_brightness *br = NULL;
+	struct acpi_video_device_brightness *br;
 	int result = 0;
 	u32 value;
 
@@ -921,7 +921,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	int i, max_level = 0;
 	unsigned long long level, level_old;
 	struct acpi_video_device_brightness *br = NULL;
-	int result = -EINVAL;
+	int result;
 
 	result = acpi_video_get_levels(device->dev, &br, &max_level);
 	if (result)
@@ -1295,7 +1295,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 	int i;
 	struct acpi_video_enumerated_device *active_list;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *dod = NULL;
+	union acpi_object *dod;
 	union acpi_object *obj;
 
 	if (!video->cap._DOD)
-- 
2.13.4

