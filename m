From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1 1/7] resource: expand IORESOURCE_TYPE_BITS to make room for
	bus resource type
Date: Fri, 19 Feb 2010 10:58:23 -0700
Message-ID: <20100219175823.9199.75349.stgit@bob.kio>
References: <20100219175655.9199.30691.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100219175655.9199.30691.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org


No functional change; this just makes room for another resource type.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 include/linux/ioport.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 7129504..e38dedc 100644
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
 
