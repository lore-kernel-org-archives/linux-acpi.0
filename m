From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/12] gpio: acpi: Even more tighten up ACPI GPIO lookups
Date: Tue, 23 May 2017 20:03:19 +0300
Message-ID: <20170523170327.18055-5-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

The commit 10cf4899f8af ("gpiolib: tighten up ACPI legacy gpio lookups")
prevents to getting same resource twice if the driver asks twice using
different connection ID.

But the whole idea of fallback might bring some problems. Imagine the case when
we have two versions of BIOS/hardware where in one _DSD is introduced along
with GPIO resources, but the other one uses just plain GPIO resource for
another purpose

Case 1:

    Device (DEVX)
    {
        ...
        Name (_CRS, ResourceTemplate ()
        {
            GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                    "\\_SB.GPO0", 0, ResourceConsumer) {15}
        })
        Name (_DSD, Package ()
        {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                Package () {"some-gpios", Package() {^DEVX, 0, 0, 0 }},
            }
        })
    }

Case 2:

    Device (DEVX)
    {
        ...
        Name (_CRS, ResourceTemplate ()
        {
            GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                    "\\_SB.GPO0", 0, ResourceConsumer) {27}
        })
    }

To prevent the possible misconfiguration tighten up even more GPIO ACPI lookups
for case without connection ID provided.

In the past the issue had been triggered by "use mctrl_gpio helpers" series
[1,2].

[1] commit 4ef03d328769 ("tty/serial/8250: use mctrl_gpio helpers")
[2] https://patchwork.kernel.org/patch/9283745/

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 28f35a9de86b..0392d8ed332f 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1129,45 +1129,11 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 	return count ? count : -ENOENT;
 }
 
-struct acpi_crs_lookup {
-	struct list_head node;
-	struct acpi_device *adev;
-	const char *con_id;
-};
-
-static DEFINE_MUTEX(acpi_crs_lookup_lock);
-static LIST_HEAD(acpi_crs_lookup_list);
-
 bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
 {
-	struct acpi_crs_lookup *l, *lookup = NULL;
-
 	/* Never allow fallback if the device has properties */
 	if (adev->data.properties || adev->driver_gpios)
 		return false;
 
-	mutex_lock(&acpi_crs_lookup_lock);
-
-	list_for_each_entry(l, &acpi_crs_lookup_list, node) {
-		if (l->adev == adev) {
-			lookup = l;
-			break;
-		}
-	}
-
-	if (!lookup) {
-		lookup = kmalloc(sizeof(*lookup), GFP_KERNEL);
-		if (lookup) {
-			lookup->adev = adev;
-			lookup->con_id = kstrdup(con_id, GFP_KERNEL);
-			list_add_tail(&lookup->node, &acpi_crs_lookup_list);
-		}
-	}
-
-	mutex_unlock(&acpi_crs_lookup_lock);
-
-	return lookup &&
-		((!lookup->con_id && !con_id) ||
-		 (lookup->con_id && con_id &&
-		  strcmp(lookup->con_id, con_id) == 0));
+	return con_id == NULL;
 }
-- 
2.11.0
