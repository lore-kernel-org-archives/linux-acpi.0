From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] ACPICA: Refuse enabling GPEs with no handling
Date: Mon, 14 Jul 2014 22:41:01 +0200
Message-ID: <7518885.g0HdNb24nN@vostro.rjw.lan>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49751 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756889AbaGNUXd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 16:23:33 -0400
In-Reply-To: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make acpi_enable_gpe() refuse to enable a given GPE if there is no
way to handle it and return an error instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -129,7 +129,8 @@ acpi_status acpi_enable_gpe(acpi_handle
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (gpe_event_info) {
+	if (gpe_event_info &&
+	    (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) != ACPI_GPE_DISPATCH_NONE) {
 		status = acpi_ev_add_gpe_reference(gpe_event_info);
 	}
 

