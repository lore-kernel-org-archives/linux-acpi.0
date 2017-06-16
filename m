From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH 2/7] platform/x86: fujitsu-laptop: remove redundant safety checks
Date: Fri, 16 Jun 2017 06:40:53 +0200
Message-ID: <20170616044058.30443-3-kernel@kempniu.pl>
References: <20170616044058.30443-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170616044058.30443-1-kernel@kempniu.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Do not check whether the pointer passed to ACPI add callbacks is NULL as
it is earlier dereferenced anyway in the bus-level probe callback,
acpi_device_probe().

Do not check the value of acpi_disabled in fujitsu_init(), because it is
already done by acpi_bus_register_driver(), which is the first function
called by fujitsu_init().

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 54cb7ae541d4..c64d5305ff37 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -406,9 +406,6 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
 
-	if (!device)
-		return -EINVAL;
-
 	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -796,9 +793,6 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	int error;
 	int i;
 
-	if (!device)
-		return -EINVAL;
-
 	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -993,9 +987,6 @@ static int __init fujitsu_init(void)
 {
 	int ret;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	ret = acpi_bus_register_driver(&acpi_fujitsu_bl_driver);
 	if (ret)
 		return ret;
-- 
2.13.1
