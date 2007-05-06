From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 1/4] asus-laptop notify ALL events
Date: Sun, 6 May 2007 14:46:41 +0200
Message-ID: <200705061446.41838.corentincj@iksaif.net>
References: <200705061445.03504.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:40135 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbXEFMqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2007 08:46:43 -0400
In-Reply-To: <200705061445.03504.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

We need to handle all events, because some dsdt use events >= 0x80

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/asus-laptop.c	2007-05-04 21:44:35.000000000 +0200
+++ b/drivers/misc/asus-laptop.c	2007-05-05 09:20:11.000000000 +0200
@@ -950,7 +950,7 @@
 	 * We install the handler, it will receive the hotk in parameter, so, we
 	 * could add other data to the hotk struct
 	 */
-	status = acpi_install_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
+	status = acpi_install_notify_handler(hotk->handle, ACPI_ALL_NOTIFY,
 					     asus_hotk_notify, hotk);
 	if (ACPI_FAILURE(status))
 		printk(ASUS_ERR "Error installing notify handler\n");
@@ -997,7 +997,7 @@
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
+	status = acpi_remove_notify_handler(hotk->handle, ACPI_ALL_NOTIFY,
 					    asus_hotk_notify);
 	if (ACPI_FAILURE(status))
 		printk(ASUS_ERR "Error removing notify handler\n");
