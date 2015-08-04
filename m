From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Tue,  4 Aug 2015 16:01:59 -0700
Message-ID: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-acpi@vger.kernel.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Fixes the following build error when building drivers as modules:

 ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko] undefined!
 ERROR: "acpi_dev_prop_read_single" [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7836e2e..237e3c5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -432,6 +432,7 @@ int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(acpi_dev_prop_read_single);
 
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
 				       size_t nval)
-- 
1.7.11.7
