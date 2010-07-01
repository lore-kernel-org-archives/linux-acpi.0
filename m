From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] ACPI / Sleep: Do not allocate memory for saving NVS in advance
Date: Fri, 2 Jul 2010 00:11:21 +0200
Message-ID: <201007020011.22118.rjw@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42765 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932574Ab0GAWQx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:16:53 -0400
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org

From: Rafael J. Wysocki <rjw@sisk.pl>

We only can try to allocate memory for saving the NVS region if it
is known that the target system sleep state is valid.  Otherwise
we will leak memory if suspend_nvs_alloc() is successful and the
target state is invalid, because suspend_nvs_free() will not be
called in that case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -195,20 +195,15 @@ static u32 acpi_suspend_states[] = {
 static int acpi_suspend_begin(suspend_state_t pm_state)
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
-	int error = 0;
-
-	error = suspend_nvs_alloc();
-
-	if (error)
-		return error;
+	int error = -ENOSYS;
 
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
+		error = suspend_nvs_alloc();
 	} else {
 		printk(KERN_ERR "ACPI does not support this state: %d\n",
 			pm_state);
-		error = -ENOSYS;
 	}
 	return error;
 }
