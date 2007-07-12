From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH] Remove #ifdef CONFIG_PM from ACPI power-off code
Date: Thu, 12 Jul 2007 11:58:40 -0300
Message-ID: <20070712145840.GJ4083@blackpad.ctb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503AbXGLO65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jul 2007 10:58:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

The ACPI poweroff code is inside a #ifdef CONFIG_PM, that was added on
commit b35c67a46b025e8dc320b59fbe5c283094e1d7f5. The #ifdef is not
necessary because the poweroff code compiles and works even if
CONFIG_PM is disabled. This patch removes the #ifdef around the code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 drivers/acpi/sleep/poweroff.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
index d9801ef..5d6ba10 100644
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -37,8 +37,6 @@ #endif
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
 void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
@@ -94,5 +92,3 @@ static int acpi_poweroff_init(void)
 }
 
 late_initcall(acpi_poweroff_init);
-
-#endif				/* CONFIG_PM */
