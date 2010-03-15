From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/34] resource: add window support
Date: Sun, 14 Mar 2010 21:40:58 -0400
Message-ID: <9d7cca04211d4eb104eaaa424b98f650bc29c730.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:18986 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0COCAr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 22:00:47 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA0087JWC2OLN1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 21:02:27 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Add support for resource windows.  This is for bridge resources, i.e.,
regions where a bridge forwards transactions from the primary to the
secondary side.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/ioport.h |    1 +
 lib/vsprintf.c         |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 510e4ac..71ab79d 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -51,6 +51,7 @@ struct resource_list {
 #define IORESOURCE_STARTALIGN	0x00080000	/* start field is alignment */
 
 #define IORESOURCE_MEM_64	0x00100000
+#define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
 
 #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
 #define IORESOURCE_DISABLED	0x10000000
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index ebbecf9..24112e5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -635,7 +635,7 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 	 * 64-bit res (sizeof==8): 20 chars in dec, 18 in hex ("0x" + 16) */
 #define RSRC_BUF_SIZE		((2 * sizeof(resource_size_t)) + 4)
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
-#define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref disabled]")
+#define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
 	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
@@ -675,6 +675,8 @@ static char *resource_string(char *buf, char *end, struct resource *res,
 			p = string(p, pend, " 64bit", str_spec);
 		if (res->flags & IORESOURCE_PREFETCH)
 			p = string(p, pend, " pref", str_spec);
+		if (res->flags & IORESOURCE_WINDOW)
+			p = string(p, pend, " window", str_spec);
 		if (res->flags & IORESOURCE_DISABLED)
 			p = string(p, pend, " disabled", str_spec);
 	} else {
-- 
1.7.0.2.201.g80978

