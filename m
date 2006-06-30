From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 5/6] cpu_relax(): use in ACPI lock
Date: Fri, 30 Jun 2006 15:48:14 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16CA0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36515 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750881AbWF3TsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 15:48:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de, mingo@elte.hu

NAK.

This is not a busy wait loop,
and thus does not justify this optimization.

The ACPI global lock is used to coordinate between the firmware
and the OS. It has a specific format dictated by the ACPI spec
where bit 1 is OWNED and bit 0 is PENDING.

When the OS finds the lock owned, it sets the PENDING bit
and returns -- it does not loop waiting for OWNED to clear.

The reason that there is a cmpxchg() around writing the lock
is only for the critical section where the firmware changed
the lock between when we read the lock and when we wrote it.

While you could construct a firmware test to thrash this
lock, and make this loop more, that isn't how the
lock is used -- it is used to guard (relatively high latency)
access to shared hardware registers.

thanks,
-Len



>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, June 30, 2006 5:15 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>andi@rhlx01.fht-esslingen.de; andi@lisas.de; mingo@elte.hu
>Subject: [patch 5/6] cpu_relax(): use in ACPI lock
>
>From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
>
>Use cpu_relax() in __acpi_acquire_global_lock() etc.
>
>[mingo@elte.hu: build fix]
>Signed-off-by: Andreas Mohr <andi@lisas.de>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> include/asm-i386/acpi.h   |   15 +++++++++++----
> include/asm-x86_64/acpi.h |   14 ++++++++++----
> 2 files changed, 21 insertions(+), 8 deletions(-)
>
>diff -puN include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock 
>include/asm-i386/acpi.h
>--- a/include/asm-i386/acpi.h~cpu_relax-use-in-acpi-lock
>+++ a/include/asm-i386/acpi.h
>@@ -31,6 +31,7 @@
> #include <acpi/pdc_intel.h>
> 
> #include <asm/system.h>		/* defines cmpxchg */
>+#include <asm/processor.h>	/* cpu_relax() */
> 
> #define COMPILER_DEPENDENT_INT64   long long
> #define COMPILER_DEPENDENT_UINT64  unsigned long long
>@@ -61,11 +62,14 @@ static inline int
> __acpi_acquire_global_lock (unsigned int *lock)
> {
> 	unsigned int old, new, val;
>-	do {
>+	while (1) {
> 		old = *lock;
> 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
> 		val = cmpxchg(lock, old, new);
>-	} while (unlikely (val != old));
>+		if (likely(val == old))
>+			break;
>+		cpu_relax();
>+	}
> 	return (new < 3) ? -1 : 0;
> }
> 
>@@ -73,11 +77,14 @@ static inline int
> __acpi_release_global_lock (unsigned int *lock)
> {
> 	unsigned int old, new, val;
>-	do {
>+	while (1) {
> 		old = *lock;
> 		new = old & ~0x3;
> 		val = cmpxchg(lock, old, new);
>-	} while (unlikely (val != old));
>+		if (likely(val == old))
>+			break;
>+		cpu_relax();
>+	}
> 	return old & 0x1;
> }
> 
>diff -puN include/asm-x86_64/acpi.h~cpu_relax-use-in-acpi-lock 
>include/asm-x86_64/acpi.h
>--- a/include/asm-x86_64/acpi.h~cpu_relax-use-in-acpi-lock
>+++ a/include/asm-x86_64/acpi.h
>@@ -59,11 +59,14 @@ static inline int
> __acpi_acquire_global_lock (unsigned int *lock)
> {
> 	unsigned int old, new, val;
>-	do {
>+	while (1) {
> 		old = *lock;
> 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
> 		val = cmpxchg(lock, old, new);
>-	} while (unlikely (val != old));
>+		if (likely(val == old))
>+			break;
>+		cpu_relax();
>+	}
> 	return (new < 3) ? -1 : 0;
> }
> 
>@@ -71,11 +74,14 @@ static inline int
> __acpi_release_global_lock (unsigned int *lock)
> {
> 	unsigned int old, new, val;
>-	do {
>+	while (1) {
> 		old = *lock;
> 		new = old & ~0x3;
> 		val = cmpxchg(lock, old, new);
>-	} while (unlikely (val != old));
>+		if (likely(val == old))
>+			break;
>+		cpu_relax();
>+	}
> 	return old & 0x1;
> }
> 
>_
>
