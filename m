From: Betty Dall <betty.dall@hpe.com>
Subject: [PATCH v3 2/3] ACPI/device_sysfs: Change _SUN and _STA show functions error return to EIO
Date: Sat, 30 Apr 2016 10:03:38 -0600
Message-ID: <1462032219-12590-3-git-send-email-betty.dall@hpe.com>
References: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462032219-12590-1-git-send-email-betty.dall@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Betty Dall <betty.dall@hpe.com>
List-Id: linux-acpi@vger.kernel.org

The error return from a sysfs show function is passed up through
the call chain and visible as the return from the read system call.
The show functions for the _STA and _SUN object currently return
-ENODEV. This patch changes the return to -EIO. ENODEV makes less
sense since the "device' exists or there wouldn't be a sysfs file.

Signed-off-by: Betty Dall <betty.dall@hpe.com>
---
 drivers/acpi/device_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 49cc0cb..e556a3e 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -467,7 +467,7 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
 
 	status = acpi_evaluate_integer(acpi_dev->handle, "_SUN", NULL, &sun);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		return -EIO;
 
 	return sprintf(buf, "%llu\n", sun);
 }
@@ -496,7 +496,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 
 	status = acpi_evaluate_integer(acpi_dev->handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		return -EIO;
 
 	return sprintf(buf, "%llu\n", sta);
 }
-- 
1.9.1
