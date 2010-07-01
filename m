From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PM / Hibernate: Fix hibernation_platform_enter()
Date: Thu, 1 Jul 2010 23:58:15 +0200
Message-ID: <201007012358.15229.rjw@sisk.pl>
References: <201007012356.44690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42605 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab0GAWCR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:02:17 -0400
In-Reply-To: <201007012356.44690.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The hibernation_platform_enter() function calls dpm_suspend_noirq()
instead of dpm_resume_noirq() by mistake.  Fix this.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -530,7 +530,7 @@ int hibernation_platform_enter(void)
  Platform_finish:
 	hibernation_ops->finish();
 
-	dpm_suspend_noirq(PMSG_RESTORE);
+	dpm_resume_noirq(PMSG_RESTORE);
 
  Resume_devices:
 	entering_platform_hibernation = false;

