From: akpm@linux-foundation.org
Subject: [patch 4/8] Hibernation: Make sure that ACPI is enabled in acpi_hibernation_finish
Date: Tue, 02 Oct 2007 13:24:08 -0700
Message-ID: <200710022024.l92KO87g020462@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32984 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061AbXJBUZH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 16:25:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rjw@sisk.pl, pavel@ucw.cz

From: Rafael J. Wysocki <rjw@sisk.pl>

If the BIOS does not enable ACPI and the "acpi=off" command line parameter
is passed to the boot kernel, ACPI may be disabled when the (restored)
image kernel attempts to execute acpi_hibernation_finish().  To prevent
this from happening we can call acpi_enable() from
acpi_hibernation_finish() (if ACPI is already enabled, this will have no
effect).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sleep/main.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN drivers/acpi/sleep/main.c~hibernation-make-sure-that-acpi-is-enabled-in-acpi_hibernation_finish drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c~hibernation-make-sure-that-acpi-is-enabled-in-acpi_hibernation_finish
+++ a/drivers/acpi/sleep/main.c
@@ -256,6 +256,11 @@ static int acpi_hibernation_enter(void)
 
 static void acpi_hibernation_finish(void)
 {
+	/*
+	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
+	 * enable it here.
+	 */
+	acpi_enable();
 	acpi_leave_sleep_state(ACPI_STATE_S4);
 	acpi_disable_wakeup_device(ACPI_STATE_S4);
 
_
