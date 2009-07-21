From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] thinkpad-acpi: Avoid heap buffer overrun
Date: Tue, 21 Jul 2009 13:51:16 -0300
Message-ID: <1248195076-4603-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43009 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753974AbZGUQvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jul 2009 12:51:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Michael Buesch <mb@bu3sch.de>, stable@kernel.org

From: Michael Buesch <mb@bu3sch.de>

Avoid a heap buffer overrun triggered by an integer overflow of the
userspace controlled "count" variable.

If userspace passes in a "count" of (size_t)-1l, the kmalloc size will
overflow to ((size_t)-1l + 2) = 1, so only one byte will be allocated.
However, copy_from_user() will attempt to copy 0xFFFFFFFF (or
0xFFFFFFFFFFFFFFFF on 64bit) bytes to the buffer.

A possible testcase could look like this:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
	int fd;
	char c;

	if (argc != 2) {
		printf("Usage: %s /proc/acpi/ibm/filename\n", argv[0]);
		return 1;
	}
	fd = open(argv[1], O_RDWR);
	if (fd < 0) {
		printf("Could not open proc file\n");
		return 1;
	}
	write(fd, &c, (size_t)-1l);
}

We avoid the integer overrun by putting an arbitrary limit on the count.
PAGE_SIZE sounds like a sane limit.

(note: this bug exists at least since kernel 2.6.12...)

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 40b9698..1e94638 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -773,6 +773,8 @@ static int dispatch_procfs_write(struct file *file,
 
 	if (!ibm || !ibm->write)
 		return -EINVAL;
+	if (count > PAGE_SIZE - 2)
+		return -EINVAL;
 
 	kernbuf = kmalloc(count + 2, GFP_KERNEL);
 	if (!kernbuf)
-- 
1.6.2.4

