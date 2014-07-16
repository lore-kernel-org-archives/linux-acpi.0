From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 2/3] ACPICA: Refuse to enable GPEs with no handling
Date: Thu, 17 Jul 2014 01:45:38 +0200
Message-ID: <3115590.393nAKLrUK@vostro.rjw.lan>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan> <7518885.g0HdNb24nN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56820 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752603AbaGPX1W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2014 19:27:22 -0400
In-Reply-To: <7518885.g0HdNb24nN@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make acpi_enable_gpe() refuse to enable a given GPE if there is no
way to handle it and return an error instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Updated as requested by Bob.

---
 drivers/acpi/acpica/evxfgpe.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -118,7 +118,7 @@ ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
 
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_BAD_PARAMETER;
+	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
@@ -129,7 +129,12 @@ acpi_status acpi_enable_gpe(acpi_handle
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (gpe_event_info) {
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+	} else if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+					ACPI_GPE_DISPATCH_NONE) {
+		status = AE_NO_HANDLER;
+	} else {
 		status = acpi_ev_add_gpe_reference(gpe_event_info);
 	}
 

