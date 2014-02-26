From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 4/8] PNPACPI: remove unsupported serial PNP ids from PNPACPI id list
Date: Wed, 26 Feb 2014 17:11:10 +0800
Message-ID: <1393405874-3266-5-git-send-email-rui.zhang@intel.com>
References: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

The "serial" pnp driver supports some unknown PNP modems (PNPCXXX/PNPDXXX)
by matching magic strings in the pnp device name or the pnp device card name.

ACPI enumerated PNP device neither supports pnp card,
nor supports those magic strings in its device name,
which means this mechamism never works for ACPI enumerated
PNPCXXX/PNPDXXX devices.
So it is safe to remove those two ids from the PNPACPI id list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index d47fbdf..36dda39 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -341,8 +341,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[]= {
 	{"LTS0001"}, /* LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in disguise) */
 	{"WCI0003"}, /* Rockwell's (PORALiNK) 33600 INT PNP */
 	{"WEC1022"}, /* Winbond CIR port, should not be probed. We should keep track of it to prevent the legacy serial driver from probing it */
-	{"PNPCXXX"}, /* Unknown PnP modems */
-	{"PNPDXXX"}, /* More unknown PnP modems */
 	/* scl200wdt */
 	{"NSC0800"}, /* National Semiconductor PC87307/PC97307 watchdog component */
 	/* mpu401 */
-- 
1.7.9.5
