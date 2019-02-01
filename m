From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/5] ACPI: EC: Make acpi_ec_dsdt_probe() more straightforward
Date: Fri, 01 Feb 2019 10:59:42 +0100
Message-ID: <1584296.eCrsGTMp5G@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <2804781.zocuRj5ZkX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2804781.zocuRj5ZkX@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_ec_dsdt_probe() returns early if boot_ec is set, it is
always unset when that function calls acpi_config_boot_ec() (passing
ec->handle as the handle argument to it).  Thus it is not really
useful to call acpi_config_boot_ec() at that point.  It is sufficient to
call acpi_ec_setup() directly and (if that is successful) set boot_ec,
so make acpi_ec_dsdt_probe() do that and avoid some pointless checks
in acpi_config_boot_ec().

No intentional functional impact except for a changed message.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1768,9 +1768,16 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
-	if (ret)
+	ret = acpi_ec_setup(ec, false);
+	if (ret) {
 		acpi_ec_free(ec);
+		return;
+	}
+
+	boot_ec = ec;
+
+	acpi_handle_info(ec->handle,
+			 "Boot DSDT EC used to handle transactions\n");
 }
 
 /*
