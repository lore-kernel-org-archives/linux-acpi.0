From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] ACPI: remove unneeded NULL pointer check
Date: Tue,  5 Nov 2013 21:25:32 +0100
Message-ID: <1383683132-28851-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:61973 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab3KEUZr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2013 15:25:47 -0500
Received: by mail-bk0-f44.google.com with SMTP id mx11so1137550bkb.17
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2013 12:25:46 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mathias Krause <minipli@googlemail.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dan Carpenter <dan.carpenter@oracle.com>

nla_data() cannot return NULL as it simply adds NLA_HDRLEN to the passed
pointer. The NULL pointer check is therefore superfluous. Remove it.

Found by smatch:
  drivers/acpi/event.c:130 acpi_bus_generate_netlink_event() warn: can
  'event' even be NULL?

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/acpi/event.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 8247fcd..fdef416 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -127,11 +127,6 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 	}
 
 	event = nla_data(attr);
-	if (!event) {
-		nlmsg_free(skb);
-		return -EINVAL;
-	}
-
 	memset(event, 0, sizeof(struct acpi_genl_event));
 
 	strcpy(event->device_class, device_class);
-- 
1.7.10.4

