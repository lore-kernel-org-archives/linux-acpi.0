From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] toshiba-acpi: Fix integer overrun that causes heap trashing
Date: Tue, 21 Jul 2009 19:38:05 +0200
Message-ID: <200907211938.05718.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:49722 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238AbZGURiY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jul 2009 13:38:24 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Michael Buesch <mb@bu3sch.de>

Avoid heap trashing triggered by an integer overflow of the
userspace controlled "count" variable.

If userspace passes in a "count" of (size_t)-1l, the kmalloc size will
overflow to ((size_t)-1l + 1) = 0. If kmalloc() is called with zero size,
it will return the ZERO_SIZE_PTR, which is (void *)16.
This will pass the !tmp_buffer sanity check.
After that, copy_from_user() will attempt to copy 0xFFFFFFFF
(or 0xFFFFFFFFFFFFFFFF on 64bit) bytes to (void *)16, which is within
the NULL page.

A possible testcase could look like this:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char **argv)
{
	int fd;
	char *buf;

	if (argc != 2) {
		printf("Usage: %s /proc/acpi/toshiba/filename\n", argv[0]);
		return 1;
	}
	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		printf("Could not open proc file\n");
		return 1;
	}
	buf = malloc(1337);
	if (!buf) {
		printf("Out of memory\n");
		return 1;
	}
	memset(buf, 0x66, 1337);
	write(fd, buf, (size_t)-1l); /* boom!! */
}

We avoid the integer overrun by putting an arbitrary limit on the count.
PAGE_SIZE sounds like a sane limit.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Cc: stable@kernel.org

---

This patch is completely untested due to lack of supported device.
The proc file is only writeable by root in the default setup,
so it's probably not exploitable as-is.
The toshiba-acpi driver is orphaned, so I hope somebody will pick this up.

---
 drivers/platform/x86/toshiba_acpi.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.orig/drivers/platform/x86/toshiba_acpi.c
+++ linux-2.6/drivers/platform/x86/toshiba_acpi.c
@@ -388,20 +388,22 @@ dispatch_read(char *page, char **start, 
 	return len;
 }
 
 static int
 dispatch_write(struct file *file, const char __user * buffer,
 	       unsigned long count, ProcItem * item)
 {
 	int result;
 	char *tmp_buffer;
 
+	if (count > PAGE_SIZE - 1)
+		return -EINVAL;
 	/* Arg buffer points to userspace memory, which can't be accessed
 	 * directly.  Since we're making a copy, zero-terminate the
 	 * destination so that sscanf can be used on it safely.
 	 */
 	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
 	if (!tmp_buffer)
 		return -ENOMEM;
 
 	if (copy_from_user(tmp_buffer, buffer, count)) {
 		result = -EFAULT;

-- 
Greetings, Michael.
