From: Cyril Roelandt <tipecaml@gmail.com>
Subject: [PATCH v2] acpi_system_write_wakeup_device(): fix error check for unsigned variable.
Date: Thu, 22 Nov 2012 01:34:55 +0100
Message-ID: <1353544495-25277-1-git-send-email-tipecaml@gmail.com>
References: <1645783.2WuR77RKxS@vostro.rjw.lan>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1645783.2WuR77RKxS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org, kernel-janitors@vger.kernel.org, Cyril Roelandt <tipecaml@gmail.com>
List-Id: linux-acpi@vger.kernel.org

The LEN variable is unsigned, therefore checking whether it is less than 0 is
useless. Also drop the LEN variable, since the COUNT parameter can be used
instead.

Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
---
 drivers/acpi/proc.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 27adb09..ef98796 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -362,16 +362,13 @@ acpi_system_write_wakeup_device(struct file *file,
 	struct list_head *node, *next;
 	char strbuf[5];
 	char str[5] = "";
-	unsigned int len = count;
 
-	if (len > 4)
-		len = 4;
-	if (len < 0)
-		return -EFAULT;
+	if (count > 4)
+		count = 4;
 
-	if (copy_from_user(strbuf, buffer, len))
+	if (copy_from_user(strbuf, buffer, count))
 		return -EFAULT;
-	strbuf[len] = '\0';
+	strbuf[count] = '\0';
 	sscanf(strbuf, "%s", str);
 
 	mutex_lock(&acpi_device_lock);
-- 
1.7.10.4
