From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 04/11] ACPI: remove unsupported serial PNP ids from acpi pnp scan handler id lsit
Date: Mon, 17 Mar 2014 01:03:10 +0800
Message-ID: <1394989397-2733-5-git-send-email-rui.zhang@intel.com>
References: <1394989397-2733-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394989397-2733-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

The "serial" pnp driver supports some unknown PNP modems (PNPCXXX/PNPDXXX)
by matching magic strings in the pnp device name or the pnp device card name.

ACPI enumerated PNP device neither supports pnp card, nor supports those magic
strings in its device name, which means this mechamism never works for ACPI
enumerated PNPCXXX/PNPDXXX devices.
So it is safe to remove those two ids from the ACPI pnp scan handler id list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_pnp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index db49e9e..2a7f86f 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -300,8 +300,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[]= {
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
