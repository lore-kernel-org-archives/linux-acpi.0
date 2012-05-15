From: Lekensteyn <lekensteyn@gmail.com>
Subject: [PATCH] acpi: fix regression on D3hot detection
Date: Tue, 15 May 2012 17:28:55 +0200
Message-ID: <5165867.6kdtKH1k0B@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39811 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226Ab2EOP3A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 May 2012 11:29:00 -0400
Received: by bkcji2 with SMTP id ji2so4924449bkc.19
        for <linux-acpi@vger.kernel.org>; Tue, 15 May 2012 08:28:59 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 tried clear up some confusion
around D3hot and D3cold but accidentally changed behaviour on validating device
power states. It added an extra condition: i < ACPI_STATE_D3_HOT which means
that only states D0, D1 and D2 are accepted if there are no power resources but
the _PSx method exist. D3(hot) is missing here.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=43228

Reported-by: rockorequin@hotmail.com
Signed-off-by: Peter Lekensteyn <lekensteyn@gmail.com>
Tested-by: rockorequin@hotmail.com
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7417267..932c427 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -895,7 +895,7 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 		 * D3hot is only valid if _PR3 present.
 		 */
 		if (ps->resources.count ||
-		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT))
+		    (ps->flags.explicit_set && i <= ACPI_STATE_D3_HOT))
 			ps->flags.valid = 1;
 
 		ps->power = -1;	/* Unknown - driver assigned */
-- 
1.7.9.5

