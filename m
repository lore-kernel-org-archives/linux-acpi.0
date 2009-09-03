From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: ACPI: EC: wait for ongoing transactions before suspending
Date: Thu, 03 Sep 2009 16:36:56 +0100
Message-ID: <4A9FE298.4050303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54036 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZICPg6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2009 11:36:58 -0400
Received: by fxm17 with SMTP id 17so20248fxm.37
        for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2009 08:37:00 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>

If a transaction is started just before suspend we should wait for it
before disabling the GPE.  Otherwise the GPE could be re-enabled by the
"disable gpe during transactions" workaround (EC_FLAGS_GPE_STORM).

I hope this also solves EC timeouts and resume hangs when pressing acpi
hotkeys during hibernation.  However this problem is difficult to
reproduce and I have not been able to confirm the fix.

References: http://bugzilla.kernel.org/show_bug.cgi?id=14112

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 64a20ef..6fd1be2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -979,7 +979,9 @@ static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
 {
 	struct acpi_ec *ec = acpi_driver_data(device);
 	/* Stop using GPE */
+	mutex_lock(&ec->lock);
 	acpi_disable_gpe(NULL, ec->gpe);
+	mutex_unlock(&ec->lock);
 	return 0;
 }
 


