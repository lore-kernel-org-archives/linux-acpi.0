From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 9/9] ACPI-video: Improve a size determination in four
 functions
Date: Wed, 9 Aug 2017 17:47:21 +0200
Message-ID: <3b229259-6268-9bbd-f960-4ce382b0ab23@users.sourceforge.net>
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
Date: Wed, 9 Aug 2017 16:45:29 +0200

Replace the specification of a data structures by variable references
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3cc1798676ab..d999f4e49b98 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1140,7 +1140,7 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 	if (ACPI_FAILURE(status))
 		return 0;
 
-	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1321,7 +1321,7 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
 			  dod->package.count));
 
 	active_list = kcalloc(1 + dod->package.count,
-			      sizeof(struct acpi_video_enumerated_device),
+			      sizeof(*active_list),
 			      GFP_KERNEL);
 	if (!active_list) {
 		status = -ENOMEM;
@@ -1742,7 +1742,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		pci_dev_put(pdev);
 	}
 
-	memset(&props, 0, sizeof(struct backlight_properties));
+	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_FIRMWARE;
 	props.max_brightness =
 		device->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
@@ -2007,7 +2007,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 			return -ENODEV;
 	}
 
-	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
+	video = kzalloc(sizeof(*video), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;
 
-- 
2.13.4
