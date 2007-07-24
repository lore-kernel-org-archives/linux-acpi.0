From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Remove references to ACPI_STATE_S2 from acpi_pm_enter
Date: Tue, 24 Jul 2007 11:58:39 +0200
Message-ID: <200707241158.40282.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54053 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764280AbXGXJun (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2007 05:50:43 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove references to ACPI_STATE_S2, introduced by
acpi-implement-the-set_target-callback-from-pm_ops.patch, from acpi_pm_enter().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 drivers/acpi/sleep/main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc1/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.23-rc1.orig/drivers/acpi/sleep/main.c	2007-07-23 22:28:36.000000000 +0200
+++ linux-2.6.23-rc1/drivers/acpi/sleep/main.c	2007-07-24 11:38:46.000000000 +0200
@@ -80,8 +80,8 @@ static int acpi_pm_prepare(void)
  *	acpi_pm_enter - Actually enter a sleep state.
  *	@pm_state: ignored
  *
- *	Flush caches and go to sleep. For STR or S2, we have to call
- *	arch-specific assembly, which in turn call acpi_enter_sleep_state().
+ *	Flush caches and go to sleep. For STR we have to call arch-specific
+ *	assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
 
@@ -94,7 +94,7 @@ static int acpi_pm_enter(suspend_state_t
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* Do arch specific saving of state. */
-	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3) {
+	if (acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
 
 		if (error) {
@@ -111,7 +111,6 @@ static int acpi_pm_enter(suspend_state_t
 		status = acpi_enter_sleep_state(acpi_state);
 		break;
 
-	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel();
 		break;
@@ -135,7 +134,7 @@ static int acpi_pm_enter(suspend_state_t
 	printk(KERN_DEBUG "Back to C!\n");
 
 	/* restore processor state */
-	if (acpi_state == ACPI_STATE_S2 || acpi_state == ACPI_STATE_S3)
+	if (acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
