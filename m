From: Darren Jenkins <darrenrjenkins@gmail.com>
Subject: [PATCH] drivers: acpi: fan.c move a dereference below the NULL test
Date: Thu, 11 Feb 2010 20:56:42 +1100
Message-ID: <1265882202.27789.0.camel@ICE-BOX>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Janitors <kernel-janitors@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

In acpi_fan_remove() device is being dereferenced before the NULL test.
This reorders the code to ensure it is checked for NULL first.

Coverity CID: 2758

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
---
 drivers/acpi/fan.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index acf2ab2..dc39640 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -298,9 +298,14 @@ static int acpi_fan_add(struct acpi_device *device)
 
 static int acpi_fan_remove(struct acpi_device *device, int type)
 {
-	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+	struct thermal_cooling_device *cdev;
+
+	if (!device)
+		return -EINVAL;
+
+	cdev = acpi_driver_data(device);
 
-	if (!device || !cdev)
+	if (!cdev)
 		return -EINVAL;
 
 	acpi_fan_remove_fs(device);
-- 
1.6.3.3
