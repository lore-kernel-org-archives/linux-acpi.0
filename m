From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Hibernation: Make sure that ACPI is enabled in acpi_hibernation_finish
Date: Tue, 21 Aug 2007 23:16:51 +0200
Message-ID: <200708212316.52638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45996 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbXHUVGv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2007 17:06:51 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

If the BIOS does not enable ACPI and the "acpi=off" command line parameter is
passed to the boot kernel, ACPI may be disabled when the (restored) image kernel
attempts to execute acpi_hibernation_finish().  To prevent this from happening
we can call acpi_enable() from acpi_hibernation_finish() (if ACPI is already
enabled, this will have no effect).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/acpi/sleep/main.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.23-rc3/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/sleep/main.c
+++ linux-2.6.23-rc3/drivers/acpi/sleep/main.c
@@ -240,6 +240,11 @@ static int acpi_hibernation_enter(void)
 
 static void acpi_hibernation_finish(void)
 {
+	/*
+	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
+	 * enable it here.
+	 */
+	acpi_enable();
 	acpi_leave_sleep_state(ACPI_STATE_S4);
 	acpi_disable_wakeup_device(ACPI_STATE_S4);
 
