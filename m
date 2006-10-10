From: akpm@osdl.org
Subject: [patch 12/12] i386: uninline acpi locking functions
Date: Tue, 10 Oct 2006 14:20:46 -0700
Message-ID: <200610102120.k9ALKkKa024299@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:9122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030539AbWJJVui (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:50:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org

From: Andrew Morton <akpm@osdl.org>

- Fixes a build problem with CONFIG_M386=y (include file dependenciers get
  messy).

- Share the implementation between x86 and x86_64

- These are too big to inline anyway.

Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/acpi/boot.c |   22 ++++++++++++++++++++++
 include/asm-i386/acpi.h      |   26 ++------------------------
 include/asm-x86_64/acpi.h    |   26 ++------------------------
 3 files changed, 26 insertions(+), 48 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~i386-acpi-build-fix arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c~i386-acpi-build-fix
+++ a/arch/i386/kernel/acpi/boot.c
@@ -1319,3 +1319,25 @@ static int __init setup_acpi_sci(char *s
 	return 0;
 }
 early_param("acpi_sci", setup_acpi_sci);
+
+int __acpi_acquire_global_lock(unsigned int *lock)
+{
+	unsigned int old, new, val;
+	do {
+		old = *lock;
+		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
+		val = cmpxchg(lock, old, new);
+	} while (unlikely (val != old));
+	return (new < 3) ? -1 : 0;
+}
+
+int __acpi_release_global_lock(unsigned int *lock)
+{
+	unsigned int old, new, val;
+	do {
+		old = *lock;
+		new = old & ~0x3;
+		val = cmpxchg(lock, old, new);
+	} while (unlikely (val != old));
+	return old & 0x1;
+}
diff -puN include/asm-i386/acpi.h~i386-acpi-build-fix include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h~i386-acpi-build-fix
+++ a/include/asm-i386/acpi.h
@@ -56,30 +56,8 @@
 #define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
-
-static inline int
-__acpi_acquire_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
-}
-
-static inline int
-__acpi_release_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return old & 0x1;
-}
+int __acpi_acquire_global_lock(unsigned int *lock);
+int __acpi_release_global_lock(unsigned int *lock);
 
 #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
 	((Acq) = __acpi_acquire_global_lock((unsigned int *) GLptr))
diff -puN include/asm-x86_64/acpi.h~i386-acpi-build-fix include/asm-x86_64/acpi.h
--- a/include/asm-x86_64/acpi.h~i386-acpi-build-fix
+++ a/include/asm-x86_64/acpi.h
@@ -54,30 +54,8 @@
 #define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
-
-static inline int
-__acpi_acquire_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
-}
-
-static inline int
-__acpi_release_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return old & 0x1;
-}
+int __acpi_acquire_global_lock(unsigned int *lock);
+int __acpi_release_global_lock(unsigned int *lock);
 
 #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
 	((Acq) = __acpi_acquire_global_lock((unsigned int *) GLptr))
_
