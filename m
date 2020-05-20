Return-Path: <SRS0=fe6V=7C=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA1C433DF
	for <linux-acpi@archiver.kernel.org>; Wed, 20 May 2020 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438C020885
	for <linux-acpi@archiver.kernel.org>; Wed, 20 May 2020 21:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgETVTV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 20 May 2020 17:19:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:48520 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgETVTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 17:19:21 -0400
IronPort-SDR: LtL66iIpzujCmj+BaHTayxod5AiA0ybTuKl1ZnBsWLJNABBOpZhFUC7iNkPGu5fQfkWrS1T3X4
 do2oDqE/EyRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 14:19:20 -0700
IronPort-SDR: IP3AoAyugHNk0b4bG3RfmhYQNL4HqzmBcTUqurzcE8+SeEPIblgyF3WYnIimzVx8f4B6slN1DU
 I0zc0WtMRuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="440189894"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2020 14:19:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C7A78D2; Thu, 21 May 2020 00:19:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] gpiolib: acpi: Introduce a quirk to force GpioInt pin
Date:   Thu, 21 May 2020 00:19:13 +0300
Message-Id: <20200520211916.25727-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some ACPI tables have broken GpioInt() pin number, i.e.
Intel Galileo gen 2 board, where it by some reason refers to
the absolute one instead of being relative to the controller.

In order to work around, introduce a new quirk to force this number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c   | 9 +++++++--
 include/linux/gpio/consumer.h | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 3aa976f9ad1a..93f3c833f3c7 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -651,6 +651,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		const struct acpi_resource_gpio *agpio = &ares->data.gpio;
 		bool gpioint = agpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT;
 		int pin_index;
+		u16 pin;
 
 		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
 			lookup->index++;
@@ -662,8 +663,12 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		if (pin_index >= agpio->pin_table_length)
 			return 1;
 
-		lookup->desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
-					      agpio->pin_table[pin_index]);
+		if (lookup->info.quirks & ACPI_GPIO_QUIRK_FORCE_PIN)
+			pin = lookup->info.quirks_data;
+		else
+			pin = agpio->pin_table[pin_index];
+
+		lookup->desc = acpi_get_gpiod(agpio->resource_source.string_ptr, pin);
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.gpioint = gpioint;
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 49743a499fda..e6bacebcecb7 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -674,6 +674,12 @@ struct acpi_gpio_mapping {
  * get GpioIo type explicitly, this quirk may be used.
  */
 #define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
+/*
+ * Some ACPI tables may have wrong pin defined. Allow to force the pin
+ * number if quirk is provided. New pin number should be provided via
+ * @quirks_data field.
+ */
+#define ACPI_GPIO_QUIRK_FORCE_PIN		BIT(2)
 
 	unsigned int quirks;
 	unsigned long quirks_data;
-- 
2.26.2

