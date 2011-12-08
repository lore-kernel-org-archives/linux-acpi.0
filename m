From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 01/11] ACPI, Add 64bit read/write support to atomicio on i386
Date: Thu,  8 Dec 2011 11:25:40 +0800
Message-ID: <1323314750-8185-2-git-send-email-ying.huang@intel.com>
References: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There is no 64bit read/write support in ACPI atomicio because
readq/writeq is used to implement 64bit read/write, but readq/writeq
is not available on i386.  This patch implement 64bit read/write
support in atomicio via two readl/writel.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/atomicio.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -260,6 +260,21 @@ int acpi_post_unmap_gar(struct acpi_gene
 }
 EXPORT_SYMBOL_GPL(acpi_post_unmap_gar);
 
+#ifdef readq
+static inline u64 read64(const volatile void __iomem *addr)
+{
+	return readq(addr);
+}
+#else
+static inline u64 read64(const volatile void __iomem *addr)
+{
+	u64 l, h;
+	l = readl(addr);
+	h = readl(addr+4);
+	return l | (h << 32);
+}
+#endif
+
 /*
  * Can be used in atomic (including NMI) or process context. RCU read
  * lock can only be released after the IO memory area accessing.
@@ -280,11 +295,9 @@ static int acpi_atomic_read_mem(u64 padd
 	case 32:
 		*val = readl(addr);
 		break;
-#ifdef readq
 	case 64:
-		*val = readq(addr);
+		*val = read64(addr);
 		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -293,6 +306,19 @@ static int acpi_atomic_read_mem(u64 padd
 	return 0;
 }
 
+#ifdef writeq
+static inline void write64(u64 val, volatile void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#else
+static inline void write64(u64 val, volatile void __iomem *addr)
+{
+	writel(val, addr);
+	writel(val>>32, addr+4);
+}
+#endif
+
 static int acpi_atomic_write_mem(u64 paddr, u64 val, u32 width)
 {
 	void __iomem *addr;
@@ -309,11 +335,9 @@ static int acpi_atomic_write_mem(u64 pad
 	case 32:
 		writel(val, addr);
 		break;
-#ifdef writeq
 	case 64:
-		writeq(val, addr);
+		write64(val, addr);
 		break;
-#endif
 	default:
 		return -EINVAL;
 	}
