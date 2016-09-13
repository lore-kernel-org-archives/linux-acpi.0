From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/4] i2c: i801: Do not create iTCO watchdog when WDAT table exists
Date: Tue, 13 Sep 2016 18:23:35 +0300
Message-ID: <20160913152336.75405-4-mika.westerberg@linux.intel.com>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:31021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758552AbcIMPXl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 11:23:41 -0400
In-Reply-To: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

ACPI WDAT table is the preferred way to use hardware watchdog over the
native iTCO_wdt. Windows only uses this table for its hardware watchdog
implementation so we should be relatively safe to trust it has been
validated by OEMs

Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ef9b733d153..26298af73232 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1486,7 +1486,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		priv->features |= FEATURE_IRQ;
 		priv->features |= FEATURE_SMBUS_PEC;
 		priv->features |= FEATURE_BLOCK_BUFFER;
-		priv->features |= FEATURE_TCO;
+		/* If we have ACPI based watchdog use that instead */
+		if (!acpi_has_watchdog())
+			priv->features |= FEATURE_TCO;
 		priv->features |= FEATURE_HOST_NOTIFY;
 		break;
 
-- 
2.9.3

