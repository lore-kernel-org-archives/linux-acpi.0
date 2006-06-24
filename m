From: akpm@osdl.org
Subject: [patch 18/18] cpu_relax(): use in ACPI lock
Date: Sat, 24 Jun 2006 16:37:28 -0700
Message-ID: <200606242337.k5ONbTS3008134@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:33436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbWFXXpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 19:45:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de


From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>

Use cpu_relax() in __acpi_acquire_global_lock() etc.

Signed-off-by: Andreas Mohr <andi@lisas.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-i386/acpi.h   |   14 ++++++++++----
 include/asm-x86_64/acpi.h |   14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff -puN include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock
+++ a/include/asm-i386/acpi.h
@@ -61,11 +61,14 @@ static inline int
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
 
@@ -73,11 +76,14 @@ static inline int
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
