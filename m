From: John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI / scan: Add static attribute to indirect_io_hosts[]
Date: Tue, 7 Aug 2018 21:15:05 +0800
Message-ID: <1533647705-34313-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Array indirect_io_hosts[] is declared in acpi_is_indirect_io_slave() as a
const array, which means that the array will be re-built for each call.

Optimise by adding the static attribute, which means that the array is
added to const-data pool and not re-built per function call.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 970dd87..199c8ea6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1528,7 +1528,7 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
 static bool acpi_is_indirect_io_slave(struct acpi_device *device)
 {
 	struct acpi_device *parent = device->parent;
-	const struct acpi_device_id indirect_io_hosts[] = {
+	static const struct acpi_device_id indirect_io_hosts[] = {
 		{"HISI0191", 0},
 		{}
 	};
-- 
1.9.1
