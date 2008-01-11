From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Make sleep/main.c compile with CONFIG_PM_SLEEP unset
Date: Fri, 11 Jan 2008 23:59:55 +0100
Message-ID: <200801112359.55832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59194 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760343AbYAKW5f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 17:57:35 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

[Len, this patch applies on top of the suspend branch, please add.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

Make drivers/acpi/sleep/main.c compile with CONFIG_PM_SLEEP unset

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -23,9 +23,9 @@
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
+static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 #ifdef CONFIG_PM_SLEEP
-static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 static bool acpi_sleep_finish_wake_up;
 
 /*
