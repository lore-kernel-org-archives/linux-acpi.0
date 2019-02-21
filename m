From: egranata@chromium.org
Subject: [PATCH v3] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
Date: Thu, 21 Feb 2019 11:34:29 -0800
Message-ID: <20190221193429.161300-1-egranata@chromium.org>
References: <20190220180538.GA42642@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220180538.GA42642@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gwendal@chromium.org, briannorris@chromium.org, hdegoede@redhat.com, mika.westerberg@linux.intel.com, dtor@chromium.org, andy.shevchenko@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org, enric.balletbo@collabora.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc: egranata@google.com, Enrico Granata <egranata@chromium.org>
List-Id: linux-acpi@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

ACPI 5 added support for GpioInt resources as a way to provide
information about interrupts mediated via a GPIO controller.

Several device buses (e.g. SPI, I2C) have support for retrieving
an IRQ specified via this type of resource, and providing it
directly to the driver as an IRQ number.

This is not currently done for the platform drivers, as platform_get_irq()
does not try to parse GpioInt() resources. This requires drivers to
either have to support only one possible IRQ resource, or to have code
in place to try both as a failsafe.

While there is a possibility of ambiguity for devices that exposes
multiple IRQs, it is easy and feasible to support the common case
of devices that only expose one IRQ which would be of either type
depending on the underlying system's architecture.

This commit adds support for parsing a GpioInt resource in order
to fulfill a request for the index 0 IRQ for a platform device.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
Changes in v3:
 - ensured that -ENOENT return from acpi_dev_gpio_irq_get is not propagated
   upwards, as some drivers expect platform_get_irq to return either a valid
   IRQ or -ENXIO and will break otherwise

 drivers/base/platform.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4d..afd8b916303e4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -127,7 +127,24 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	/*
+	 * For the index 0 interrupt, allow falling back to GpioInt
+	 * resources. While a device could have both Interrupt and GpioInt
+	 * resources, making this fallback ambiguous, in many common cases
+	 * the device will only expose one IRQ, and this fallback
+	 * allows a common code path across either kind of resource.
+	 */
+	if (num == 0 && has_acpi_companion(&dev->dev)) {
+		int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+
+		if (ret > 0 || ret == -EPROBE_DEFER)
+			return ret;
+	}
+
+	return -ENXIO;
 #endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
-- 
2.21.0.rc0.258.g878e2cd30e-goog
