From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/37] Hibernation: Make sure that ACPI is enabled in acpi_hibernation_finish
Date: Wed, 10 Oct 2007 01:06:43 -0400
Message-ID: <1191992804-14965-37-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37367 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbXJJFHT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:19 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <8a0bb7362587807fec985f72fb0317aa8ed24835.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If the BIOS does not enable ACPI and the "acpi=off" command line parameter
is passed to the boot kernel, ACPI may be disabled when the (restored)
image kernel attempts to execute acpi_hibernation_finish().  To prevent
this from happening we can call acpi_enable() from
acpi_hibernation_finish() (if ACPI is already enabled, this will have no
effect).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 2cbb9aa..caf8721 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
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
 
-- 
1.5.3.4.206.g58ba4
