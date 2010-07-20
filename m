From: akpm@linux-foundation.org
Subject: [patch for 2.6.35 1/1] acpi: fix bogus preemption logic
Date: Tue, 20 Jul 2010 15:16:51 -0700
Message-ID: <201007202216.o6KMGpHD020818@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51694 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757617Ab0GTWRi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:17:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, tglx@linutronix.de, francois.valenduc@tvcablenet.be, ming.m.lin@intel.com

From: Thomas Gleixner <tglx@linutronix.de>

The ACPI_PREEMPTION_POINT() logic was introduced in commit 8bd108d
(ACPICA: add preemption point after each opcode parse).  The follow up
commits abe1dfab6, 138d15692, c084ca70 tried to fix the preemption logic
back and forth, but nobody noticed that the usage of
in_atomic_preempt_off() in that context is wrong.

The check which guards the call of cond_resched() is:

    if (!in_atomic_preempt_off() && !irqs_disabled())

in_atomic_preempt_off() is not intended for general use as the comment
above the macro definition clearly says:

 * Check whether we were atomic before we did preempt_disable():
 * (used by the scheduler, *after* releasing the kernel lock)

On a CONFIG_PREEMPT=n kernel the usage of in_atomic_preempt_off() works by
accident, but with CONFIG_PREEMPT=y it's just broken.

The whole purpose of the ACPI_PREEMPTION_POINT() is to reduce the latency
on a CONFIG_PREEMPT=n kernel, so make ACPI_PREEMPTION_POINT() depend on
CONFIG_PREEMPT=n and remove the in_atomic_preempt_off() check.

Addresses https://bugzilla.kernel.org/show_bug.cgi?id=16210

[akpm@linux-foundation.org: fix build]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Francois Valenduc <francois.valenduc@tvcablenet.be>
Cc: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/apei/erst.c        |    1 +
 include/acpi/platform/aclinux.h |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/apei/erst.c~acpi-fix-bogus-preemption-logic drivers/acpi/apei/erst.c
--- a/drivers/acpi/apei/erst.c~acpi-fix-bogus-preemption-logic
+++ a/drivers/acpi/apei/erst.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 #include <linux/cper.h>
 #include <linux/nmi.h>
+#include <linux/hardirq.h>
 #include <acpi/apei.h>
 
 #include "apei-internal.h"
diff -puN include/acpi/platform/aclinux.h~acpi-fix-bogus-preemption-logic include/acpi/platform/aclinux.h
--- a/include/acpi/platform/aclinux.h~acpi-fix-bogus-preemption-logic
+++ a/include/acpi/platform/aclinux.h
@@ -148,13 +148,17 @@ static inline void *acpi_os_acquire_obje
 #define ACPI_ALLOCATE_ZEROED(a) acpi_os_allocate_zeroed(a)
 #define ACPI_FREE(a)            kfree(a)
 
-/* Used within ACPICA to show where it is safe to preempt execution */
-#include <linux/hardirq.h>
+#ifndef CONFIG_PREEMPT
+/*
+ * Used within ACPICA to show where it is safe to preempt execution
+ * when CONFIG_PREEMPT=n
+ */
 #define ACPI_PREEMPTION_POINT() \
 	do { \
-		if (!in_atomic_preempt_off() && !irqs_disabled()) \
+		if (!irqs_disabled()) \
 			cond_resched(); \
 	} while (0)
+#endif
 
 #endif /* __KERNEL__ */
 
_
