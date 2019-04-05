From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Fri, 5 Apr 2019 22:21:12 +0800
Message-ID: <20190405142112.26592-1-yuehaibing@huawei.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-acpi@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building CONFIG_ACPI is not set
gcc warn this:

drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
   put_device(&adev->dev);
                   ^
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: rework patch use put_acpi_device helper
---
 drivers/gpio/gpio-merrifield.c | 2 +-
 include/linux/acpi.h           | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 2383dc7..99ca18c 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -385,7 +385,7 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
 	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
 	if (adev) {
 		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
-		put_device(&adev->dev);
+		put_acpi_device(adev);
 	} else {
 		name = "pinctrl-merrifield";
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a1bd789..2563e13 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1331,12 +1331,19 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 #ifdef CONFIG_ACPI
 extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+
+static inline void put_acpi_device(struct acpi_device *adev)
+{
+	put_device(&adev->dev);
+}
 #else
 static inline int
 acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
 	return 0;
 }
+
+static inline void put_acpi_device(struct acpi_device *adev) {}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
-- 
2.7.4
