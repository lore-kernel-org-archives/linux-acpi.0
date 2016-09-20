From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/4] mfd: lpc_ich: Do not create iTCO watchdog when WDAT table exists
Date: Tue, 20 Sep 2016 15:30:52 +0300
Message-ID: <20160920123054.195021-3-mika.westerberg@linux.intel.com>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI WDAT table is the preferred way to use hardware watchdog over the
native iTCO_wdt. Windows only uses this table for its hardware watchdog
implementation so we should be relatively safe to trust it has been
validated by OEMs

Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/lpc_ich.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index bd3aa4578346..c8dee47b45d9 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -984,6 +984,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
 	int ret;
 	struct resource *res;
 
+	/* If we have ACPI based watchdog use that instead */
+	if (acpi_has_watchdog())
+		return -ENODEV;
+
 	/* Setup power management base register */
 	pci_read_config_dword(dev, priv->abase, &base_addr_cfg);
 	base_addr = base_addr_cfg & 0x0000ff80;
-- 
2.9.3
