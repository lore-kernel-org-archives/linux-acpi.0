From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Make acpi_pm_device_sleep_state() follow the specification
Date: Sat, 26 May 2012 00:04:02 +0200
Message-ID: <201205260004.02778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37888 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab2EYV7F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2012 17:59:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The comparison between the system sleep state being entered
and the lowest system sleep state the given device may wake up
from in acpi_pm_device_sleep_state() is reversed, because the
specification (ACPI 5.0) says that for wakeup to work:

"The sleeping state being entered must be less than or equal to the
 power state declared in element 1 of the _PRW object."

Moreover, it also should check if the wakeup capability is supported
through ACPI, because in principle it may be done via native PCIe
PME, for example.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -732,8 +732,8 @@ int acpi_pm_device_sleep_state(struct de
 	 * can wake the system.  _S0W may be valid, too.
 	 */
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
-	    (device_may_wakeup(dev) &&
-	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
+	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
+	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
 		acpi_status status;
 
 		acpi_method[3] = 'W';
