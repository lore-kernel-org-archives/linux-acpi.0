From: Joe Perches <joe@perches.com>
Subject: [PATCH 03/25] drivers/acpi: Use static const char arrays
Date: Mon, 13 Sep 2010 12:47:41 -0700
Message-ID: <586912c51cea49db9bb042a9badae0bbe8cba529.1284406638.git.joe@perches.com>
References: <cover.1284406638.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1284406638.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/acpi/sleep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index cf82989..566b1cdd 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -567,7 +567,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
 	struct acpi_device *adev;
-	char acpi_method[] = "_SxD";
+	char acpi_method[sizeof("_SxD")];
 	unsigned long long d_min, d_max;
 
 	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
@@ -575,7 +575,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 		return -ENODEV;
 	}
 
-	acpi_method[2] = '0' + acpi_target_sleep_state;
+	sprintf(acpi_method, "_S%cD", '0' + acpi_target_sleep_state);
 	/*
 	 * If the sleep state is S0, we will return D3, but if the device has
 	 * _S0W, we will use the value from _S0W
-- 
1.7.3.rc1
