From: akpm@osdl.org
Subject: [patch 5/6] cpu_relax(): use in ACPI lock
Date: Fri, 30 Jun 2006 02:15:19 -0700
Message-ID: <200606300915.k5U9FJs6001044@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:56971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751563AbWF3JPt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 05:15:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de, mingo@elte.hu

From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>

Use cpu_relax() in __acpi_acquire_global_lock() etc.

[mingo@elte.hu: build fix]
Signed-off-by: Andreas Mohr <andi@lisas.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-i386/acpi.h   |   15 +++++++++++----
 include/asm-x86_64/acpi.h |   14 ++++++++++----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff -puN include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock
+++ a/include/asm-i386/acpi.h
@@ -31,6 +31,7 @@
 #include <acpi/pdc_intel.h>
 
 #include <asm/system.h>		/* defines cmpxchg */
+#include <asm/processor.h>	/* cpu_relax() */
 
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
@@ -61,11 +62,14 @@ static inline int
 __acpi_acquire_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return (new < 3) ? -1 : 0;
 }
 
@@ -73,11 +77,14 @@ static inline int
 __acpi_release_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = old & ~0x3;
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return old & 0x1;
 }
 
diff -puN include/asm-x86_64/acpi.h~cpu_relax-use-in-acpi-lock include/asm-x86_64/acpi.h
--- a/include/asm-x86_64/acpi.h~cpu_relax-use-in-acpi-lock
+++ a/include/asm-x86_64/acpi.h
@@ -59,11 +59,14 @@ static inline int
 __acpi_acquire_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return (new < 3) ? -1 : 0;
 }
 
@@ -71,11 +74,14 @@ static inline int
 __acpi_release_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = old & ~0x3;
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return old & 0x1;
 }
 
_
