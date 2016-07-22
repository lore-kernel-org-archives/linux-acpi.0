From: Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH v4 3/7] ACPI / device_sysfs: make use of new strtolower() function
Date: Fri, 22 Jul 2016 16:31:05 -0700
Message-ID: <1469230269-1644-4-git-send-email-mmayer@broadcom.com>
References: <1469230269-1644-1-git-send-email-mmayer@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469230269-1644-1-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Call strtolower() rather than walking the string explicitly to convert
it to lowercase.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
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
