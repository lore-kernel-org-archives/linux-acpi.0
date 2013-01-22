From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ACPI / PM: Fix device power state value after transitions to D3cold
Date: Tue, 22 Jan 2013 13:18 +0100
Message-ID: <3543306.ZHWZyu77Fs@vostro.rjw.lan>
References: <4115893.XLRCUukpRD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49679 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab3AVMMD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2013 07:12:03 -0500
In-Reply-To: <4115893.XLRCUukpRD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When a transition to the D3cold power state is requested,
acpi_device_set_power() first carries out a transition to D3hot and
then turns off the device's power resources.  However, it fails to
update the device's power.state field appropriately and D3hot is
stored in it as a result.

Fix this, but make sure that the device's power.state value will be
D3hot if its power resources cannot be turned off in the final step.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -264,8 +264,11 @@ int acpi_device_set_power(struct acpi_de
 	if (result)
 		goto end;
 
-	if (cut_power)
-		result = acpi_power_transition(device, ACPI_STATE_D3_COLD);
+	if (cut_power) {
+		device->power.state = state;
+		state = ACPI_STATE_D3_COLD;
+		result = acpi_power_transition(device, state);
+	}
 
  end:
 	if (result) {

