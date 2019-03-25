From: helgaas@kernel.org
Subject: [PATCH 3/4] ACPI / scan: Simplify acpi_bus_extract_wakeup_device_power_package()
Date: Mon, 25 Mar 2019 13:34:02 -0500
Message-ID: <20190325183403.251473-4-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

acpi_bus_extract_wakeup_device_power_package() is a static function with a
single caller that supplies (device->handle, &device->wakeup).  Simplify
the interface so the caller need only supply "device".

This makes it obvious that "wakeup", i.e., &device->wakeup, can never be
NULL, so remove the unnecessary check for that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/scan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1b66fc835e39..f3b40299a641 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -763,18 +763,16 @@ acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
 }
 EXPORT_SYMBOL_GPL(acpi_bus_get_ejd);
 
-static int acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
-					struct acpi_device_wakeup *wakeup)
+static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
 {
+	acpi_handle handle = dev->handle;
+	struct acpi_device_wakeup *wakeup = &dev->wakeup;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
 	union acpi_object *element = NULL;
 	acpi_status status;
 	int err = -ENODATA;
 
-	if (!wakeup)
-		return -EINVAL;
-
 	INIT_LIST_HEAD(&wakeup->resources);
 
 	/* _PRW */
@@ -883,8 +881,7 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	if (!acpi_has_method(device->handle, "_PRW"))
 		return;
 
-	err = acpi_bus_extract_wakeup_device_power_package(device->handle,
-							   &device->wakeup);
+	err = acpi_bus_extract_wakeup_device_power_package(device);
 	if (err) {
 		dev_err(&device->dev, "_PRW evaluation error: %d\n", err);
 		return;
-- 
2.21.0.392.gf8f6787159e-goog
