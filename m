From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/7] vsprintf: add %pR support for IRQ and DMA resources
Date: Tue, 06 Oct 2009 15:33:34 -0600
Message-ID: <20091006213334.4272.31517.stgit@bob.kio>
References: <20091006213259.4272.68068.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933478AbZJFVge@vger.kernel.org>
In-Reply-To: <20091006213259.4272.68068.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Print addresses (IO port numbers and memory addresses) in hex, but print
others (IRQs and DMA channels) in decimal.  Only print the end if it's
different from the start.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 lib/vsprintf.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7830576..1b60aed 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -604,26 +604,37 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 #ifndef MEM_RSRC_PRINTK_SIZE
 #define MEM_RSRC_PRINTK_SIZE	10
 #endif
-	struct printf_spec num_spec = {
+	struct printf_spec hex_spec = {
 		.base = 16,
 		.precision = -1,
 		.flags = SPECIAL | SMALL | ZEROPAD,
 	};
-	/* room for the actual numbers, the two "0x", -, [, ] and the final zero */
-	char sym[4*sizeof(resource_size_t) + 8];
+	struct printf_spec dec_spec = {
+		.base = 10,
+		.precision = -1,
+		.flags = 0,
+	};
+	/* room for two actual numbers (decimal or hex), the two "0x", -, [, ]
+	 * and the final zero */
+	char sym[2*3*sizeof(resource_size_t) + 8];
 	char *p = sym, *pend = sym + sizeof(sym);
-	int size = -1;
+	int size = -1, addr = 0;
 
-	if (res->flags & IORESOURCE_IO)
+	if (res->flags & IORESOURCE_IO) {
 		size = IO_RSRC_PRINTK_SIZE;
-	else if (res->flags & IORESOURCE_MEM)
+		addr = 1;
+	} else if (res->flags & IORESOURCE_MEM) {
 		size = MEM_RSRC_PRINTK_SIZE;
+		addr = 1;
+	}
 
 	*p++ = '[';
-	num_spec.field_width = size;
-	p = number(p, pend, res->start, num_spec);
-	*p++ = '-';
-	p = number(p, pend, res->end, num_spec);
+	hex_spec.field_width = size;
+	p = number(p, pend, res->start, addr ? hex_spec : dec_spec);
+	if (res->start != res->end) {
+		*p++ = '-';
+		p = number(p, pend, res->end, addr ? hex_spec : dec_spec);
+	}
 	*p++ = ']';
 	*p = 0;
 
