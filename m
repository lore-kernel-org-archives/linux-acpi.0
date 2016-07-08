From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH v3 3/7] ACPI / device_sysfs: make use of new strtolower() function
Date: Fri,  8 Jul 2016 15:43:10 -0700
Message-ID: <1468017794-4818-4-git-send-email-mmayer@broadcom.com>
References: <1468017794-4818-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36248 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824AbcGHWoQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jul 2016 18:44:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id t190so16561958pfb.3
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jul 2016 15:44:16 -0700 (PDT)
In-Reply-To: <1468017794-4818-1-git-send-email-mmayer@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Call strtolower() rather than walking the string explicitly to convert
it to lowercase.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

Rafael, I left off your ACK, since the implementation of my function
changed somewhat (doesn't check the argument NULL, doesn't return
anything). Please let me know if you are still okay with this.

 drivers/acpi/device_sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 7b2c48f..1db38c7 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -200,12 +200,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	const union acpi_object *of_compatible, *obj;
 	int len, count;
 	int i, nval;
-	char *c;
 
 	acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
 	/* DT strings are all in lower case */
-	for (c = buf.pointer; *c != '\0'; c++)
-		*c = tolower(*c);
+	strtolower(buf.pointer);
 
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
-- 
2.7.4

