From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 11/12] PNP / ACPI: join strings back for better maintenance
Date: Tue, 23 May 2017 20:03:26 +0300
Message-ID: <20170523170327.18055-12-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34271 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761390AbdEWRDr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 13:03:47 -0400
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Simply join string literals back for better maintenance and debugging.

No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index af44e57f5148..02ae95a70b7d 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -149,8 +149,8 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 	    uuid_len == sizeof(match->data) &&
 	    memcmp(uuid, match->data, uuid_len) == 0) {
 		if (expected_len && expected_len != actual_len) {
-			dev_err(&dev->dev, "wrong vendor descriptor size; "
-				"expected %d, found %d bytes\n",
+			dev_err(&dev->dev,
+				"wrong vendor descriptor size; expected %d, found %d bytes\n",
 				expected_len, actual_len);
 			return 0;
 		}
@@ -204,9 +204,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 			 * one interrupt, we won't be able to re-encode it.
 			 */
 			if (pnp_can_write(dev)) {
-				dev_warn(&dev->dev, "multiple interrupts in "
-					 "_CRS descriptor; configuration can't "
-					 "be changed\n");
+				dev_warn(&dev->dev,
+					 "multiple interrupts in _CRS descriptor; configuration can't be changed\n");
 				dev->capabilities &= ~PNP_WRITE;
 			}
 		}
@@ -346,8 +345,8 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 			if (p->interrupts[i] < PNP_IRQ_NR)
 				__set_bit(p->interrupts[i], map.bits);
 			else
-				dev_err(&dev->dev, "ignoring IRQ %d option "
-					"(too large for %d entry bitmap)\n",
+				dev_err(&dev->dev,
+					"ignoring IRQ %d option (too large for %d entry bitmap)\n",
 					p->interrupts[i], PNP_IRQ_NR);
 		}
 	}
@@ -948,8 +947,9 @@ int pnpacpi_encode_resources(struct pnp_dev *dev, struct acpi_buffer *buffer)
 		case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
 		case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 		default:	/* other type */
-			dev_warn(&dev->dev, "can't encode unknown resource "
-				 "type %d\n", resource->type);
+			dev_warn(&dev->dev,
+				 "can't encode unknown resource type %d\n",
+				 resource->type);
 			return -EINVAL;
 		}
 		resource++;
-- 
2.11.0

