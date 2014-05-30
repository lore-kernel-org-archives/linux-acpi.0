From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/10] ACPI / scan: drop unsupported serial IDs from PNP ACPI scan handler ID list
Date: Fri, 30 May 2014 04:25:15 +0200
Message-ID: <467145822.VTdhhHFzgR@vostro.rjw.lan>
References: <1400781753-2682-1-git-send-email-rui.zhang@intel.com> <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35042328.kk6ZUUdfyN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.garrett@nebula.com, mika.westerberg@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The "serial" PNP driver supports some "unknown" PNP modems
(PNPCXXX/PNPDXXX) by matching magic strings in the PNP device name
or the PNP device card name.

ACPI enumerated PNP devices neither are PNP cards, nor have those
magic strings in device names, so this mechamism never actually works
for ACPI enumerated PNPCXXX/PNPDXXX devices.

Consequently, it is safe to remove those two IDs from the PNP ACPI scan
handler's device ID list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
[rjw: Subject and changelog]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
drivers/acpi/acpi_pnp.c | 2 --
 drivers/acpi/acpi_pnp.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/acpi/acpi_pnp.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_pnp.c
+++ linux-pm/drivers/acpi/acpi_pnp.c
@@ -301,8 +301,6 @@ static const struct acpi_device_id acpi_
 	{"LTS0001"},		/* LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in disguise) */
 	{"WCI0003"},		/* Rockwell's (PORALiNK) 33600 INT PNP */
 	{"WEC1022"},		/* Winbond CIR port, should not be probed. We should keep track of it to prevent the legacy serial driver from probing it */
-	{"PNPCXXX"},		/* Unknown PnP modems */
-	{"PNPDXXX"},		/* More unknown PnP modems */
 	/* scl200wdt */
 	{"NSC0800"},		/* National Semiconductor PC87307/PC97307 watchdog component */
 	/* mpu401 */
