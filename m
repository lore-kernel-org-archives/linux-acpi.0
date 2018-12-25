From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] acpi: fix a potential inconsistency caused by double-fetch
Date: Tue, 25 Dec 2018 15:46:33 -0600
Message-ID: <20181225214633.69973-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

"user_buf->length" is in user space, and copied in twice. The second
copy is after it passes the security check. If a user program races to
change user_buf->length in user space, the data fetched in the second
copy may invalidate the security check. The fix avoids the double-fetch
issue by using the value passing the security check.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/acpi/custom_method.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..f75f664301b3 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	static u32 max_size;
 	static u32 uncopied_bytes;
 
-	struct acpi_table_header table;
 	acpi_status status;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
 			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
+		if (get_user(max_size,
+				&(struct acpi_table_header *)user_buf->length))
 			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
+		uncopied_bytes = max_size;
 		buf = kzalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -56,6 +55,8 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		buf = NULL;
 		return -EFAULT;
 	}
+	/* Ensure table length is not changed in the second copy */
+	(struct acpi_table_header *)(buf + (*ppos))->length = max_size;
 
 	uncopied_bytes -= count;
 	*ppos += count;
-- 
2.17.2 (Apple Git-113)
