From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 2/9] ACPI-video: Return directly after a failed device
 query
Date: Wed, 9 Aug 2017 17:36:34 +0200
Message-ID: <a063b27d-2ef4-6029-230c-970a46d0834e@users.sourceforge.net>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8cc6f88-9261-55d9-a736-a14b853a2570@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 15:00:45 +0200

Return directly after a function call "acpi_video_device_lcd_query_levels"
failed at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1aaf2b591ca8..7a9cda6c0a6b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -811,8 +811,7 @@ int acpi_video_get_levels(struct acpi_device *device,
 								&obj))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
 						"LCD brightness level\n"));
-		result = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	if (obj->package.count < ACPI_VIDEO_FIRST_LEVEL) {
-- 
2.13.4
