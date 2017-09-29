From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ACPI: Delete an error message for a failed memory
 allocation in five functions
Date: Fri, 29 Sep 2017 22:17:15 +0200
Message-ID: <dff53bcc-c056-4a09-e7d1-eabd2c3fa124@users.sourceforge.net>
References: <267c842c-d38a-67be-f61b-a2056f7e71ee@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <267c842c-d38a-67be-f61b-a2056f7e71ee@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Sep 2017 21:52:44 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpi_platform.c | 1 -
 drivers/acpi/acpi_video.c    | 1 -
 drivers/acpi/ioapic.c        | 1 -
 drivers/acpi/scan.c          | 5 +----
 4 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 88cd949003f3..9ca1fa1806ae 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -85,7 +85,6 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		resources = kzalloc(count * sizeof(struct resource),
 				    GFP_KERNEL);
 		if (!resources) {
-			dev_err(&adev->dev, "No memory for resources\n");
 			acpi_dev_free_resource_list(&resource_list);
 			return ERR_PTR(-ENOMEM);
 		}
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0972ec0e2eb8..0160f237d963 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -822,7 +822,6 @@ int acpi_video_get_levels(struct acpi_device *device,
 
 	br = kzalloc(sizeof(*br), GFP_KERNEL);
 	if (!br) {
-		printk(KERN_ERR "can't allocate memory\n");
 		result = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 3595aa9c7c18..99d7c69eae9b 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -124,7 +124,6 @@ static acpi_status handle_ioapic_add(acpi_handle handle, u32 lvl,
 
 	ioapic = kzalloc(sizeof(*ioapic), GFP_KERNEL);
 	if (!ioapic) {
-		pr_err("cannot allocate memory for new IOAPIC\n");
 		goto exit;
 	} else {
 		ioapic->root_handle = (acpi_handle)context;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 602f8ff212f2..7df7bea1e177 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -652,7 +652,6 @@ int acpi_device_add(struct acpi_device *device,
 
 	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
 	if (!new_bus_id) {
-		pr_err(PREFIX "Memory allocation error\n");
 		result = -ENOMEM;
 		goto err_detach;
 	}
@@ -1579,10 +1578,8 @@ static int acpi_add_single_object(struct acpi_device **child,
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
-	if (!device) {
-		printk(KERN_ERR PREFIX "Memory allocation error\n");
+	if (!device)
 		return -ENOMEM;
-	}
 
 	acpi_init_device_object(device, handle, type, sta);
 	acpi_bus_get_power_flags(device);
-- 
2.14.2

