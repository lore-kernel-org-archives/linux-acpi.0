From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 2/9] vsprintf: add %pR support for IRQ and DMA resources
Date: Tue, 13 Oct 2009 13:22:05 -0600
Message-ID: <20091013192205.22336.71607.stgit@bob.kio>
References: <20091013192040.22336.84876.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934210AbZJMTYB@vger.kernel.org>
In-Reply-To: <20091013192040.22336.84876.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Print addresses (IO port numbers and memory addresses) in hex, but print
others (IRQs and DMA channels) in decimal.  Only print the end if it's
different from the start.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 lib/vsprintf.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7830576..fcbe69d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -604,28 +604,40 @@ static char *resource_string(char *buf, char *end, struct resource *res,
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
+	/* 32-bit res (sizeof==4): 10 chars in dec, 10 in hex ("0x" + 8)
+	 * 64-bit res (sizeof==8): 20 chars in dec, 18 in hex ("0x" + 16) */
+#define RSRC_BUF_SIZE	((2 * sizeof(resource_size_t)) + 4)
+	char sym[2*RSRC_BUF_SIZE + sizeof("[-]")];
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
-	*p = 0;
+	*p = '\0';
 
 	return string(buf, end, sym, spec);
 }
