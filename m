From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/21] ACPI: ibm-acpi: cleanups, extended fan/thermal support
Date: Sat, 16 Dec 2006 00:43:19 -0500
Message-ID: <200612160043.19918.lenb@kernel.org>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33590 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965331AbWLPFoX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Dec 2006 00:44:23 -0500
In-Reply-To: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

applied, with this update to play with Linux-2.6.20-rc1

thanks,
-Len

commit 25c68a33b7b74b37793b1250007e5e21d621a7fc
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 8 04:43:41 2006 -0500

    ACPI: ibm_acpi: respond to workqueue update
    
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 92e7b6e..ab18007 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1825,9 +1825,9 @@ static enum fan_control_commands fan_control_commands;
 static int fan_control_status_known;
 static u8 fan_control_initial_status;
 
-static void fan_watchdog_fire(void *ignored);
+static void fan_watchdog_fire(struct work_struct *ignored);
 static int fan_watchdog_maxinterval;
-static DECLARE_WORK(fan_watchdog_task, fan_watchdog_fire, NULL);
+static DECLARE_DELAYED_WORK(fan_watchdog_task, fan_watchdog_fire);
 
 static int fan_init(void)
 {
@@ -2284,7 +2284,7 @@ static int fan_write(char *buf)
 	return rc;
 }
 
-static void fan_watchdog_fire(void *ignored)
+static void fan_watchdog_fire(struct work_struct *ignored)
 {
 	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
 	if (fan_set_enable()) {
