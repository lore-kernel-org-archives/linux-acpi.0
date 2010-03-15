From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/34] resource: expand IORESOURCE_TYPE_BITS to make room for
 bus resource type
Date: Sun, 14 Mar 2010 21:40:56 -0400
Message-ID: <cd7e9fcd1f7c9c397f747cf506c66f7dca11d1c6.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:33361 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0COB6i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:58:38 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA005P8W5P5G41@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:58:38 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional change; this just makes room for another resource type.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/ioport.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index dda9841..b126209 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -34,20 +34,20 @@ struct resource_list {
  */
 #define IORESOURCE_BITS		0x000000ff	/* Bus-specific bits */
 
-#define IORESOURCE_TYPE_BITS	0x00000f00	/* Resource type */
+#define IORESOURCE_TYPE_BITS	0x00001f00	/* Resource type */
 #define IORESOURCE_IO		0x00000100
 #define IORESOURCE_MEM		0x00000200
 #define IORESOURCE_IRQ		0x00000400
 #define IORESOURCE_DMA		0x00000800
 
-#define IORESOURCE_PREFETCH	0x00001000	/* No side effects */
-#define IORESOURCE_READONLY	0x00002000
-#define IORESOURCE_CACHEABLE	0x00004000
-#define IORESOURCE_RANGELENGTH	0x00008000
-#define IORESOURCE_SHADOWABLE	0x00010000
+#define IORESOURCE_PREFETCH	0x00002000	/* No side effects */
+#define IORESOURCE_READONLY	0x00004000
+#define IORESOURCE_CACHEABLE	0x00008000
+#define IORESOURCE_RANGELENGTH	0x00010000
+#define IORESOURCE_SHADOWABLE	0x00020000
 
-#define IORESOURCE_SIZEALIGN	0x00020000	/* size indicates alignment */
-#define IORESOURCE_STARTALIGN	0x00040000	/* start field is alignment */
+#define IORESOURCE_SIZEALIGN	0x00040000	/* size indicates alignment */
+#define IORESOURCE_STARTALIGN	0x00080000	/* start field is alignment */
 
 #define IORESOURCE_MEM_64	0x00100000
 
-- 
1.7.0.2.201.g80978

