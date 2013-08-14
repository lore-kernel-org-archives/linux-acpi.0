From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 2/3] earlycpio.c: Fix the confusing comment of find_cpio_data().
Date: Wed, 14 Aug 2013 17:37:07 +0800
Message-ID: <1376473028-29380-3-git-send-email-tangchen@cn.fujitsu.com>
References: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, liwanp@linux.vnet.ibm.com, tj@kernel.org, zhangyanfei@cn.fujitsu.com, lenb@kernel.org, rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The comments of find_cpio_data() says:

  * @offset: When a matching file is found, this is the offset to the
  *          beginning of the cpio. ......

But according to the code,

  dptr = PTR_ALIGN(p + ch[C_NAMESIZE], 4);
  nptr = PTR_ALIGN(dptr + ch[C_FILESIZE], 4);
  ....
  *offset = (long)nptr - (long)data;	/* data is the cpio file */

@offset is the offset of the next file, not the matching file itself.
This is confused and may cause unnecessary waste of time to debug.
So fix it.

v1 -> v2:
As tj suggested, rename @offset to @nextoff which is more clear to
users. And also adjust the new comments.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
---
 lib/earlycpio.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/lib/earlycpio.c b/lib/earlycpio.c
index 7aa7ce2..c7ae5ed 100644
--- a/lib/earlycpio.c
+++ b/lib/earlycpio.c
@@ -49,22 +49,23 @@ enum cpio_fields {
 
 /**
  * cpio_data find_cpio_data - Search for files in an uncompressed cpio
- * @path:   The directory to search for, including a slash at the end
- * @data:   Pointer to the the cpio archive or a header inside
- * @len:    Remaining length of the cpio based on data pointer
- * @offset: When a matching file is found, this is the offset to the
- *          beginning of the cpio. It can be used to iterate through
- *          the cpio to find all files inside of a directory path
+ * @path:       The directory to search for, including a slash at the end
+ * @data:       Pointer to the the cpio archive or a header inside
+ * @len:        Remaining length of the cpio based on data pointer
+ * @nextoff:    When a matching file is found, this is the offset from the
+ *              beginning of the cpio to the beginning of the next file, not the
+ *              matching file itself. It can be used to iterate through the cpio
+ *              to find all files inside of a directory path 
  *
- * @return: struct cpio_data containing the address, length and
- *          filename (with the directory path cut off) of the found file.
- *          If you search for a filename and not for files in a directory,
- *          pass the absolute path of the filename in the cpio and make sure
- *          the match returned an empty filename string.
+ * @return:     struct cpio_data containing the address, length and
+ *              filename (with the directory path cut off) of the found file.
+ *              If you search for a filename and not for files in a directory,
+ *              pass the absolute path of the filename in the cpio and make sure
+ *              the match returned an empty filename string.
  */
 
 struct cpio_data find_cpio_data(const char *path, void *data,
-					  size_t len,  long *offset)
+				size_t len,  long *nextoff)
 {
 	const size_t cpio_header_len = 8*C_NFIELDS - 2;
 	struct cpio_data cd = { NULL, 0, "" };
@@ -124,7 +125,7 @@ struct cpio_data find_cpio_data(const char *path, void *data,
 		if ((ch[C_MODE] & 0170000) == 0100000 &&
 		    ch[C_NAMESIZE] >= mypathsize &&
 		    !memcmp(p, path, mypathsize)) {
-			*offset = (long)nptr - (long)data;
+			*nextoff = (long)nptr - (long)data;
 			if (ch[C_NAMESIZE] - mypathsize >= MAX_CPIO_FILE_NAME) {
 				pr_warn(
 				"File %s exceeding MAX_CPIO_FILE_NAME [%d]\n",
-- 
1.7.1
