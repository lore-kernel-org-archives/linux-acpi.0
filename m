From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/6] driver core: platform: Remove duplicated device_remove_properties() call
Date: Mon,  5 Nov 2018 17:59:23 +0300
Message-ID: <20181105145928.46819-2-heikki.krogerus@linux.intel.com>
References: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

device_remove_properties() is called for every device in device_del().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..0fb5f140f1b0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -448,7 +448,6 @@ void platform_device_del(struct platform_device *pdev)
 	int i;
 
 	if (pdev) {
-		device_remove_properties(&pdev->dev);
 		device_del(&pdev->dev);
 
 		if (pdev->id_auto) {
-- 
2.19.1
