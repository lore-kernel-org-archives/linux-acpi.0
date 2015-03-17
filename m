From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / sleep: Drop acpi_suspend() which is not used
Date: Tue, 17 Mar 2015 15:29:23 +0100
Message-ID: <1460987.2Zo06X0UeC@vostro.rjw.lan>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <20150317123536.GB14984@red-moon> <CAGHbJ3DhUB688K7ooT7ai=2QjRp7S+_E_Y+a+GupeTvjR5omMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64339 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753091AbbCQOFb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 10:05:31 -0400
In-Reply-To: <CAGHbJ3DhUB688K7ooT7ai=2QjRp7S+_E_Y+a+GupeTvjR5omMg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The acpi_suspend() function has no callers, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   15 ---------------
 drivers/acpi/sleep.h |    2 --
 2 files changed, 17 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -806,21 +806,6 @@ static void acpi_sleep_hibernate_setup(v
 static inline void acpi_sleep_hibernate_setup(void) {}
 #endif /* !CONFIG_HIBERNATION */
 
-int acpi_suspend(u32 acpi_state)
-{
-	suspend_state_t states[] = {
-		[1] = PM_SUSPEND_STANDBY,
-		[3] = PM_SUSPEND_MEM,
-		[5] = PM_SUSPEND_MAX
-	};
-
-	if (acpi_state < 6 && states[acpi_state])
-		return pm_suspend(states[acpi_state]);
-	if (acpi_state == 4)
-		return hibernate();
-	return -EINVAL;
-}
-
 static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -1,6 +1,4 @@
 
-extern int acpi_suspend(u32 state);
-
 extern void acpi_enable_wakeup_devices(u8 sleep_state);
 extern void acpi_disable_wakeup_devices(u8 sleep_state);
 

