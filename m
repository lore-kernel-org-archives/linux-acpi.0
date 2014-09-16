From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFC PATCH v2 16/16] misc: at25: Add ACPI probing support
Date: Tue, 16 Sep 2014 14:52:47 +0300
Message-ID: <1410868367-11056-17-git-send-email-mika.westerberg@linux.intel.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Add support for matching using DT compatible string from ACPI _DSD.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 58f6cdd2551c..1a760cd966bd 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -459,11 +459,18 @@ static const struct of_device_id at25_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at25_of_match);
 
+static const struct acpi_device_id at25_acpi_match[] = {
+	{ "PRP0001" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, at25_acpi_match);
+
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.owner		= THIS_MODULE,
 		.of_match_table = at25_of_match,
+		.acpi_match_table = at25_acpi_match,
 	},
 	.probe		= at25_probe,
 	.remove		= at25_remove,
-- 
2.1.0
