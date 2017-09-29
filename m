From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ACPI-scan: Improve a size determination in three
 functions
Date: Fri, 29 Sep 2017 22:18:58 +0200
Message-ID: <ec5d2c85-2c48-f8b6-9467-5bd6b38bcd0b@users.sourceforge.net>
References: <267c842c-d38a-67be-f61b-a2056f7e71ee@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <267c842c-d38a-67be-f61b-a2056f7e71ee@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Sep 2017 22:00:25 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7df7bea1e177..34bc7274dc8e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -650,7 +650,7 @@ int acpi_device_add(struct acpi_device *device,
 	INIT_LIST_HEAD(&device->del_list);
 	mutex_init(&device->physical_node_lock);
 
-	new_bus_id = kzalloc(sizeof(struct acpi_device_bus_id), GFP_KERNEL);
+	new_bus_id = kzalloc(sizeof(*new_bus_id), GFP_KERNEL);
 	if (!new_bus_id) {
 		result = -ENOMEM;
 		goto err_detach;
@@ -1577,7 +1577,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
 		return -ENOMEM;
 
@@ -1786,7 +1786,7 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 		if (skip)
 			continue;
 
-		dep = kzalloc(sizeof(struct acpi_dep_data), GFP_KERNEL);
+		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
 			return;
 
-- 
2.14.2
