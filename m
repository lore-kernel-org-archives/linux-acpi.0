From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 7/9] x86: avoid low BIOS area when allocating address space
Date: Thu, 16 Dec 2010 10:38:51 -0700
Message-ID: <20101216173851.8185.47068.stgit@bob.kio>
References: <20101216173614.8185.19462.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101216173614.8185.19462.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org


This implements arch_remove_reservations() so allocate_resource() can
avoid any arch-specific reserved areas.  This currently just avoids the
BIOS area (the first 1MB), but could be used for E820 reserved areas if
that turns out to be necessary.

We previously avoided this area in pcibios_align_resource().  This patch
moves the test from that PCI-specific path to a generic path, so *all*
resource allocations will avoid this area.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 arch/x86/kernel/Makefile   |    1 +
 arch/x86/kernel/resource.c |   11 +++++++++++
 arch/x86/pci/i386.c        |    3 ---
 3 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/resource.c


diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9e13763..1e99475 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -45,6 +45,7 @@ obj-y			+= pci-dma.o quirks.o i8237.o topology.o kdebugfs.o
 obj-y			+= alternative.o i8253.o pci-nommu.o hw_breakpoint.o
 obj-y			+= tsc.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
+obj-y			+= resource.o
 
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-y				+= process.o
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
new file mode 100644
index 0000000..407a900
--- /dev/null
+++ b/arch/x86/kernel/resource.c
@@ -0,0 +1,11 @@
+#include <linux/ioport.h>
+#include <asm/e820.h>
+
+void arch_remove_reservations(struct resource *avail)
+{
+	/* Trim out BIOS area (low 1MB) */
+	if (avail->flags & IORESOURCE_MEM) {
+		if (avail->start < BIOS_END)
+			avail->start = BIOS_END;
+	}
+}
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 8379c2c..b1805b7 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -72,9 +72,6 @@ pcibios_align_resource(void *data, const struct resource *res,
 			return start;
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
-	} else if (res->flags & IORESOURCE_MEM) {
-		if (start < BIOS_END)
-			start = BIOS_END;
 	}
 	return start;
 }
