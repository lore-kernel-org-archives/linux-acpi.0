From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 1/9] vsprintf: fix io/mem resource width
Date: Tue, 13 Oct 2009 13:22:00 -0600
Message-ID: <20091013192200.22336.70382.stgit@bob.kio>
References: <20091013192040.22336.84876.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:43537 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbZJMTWh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2009 15:22:37 -0400
In-Reply-To: <20091013192040.22336.84876.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>

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

