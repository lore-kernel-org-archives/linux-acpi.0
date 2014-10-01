From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH v3 15/15] misc: at25: Add ACPI probing support
Date: Wed, 01 Oct 2014 04:22:27 +0200
Message-ID: <2551386.HUYYQnE3a6@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1852462.V1jlbi8OPt-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Add support for matching using DT compatible string from ACPI _DSD.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
drivers/misc/eeprom/at25.c | 7 +++++++
 drivers/misc/eeprom/at25.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/misc/eeprom/at25.c
===================================================================
--- linux-pm.orig/drivers/misc/eeprom/at25.c
+++ linux-pm/drivers/misc/eeprom/at25.c
@@ -459,11 +459,18 @@ static const struct of_device_id at25_of
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
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
