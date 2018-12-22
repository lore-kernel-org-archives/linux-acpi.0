From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Date: Sat, 22 Dec 2018 00:14:47 +0000
Message-ID: <20181222001452.7474-7-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Code is scanning PCI bus to find out if it is switchable or not. If
CONFIG_PCI is not set, assume unswitchable.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/apple-gmux.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index fd2ffebc868f..b552b54bf58b 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	 * If Thunderbolt is present, the external DP port is not fully
 	 * switchable. Force its AUX channel to the discrete GPU.
 	 */
+#ifdef CONFIG_PCI
 	gmux_data->external_switchable =
 		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
+#else
+	gmux_data->external_switchable = false;
+#endif
 	if (!gmux_data->external_switchable)
 		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
 
-- 
2.19.0
