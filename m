From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/7] ACPI: Separate disabling of GPEs from _PTS
Date: Tue, 8 Jan 2008 00:06:16 +0100
Message-ID: <200801080006.17378.rjw@sisk.pl>
References: <200801080002.25044.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38864 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYAGXKU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2008 18:10:20 -0500
In-Reply-To: <200801080002.25044.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

The preparation to enter an ACPI system sleep state is now tied to
the disabling of GPEs, but the GPEs should not be disabled before
suspending devices.  Since on ACPI 1.0x systems the _PTS global
control method should be executed before suspending devices, we
need to disable GPEs separately.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/acpi/hardware/hwsleep.c |    4 ----
 drivers/acpi/sleep/main.c       |   17 +++++++++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
@@ -229,10 +229,6 @@ acpi_status acpi_enter_sleep_state_prep(
 				"While executing method _SST"));
 	}
 
-	/* Disable/Clear all GPEs */
-
-	status = acpi_hw_disable_all_gpes();
-
 	return_ACPI_STATUS(status);
 }
 
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -91,10 +91,13 @@ static int acpi_pm_open(suspend_state_t 
 
 static int acpi_pm_prepare(void)
 {
-	int error = acpi_sleep_prepare(acpi_target_sleep_state);
+	int error;
 
+	error = acpi_sleep_prepare(acpi_target_sleep_state);
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
+	else if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
+		error = -EFAULT;
 
 	return error;
 }
@@ -261,7 +264,16 @@ static int acpi_hibernation_start(void)
 
 static int acpi_hibernation_prepare(void)
 {
-	return acpi_sleep_prepare(ACPI_STATE_S4);
+	int error;
+
+	error = acpi_sleep_prepare(ACPI_STATE_S4);
+	if (error)
+		return error;
+
+	if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
+		error = -EFAULT;
+
+	return error;
 }
 
 static int acpi_hibernation_enter(void)
@@ -432,6 +444,7 @@ static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
+	acpi_hw_disable_all_gpes();
 }
 
 static void acpi_power_off(void)
