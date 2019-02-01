From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/5] ACPI: EC: Make acpi_ec_ecdt_probe() more straightforward
Date: Fri, 01 Feb 2019 10:58:20 +0100
Message-ID: <8113695.UgGZYynV14@aspire.rjw.lan>
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

Since acpi_ec_ecdt_probe() is called when boot_ec is not set, it
doesn't neeed to take the other possibility into account.

Accordingly, it only needs to set the handle field in the ec object
to ACPI_ROOT_OBJECT, call acpi_ec_setup() and (if that is successful)
set boot_ec to ec and boot_ec_is_ecdt to 'true'.  Make it do so
directly, without calling acpi_config_boot_ec(), and avoid some
pointless checks in the latter.

No intentional functional impact except for a changed message.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1907,14 +1907,22 @@ void __init acpi_ec_ecdt_probe(void)
 		ec->data_addr = ecdt_ptr->data.address;
 	}
 	ec->gpe = ecdt_ptr->gpe;
+	ec->handle = ACPI_ROOT_OBJECT;
 
 	/*
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ACPI_ROOT_OBJECT, false, true);
-	if (ret)
+	ret = acpi_ec_setup(ec, false);
+	if (ret) {
 		acpi_ec_free(ec);
+		return;
+	}
+
+	boot_ec = ec;
+	boot_ec_is_ecdt = true;
+
+	pr_info("Boot ECDT EC used to handle transactions\n");
 }
 
 #ifdef CONFIG_PM_SLEEP
