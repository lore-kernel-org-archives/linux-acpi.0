From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/34] resource: add bus number support
Date: Sun, 14 Mar 2010 21:40:57 -0400
Message-ID: <0f4050c7d3ba0275e5f39513c0670a717d43048c.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:38650 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0COB7m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:59:42 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00JQZW7EN4R5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:59:39 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Add support for bus number resources.  This is for bridges with a range of
bus numbers behind them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/ioport.h |    1 +
 lib/vsprintf.c         |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index b126209..510e4ac 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -39,6 +39,7 @@ struct resource_list {
 #define IORESOURCE_MEM		0x00000200
 #define IORESOURCE_IRQ		0x00000400
 #define IORESOURCE_DMA		0x00000800
+#define IORESOURCE_BUS		0x00001000
 
 #define IORESOURCE_PREFETCH	0x00002000	/* No side effects */
 #define IORESOURCE_READONLY	0x00004000
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 0d461c7..ebbecf9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -609,6 +609,12 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 		.precision = -1,
 		.flags = SPECIAL | SMALL | ZEROPAD,
 	};
+	static const struct printf_spec bus_spec = {
+		.base = 16,
+		.field_width = 2,
+		.precision = -1,
+		.flags = SMALL | ZEROPAD,
+	};
 	static const struct printf_spec dec_spec = {
 		.base = 10,
 		.precision = -1,
@@ -651,6 +657,9 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 	} else if (res->flags & IORESOURCE_DMA) {
 		p = string(p, pend, "dma ", str_spec);
 		specp = &dec_spec;
+	} else if (res->flags & IORESOURCE_BUS) {
+		p = string(p, pend, "bus ", str_spec);
+		specp = &bus_spec;
 	} else {
 		p = string(p, pend, "??? ", str_spec);
 		specp = &mem_spec;
-- 
1.7.0.2.201.g80978

