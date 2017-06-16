From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 3/7] platform/x86: fujitsu-laptop: use strcpy to set ACPI device names and classes
Date: Fri, 16 Jun 2017 06:40:54 +0200
Message-ID: <20170616044058.30443-4-kernel@kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

No formatting is needed when setting ACPI device name and class, so
switch to using strcpy() for this purpose.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index c64d5305ff37..06d04500dac0 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -411,8 +411,8 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	fujitsu_bl = priv;
-	sprintf(acpi_device_name(device), "%s", ACPI_FUJITSU_BL_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
+	strcpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 	device->driver_data = priv;
 
 	error = acpi_fujitsu_bl_input_setup(device);
@@ -800,9 +800,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
 	fext = device;
 
-	sprintf(acpi_device_name(device), "%s",
-		ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
+	strcpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 	device->driver_data = priv;
 
 	error = acpi_fujitsu_laptop_input_setup(device);
-- 
2.13.1
