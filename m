From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] Restore SYSENTER setup on swsusp resume.
Date: 14 Feb 2003 19:22:09 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045250528.22719.173.camel@passion.cambridge.redhat.com>
References: <Pine.LNX.4.44.0302141029001.2186-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0302141029001.2186-100000-NOXD9LnmIcc+KpMpn4J55tBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mochel-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-02-14 at 18:36, Linus Torvalds wrote:
> This should have _nothing_ to do with ACPI. Looks like it should be in 
> arch/i386/kernel/suspend.c, restore_processor_state(), at which point it 
> should be done correctly regardless of whether the sleep was ACPI-induced 
> or done without any ACPI stuff at all.

Oops, sorry. Having complained so much about how ACPI code goes off and
assumes all the world is ACPI, I hadn't noticed that the suspend code is
actually much saner and acknowledges the possibility that we could shut
the box down some other way. I was wondering where the rest of the setup
was :)

Try this one instead. If I fix the UP build of
arch/i386/kernel/acpi/boot.c and make drivers/acpi/sleep/proc.c actually
get built, this works...

===== arch/i386/kernel/suspend.c 1.11 vs edited =====
--- 1.11/arch/i386/kernel/suspend.c	Sat Nov 30 14:28:40 2002
+++ edited/arch/i386/kernel/suspend.c	Fri Feb 14 19:18:20 2003
@@ -32,6 +32,8 @@
 unsigned long saved_context_esp, saved_context_ebp, saved_context_esi,
saved_context_edi;
 unsigned long saved_context_eflags;
 
+extern void enable_sep_cpu(void *);
+
 void save_processor_state(void)
 {
 	kernel_fpu_begin();
@@ -95,6 +97,12 @@
 	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
 	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
 	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
+
+	/*
+	 * sysenter MSRs
+	 */
+	if (boot_cpu_has(X86_FEATURE_SEP))
+		enable_sep_cpu(NULL);
 
 	fix_processor_context();
 	do_fpu_end();
===== arch/i386/kernel/sysenter.c 1.7 vs edited =====
--- 1.7/arch/i386/kernel/sysenter.c	Tue Jan  7 18:08:52 2003
+++ edited/arch/i386/kernel/sysenter.c	Fri Feb 14 18:48:04 2003
@@ -35,7 +35,7 @@
 	unsigned char stack[0];
 } __attribute__((aligned(8192)));
 	
-static void __init enable_sep_cpu(void *info)
+void enable_sep_cpu(void *info)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = init_tss + cpu;




-- 
dwmw2


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
