From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: event: fix acpi_bus_generate_netlink_event call
Date: Mon,  3 Sep 2007 00:03:35 -0300
Message-ID: <11887886153952-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50402 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752679AbXICDDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Sep 2007 23:03:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix for:
drivers/acpi/event.c:243: error: 'acpi_generate_netlink_event' undeclared
here (not in a function)

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index a2b9304..5c95863 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -240,7 +240,7 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 	return 0;
 }
 
-EXPORT_SYMBOL(acpi_generate_netlink_event);
+EXPORT_SYMBOL(acpi_bus_generate_netlink_event);
 
 static int acpi_event_genetlink_init(void)
 {
-- 
1.5.2.4

