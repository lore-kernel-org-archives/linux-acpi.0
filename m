From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: 30 Mar 2004 16:49:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1080683344.3337.178.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <200403302030.26476.arekm@pld-linux.org> <1080677134.980.166.camel@dhcppc4>
	 <200403302225.33966.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200403302225.33966.arekm@pld-linux.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Okay, simplicity wins;-)

Build for 80386 -- get a build-time warning -- that should do.

thanks,
-Len

ps. earliest ACPI implementation is said to in the late Pentium (1) era.


===== arch/i386/kernel/acpi/boot.c 1.56 vs edited =====
--- 1.56/arch/i386/kernel/acpi/boot.c	Fri Mar 26 17:50:48 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Mar 30 16:23:39 2004
@@ -67,6 +67,10 @@
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+#ifndef __HAVE_ARCH_CMPXCHG
+#warning ACPI uses CMPXCHG, i486 and later hardware
+#endif
+
 /*
--------------------------------------------------------------------------
                               Boot-time Configuration
   
-------------------------------------------------------------------------- */
===== include/asm-i386/system.h 1.30 vs edited =====
--- 1.30/include/asm-i386/system.h	Fri Nov 21 01:24:00 2003
+++ edited/include/asm-i386/system.h	Tue Mar 30 16:05:30 2004
@@ -241,6 +241,7 @@
 
 #ifdef CONFIG_X86_CMPXCHG
 #define __HAVE_ARCH_CMPXCHG 1
+#endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long
old,
 				      unsigned long new, int size)
@@ -273,10 +274,6 @@
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
     
-#else
-/* Compiling for a 386 proper.	Is it worth implementing via cli/sti? 
*/
-#endif
-
 #ifdef __KERNEL__
 struct alt_instr { 
 	__u8 *instr; 		/* original instruction */
