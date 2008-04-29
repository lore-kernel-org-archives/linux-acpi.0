From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Tue, 29 Apr 2008 20:29:31 +0200
Message-ID: <1209493771.1784.892.camel@queen.suse.de>
References: <48144209.7080203@gmail.com>
	 <1209476717.1784.853.camel@queen.suse.de>  <4817457C.6000103@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:36381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768AbYD2S3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 14:29:34 -0400
In-Reply-To: <4817457C.6000103@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Langsdorf, Mark" <mark.langsdorf@amd.com>, andreas.herrmann3@amd.com

On Tue, 2008-04-29 at 16:57 +0100, Richard wrote:
> Thomas Renninger wrote:
> > On Sun, 2008-04-27 at 10:06 +0100, Richard wrote:
> >   
> >> Hi all,
> >>
> >> Pardon for the intrusion, I am trying to fault find a horrible wrong 
> >> ACPI interface and fix it.
> >>
> >> the problem is as follows... 
> >>
> >> Kernel 2.6.23 works fine, except there is no stable clocksource.. 
> >> acpi_pm, tsc doesnt work and jiffies .. well thats just jiffies. The 
> >> kernel boots but time sources are erratic and this results in an 
> >> unstable clock (Mp3's play at erratic speeds)
> >>
> >> Kernel 2.6.25 hangs the system if I enable ACPI Timer and rebuild/boot 
> >> the new linux kernel. The only clock sources are tsc and jiffies and TSC 
> >> is disables due to being erratic. If I totally disable ACPI, the kernel 
> >> boots and works with stable clocks..  but obviously Power management is 
> >> gone.
> >>
> >> The system is an ATI bridged AMD Sempron notebook. I have tried Millions 
> >> of options in the kernel bootup and none seem to do clear the problem. 
> >> This system seems to suffer from the Clocks fast bug. (the dmesg reports 
> >> that the 8254 clock is disables, IO-APIC int0 fails and IO-APIC Vritual 
> >> wire is OK.. if that means anything :D)
> >>
> >> Any pointers.. and if anyone wants the AML/ACPI stuff, please feel free 
> >> to shout.
> >>     
> > Does:
> > disable_timer_pin_1
> > or
> > noapictimer
> > work?
> >
> >    Thomas
> >
> >
> >   
> 
> Thanks a Million..
> noapictimer works perfectly ... BUT  .. only on 64Bit.  acpi_pm is not 
> present on 32bit as a clocksource and it defaulted to jiffies. (tsc was 
> marked as imreliable)
> 
> I am really surprised that this Sempron notebook actually had 64Bit CPU 
> compatibility :D

This one helps for my Turion.
AFAIK, another Turion (very similar) does not need this, but I do not
know for sure.


Index: linux-2.6.25-rc6/arch/x86/kernel/cpu/amd.c
===================================================================
--- linux-2.6.25-rc6.orig/arch/x86/kernel/cpu/amd.c
+++ linux-2.6.25-rc6/arch/x86/kernel/cpu/amd.c
@@ -39,9 +39,14 @@ static __cpuinit int amd_apic_timer_brok
 {
 	u32 lo, hi;
 	u32 eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	switch (eax & CPUID_XFAM) {
 	case CPUID_XFAM_K8:
+		if (c->x86 == 15 && c->x86_model == 72 && c->x86_mask == 2) {
+			printk ("Found AMD Turion, disabling apic timer\n");
+			return 1;
+		}
 		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_F)
 			break;
 	case CPUID_XFAM_10H:
Index: linux-2.6.25-rc6/arch/x86/kernel/setup_64.c
===================================================================
--- linux-2.6.25-rc6.orig/arch/x86/kernel/setup_64.c
+++ linux-2.6.25-rc6/arch/x86/kernel/setup_64.c
@@ -627,11 +627,14 @@ static void __cpuinit early_init_amd_mc(
 static __cpuinit int amd_apic_timer_broken(void)
 {
 	u32 lo, hi, eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
-
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
   	switch (eax & CPUID_XFAM) {
 	case CPUID_XFAM_K8:
+		if (c->x86 == 15 && c->x86_model == 72 && c->x86_mask == 2) {
+			printk ("Found AMD Turion, disabling apic timer\n");
+			return 1;
+		}
 		if ((eax & CPUID_XMOD) < CPUID_XMOD_REV_F)
 			break;
 	case CPUID_XFAM_10H:


