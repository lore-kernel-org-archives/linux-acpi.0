From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/7] vsprintf: fix io/mem resource width
Date: Tue, 06 Oct 2009 15:33:29 -0600
Message-ID: <20091006213329.4272.6694.stgit@bob.kio>
References: <20091006213259.4272.68068.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:39132 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbZJFVeG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2009 17:34:06 -0400
In-Reply-To: <20091006213259.4272.68068.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The leading "0x" consumes field width, so leave space for it in addition to
the 4 or 8 hex digits.  This means we'll print "0x0000-0x01df" rather than
"0x00-0x1df", for example.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 lib/vsprintf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 33bed5e..7830576 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -598,11 +598,11 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 				struct printf_spec spec)
 {
 #ifndef IO_RSRC_PRINTK_SIZE
-#define IO_RSRC_PRINTK_SIZE	4
+#define IO_RSRC_PRINTK_SIZE	6
 #endif
 
 #ifndef MEM_RSRC_PRINTK_SIZE
-#define MEM_RSRC_PRINTK_SIZE	8
+#define MEM_RSRC_PRINTK_SIZE	10
 #endif
 	struct printf_spec num_spec = {
 		.base = 16,

