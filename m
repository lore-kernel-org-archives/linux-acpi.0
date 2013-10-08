From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RESEND/PATCH 1/2] acpi: fan: trivial style cleanup
Date: Mon,  7 Oct 2013 22:08:37 -0500
Message-ID: <1381201718-24698-2-git-send-email-felipe.contreras@gmail.com>
References: <1381201718-24698-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52620 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab3JHDOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Oct 2013 23:14:42 -0400
In-Reply-To: <1381201718-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "open list:ACPI FAN DRIVER" <linux-acpi@vger.kernel.org>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 41ade65..ba3da88 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -168,7 +168,7 @@ static int acpi_fan_add(struct acpi_device *device)
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
-      end:
+end:
 	return result;
 }
 
-- 
1.8.4-fc

