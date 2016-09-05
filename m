From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 20/21] ACPI-video: Improve a size determination in
 acpi_video_dev_register_backlight()
Date: Mon, 5 Sep 2016 19:07:24 +0200
Message-ID: <878fe5ae-be5c-79a9-c44b-e6c25ac5220b@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <897ebf36-2fe5-e109-adf6-b81b6e863d9a@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 17:45:40 +0200

Replace the specification of a data structure by a reference for
a local variable as the parameter for the operator "sizeof" to make
the corresponding size determination a bit safer according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 231fab3..9685725 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1685,7 +1685,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		pci_dev_put(pdev);
 	}
 
-	memset(&props, 0, sizeof(struct backlight_properties));
+	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_FIRMWARE;
 	props.max_brightness = device->brightness->count - 3;
 	device->backlight = backlight_device_register(name,
-- 
2.10.0

