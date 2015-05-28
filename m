From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Add missing pm_generic_complete() invocation
Date: Thu, 28 May 2015 04:14:26 +0200
Message-ID: <1953564.jDurFWLRsc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46962 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751696AbbE1Bs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2015 21:48:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add missing invocation of pm_generic_complete() to
acpi_subsys_complete() to allow ->complete callbacks provided
by the drivers of devices using the ACPI PM domain to be executed
during system resume.

Fixes: f25c0ae2b4c4 (ACPI / PM: Avoid resuming devices in ACPI PM domain during system suspend)
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -972,6 +972,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
  */
 void acpi_subsys_complete(struct device *dev)
 {
+	pm_generic_complete(dev);
 	/*
 	 * If the device had been runtime-suspended before the system went into
 	 * the sleep state it is going out of and it has never been resumed till

