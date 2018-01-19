From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: ACPI: sbshc: remove raw pointer from printk message
Date: Fri, 19 Jan 2018 10:06:03 +0100
Message-ID: <20180119090603.GA7775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754217AbeASJGG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2018 04:06:06 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Wang Qize <wang_qize@venustech.com.cn>

There's no need to be printing a raw kernel pointer to the kernel log at
every boot.  So just remove it, and change the whole message to use the
correct dev_info() call at the same time.

Reported-by: Wang Qize <wang_qize@venustech.com.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 2fa8304171e0..217e1caf58d6 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -275,8 +275,8 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",
+		 hc->offset, hc->query_bit);
 
 	return 0;
 }
