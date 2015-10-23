From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI: Can I use I2cSerialBus with a PCI I2C controller?
Date: Fri, 23 Oct 2015 11:20:54 +0300
Message-ID: <20151023082054.GP1526@lahna.fi.intel.com>
References: <CAE7DoPZs69A5vLzDfrRXuC3q9fpkaXRYna2NQwHZk_BK9gLnvQ@mail.gmail.com>
 <20151021085056.GV1526@lahna.fi.intel.com>
 <CAE7DoPak939WjCWaGQw7W6aR0dZOcJCjcQK8gMa9iu+WRmnDDw@mail.gmail.com>
 <20151022080157.GI1526@lahna.fi.intel.com>
 <CAE7DoPY8+zw4xw0hWTmPoG4iPgC=2JRCT4bHqeqqaH+BywTWpw@mail.gmail.com>
 <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9080 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbJWIU5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Oct 2015 04:20:57 -0400
Content-Disposition: inline
In-Reply-To: <CAE7DoPZfLDEBmeODQv3oEbs033gpq4oSA=Sx15wMajzVUbUinw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-acpi@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2015 at 12:17:58PM -0500, Ben Gardner wrote:
> > The next issue is that the I2C-core isn't matching the device to the
> > "at24" driver, which has the alias "24c02".
> 
> Here is what I found.
> i2c-core is creating the device with the ACPI name "24C02:00".
> The at24 driver uses "24c02" as the alias.
> i2c-code is matching devices to drivers using strcmp().
> 
> Result: no match. ("24c02" != "24C02:00").
> 
> If I modify acpi_i2c_add_device() to cut off the name at the ':' and
> covert to lowercase when populating info.type, it matches and works.
> I must be missing something here, because this would have never worked as-is.
> I'll ask on the I2C mailing list.

You should either use proper _HID/_CID for the device or put "PRP0001"
to the _HID and let the match happen with DT .compatible strings. I've
attached a hack that I use locally.

The corresponding ASL fragment would look like:


        Device (AT24)
        {
            Name (_HID, "PRP0001")

            Method (_CRS, 0, Serialized) {
                Name (UBUF, ResourceTemplate () {
                    I2cSerialBus (0x50, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C6",
                        0x00, ResourceConsumer)
                })
                Return (UBUF)
            }

            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"compatible", "atmel,24c02"},
                    Package () {"size", 256},
                    Package () {"pagesize", 32},
                    Package () {"abs-value", 1},
                },
            })

            Method (_STA, 0, NotSerialized)
            {
                Return (0xF)
            }
        }

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-misc-at24-Make-use-of-device-property-API.patch"

>From 78792d4e759f023975700222caffa7a20f77fcf9 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Mon, 29 Sep 2014 13:11:07 +0300
Subject: [PATCH] misc/at24: Make use of device property API

Not-Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/misc/eeprom/at24.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c6cb7f8f325e..d2963b5632d4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -20,9 +20,9 @@
 #include <linux/log2.h>
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
-#include <linux/of.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
+#include <linux/property.h>
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -443,26 +443,24 @@ static ssize_t at24_macc_write(struct memory_accessor *macc, const char *buf,
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_OF
-static void at24_get_ofdata(struct i2c_client *client,
+static int at24_get_fwdata(struct i2c_client *client,
 		struct at24_platform_data *chip)
 {
-	const __be32 *val;
-	struct device_node *node = client->dev.of_node;
-
-	if (node) {
-		if (of_get_property(node, "read-only", NULL))
-			chip->flags |= AT24_FLAG_READONLY;
-		val = of_get_property(node, "pagesize", NULL);
-		if (val)
-			chip->page_size = be32_to_cpup(val);
-	}
+	if (device_property_present(&client->dev, "read-only"))
+		chip->flags |= AT24_FLAG_READONLY;
+	if (device_property_read_u16(&client->dev, "pagesize", &chip->page_size))
+		return -ENODEV;
+	if (device_property_read_u32(&client->dev, "size", &chip->byte_len))
+		return -ENODEV;
+
+	return 0;
 }
-#else
-static void at24_get_ofdata(struct i2c_client *client,
-		struct at24_platform_data *chip)
-{ }
-#endif /* CONFIG_OF */
+
+static const struct of_device_id at24_of_match[] = {
+	{ .compatible = "atmel,24c02" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, at24_of_match);
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -477,7 +475,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
-	} else {
+	} else if (id) {
 		if (!id->driver_data)
 			return -ENODEV;
 
@@ -493,10 +491,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		chip.page_size = 1;
 
 		/* update chipdata if OF is present */
-		at24_get_ofdata(client, &chip);
+		at24_get_fwdata(client, &chip);
 
 		chip.setup = NULL;
 		chip.context = NULL;
+	} else {
+		memset(&chip, 0, sizeof(chip));
+		err = at24_get_fwdata(client, &chip);
+		if (err)
+			return err;
 	}
 
 	if (!is_power_of_2(chip.byte_len))
@@ -661,6 +664,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.of_match_table = at24_of_match,
 	},
 	.probe = at24_probe,
 	.remove = at24_remove,
-- 
2.6.1


--YZ5djTAD1cGYuMQK--
