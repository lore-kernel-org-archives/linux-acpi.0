From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] ACPI : dock: add error handling for acpi_bus_get_device
Date: Tue, 12 Jun 2018 12:38:12 +0800
Message-ID: <1528778292-41332-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

When acpi_bus_get_device fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling acpi_bus_get_device.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/acpi/dock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index e3fc1f0..02fc134 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -504,7 +504,9 @@ static ssize_t show_docked(struct device *dev,
 	struct dock_station *dock_station = dev->platform_data;
 	struct acpi_device *adev = NULL;
 
-	acpi_bus_get_device(dock_station->handle, &adev);
+	if (acpi_bus_get_device(dock_station->handle, &adev))
+		return -ENODEV;
+
 	return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
-- 
2.7.4
