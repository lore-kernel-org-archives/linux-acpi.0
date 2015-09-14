From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] acpi-dma: Add support for "dma-names" device property
Date: Mon, 14 Sep 2015 17:37:36 +0300
Message-ID: <1442241456-75340-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1442241456-75340-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442241456-75340-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The current implementation hard codes the two supported channels so that
"tx" is always 0 and "rx" is always 1. This is because there has been no
suitable way in ACPI to name resources.

With _DSD device properties we can finally do this:

	Device (SPI1) {
	    Name (_CRS, ResourceTemplate () {
	        ...
	        FixedDMA (0x0000, 0x0000, Width32bit)
	        FixedDMA (0x0001, 0x0001, Width32bit)
	    })

	    Name (_DSD, Package () {
	        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
	        Package () {
	            Package () {"dma-names", Package () {"tx", "rx"}}
	        },
	    })
	}

The names "tx" and "rx" now provide index of the FixedDMA resource in
question.

Modify acpi_dma_request_slave_chan_by_name() so that it looks for
"dma-names" property first and only then fall back using hardcoded indices.

The DT "dma-names" binding that we reuse for ACPI is documented in
Documentation/devicetree/bindings/dma/dma.txt.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 5a635646e05c..981a38fc4cb8 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -21,6 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
+#include <linux/property.h>
 
 static LIST_HEAD(acpi_dma_list);
 static DEFINE_MUTEX(acpi_dma_lock);
@@ -413,21 +414,29 @@ EXPORT_SYMBOL_GPL(acpi_dma_request_slave_chan_by_index);
  * translate the names "tx" and "rx" here based on the most common case where
  * the first FixedDMA descriptor is TX and second is RX.
  *
+ * If the device has "dma-names" property the FixedDMA descriptor indices
+ * are retrieved based on those. Otherwise the function falls back using
+ * hardcoded indices.
+ *
  * Return:
  * Pointer to appropriate dma channel on success or an error pointer.
  */
 struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
 		const char *name)
 {
-	size_t index;
-
-	if (!strcmp(name, "tx"))
-		index = 0;
-	else if (!strcmp(name, "rx"))
-		index = 1;
-	else
-		return ERR_PTR(-ENODEV);
+	int index;
+
+	index = device_property_match_string(dev, "dma-names", name);
+	if (index < 0) {
+		if (!strcmp(name, "tx"))
+			index = 0;
+		else if (!strcmp(name, "rx"))
+			index = 1;
+		else
+			return ERR_PTR(-ENODEV);
+	}
 
+	dev_dbg(dev, "found DMA channel \"%s\" at index %d\n", name, index);
 	return acpi_dma_request_slave_chan_by_index(dev, index);
 }
 EXPORT_SYMBOL_GPL(acpi_dma_request_slave_chan_by_name);
-- 
2.5.1
