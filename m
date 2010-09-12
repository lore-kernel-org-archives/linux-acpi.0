From: Vasiliy Kulikov <segooon@gmail.com>
Subject: [PATCH] acpi: ec_sys: access user space with get_user()/put_user()
Date: Sun, 12 Sep 2010 22:57:03 +0400
Message-ID: <1284317825-4980-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

User space pointer may not be dereferenced. Use get_user()/put_user()
instead and check their return codes.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 Compile tested.

 drivers/acpi/ec_sys.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 0e869b3..cc007d8 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
+#include <linux/uaccess.h>
 #include "internal.h"
 
 MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
@@ -43,7 +44,6 @@ static ssize_t acpi_ec_read_io(struct file *f, char __user *buf,
 	 * struct acpi_ec *ec = ((struct seq_file *)f->private_data)->private;
 	 */
 	unsigned int size = EC_SPACE_SIZE;
-	u8 *data = (u8 *) buf;
 	loff_t init_off = *off;
 	int err = 0;
 
@@ -56,9 +56,15 @@ static ssize_t acpi_ec_read_io(struct file *f, char __user *buf,
 		size = count;
 
 	while (size) {
-		err = ec_read(*off, &data[*off - init_off]);
+		u8 byte_read;
+		err = ec_read(*off, &byte_read);
 		if (err)
 			return err;
+		if (put_user(byte_read, buf + *off - init_off)) {
+			if (*off - init_off)
+				return *off - init_off; /* partial read */
+			return -EFAULT;
+		}
 		*off += 1;
 		size--;
 	}
@@ -74,7 +80,6 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 
 	unsigned int size = count;
 	loff_t init_off = *off;
-	u8 *data = (u8 *) buf;
 	int err = 0;
 
 	if (*off >= EC_SPACE_SIZE)
@@ -85,7 +90,12 @@ static ssize_t acpi_ec_write_io(struct file *f, const char __user *buf,
 	}
 
 	while (size) {
-		u8 byte_write = data[*off - init_off];
+		u8 byte_write;
+		if (get_user(byte_write, buf + *off - init_off)) {
+			if (*off - init_off)
+				return *off - init_off; /* partial write */
+			return -EFAULT;
+		}
 		err = ec_write(*off, byte_write);
 		if (err)
 			return err;
-- 
1.7.0.4
