From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [RFC] ACPI power-off on P4 HT
Date: Thu, 26 Feb 2004 11:57:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040226105744.GA3406@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local> <20040208090854.GE29363@alpha.home.local> <20040214081726.GH29363@alpha.home.local> <1076824106.25344.78.camel@dhcppc4> <20040225070019.GA30971@alpha.home.local> <1077695701.5911.130.camel@dhcppc4> <20040226075609.GA745@uberboxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040226075609.GA745-t/Pdn6GhL7X/PtFMR13I2A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gregory Finch <Uberboxen-pVBOr+mkmsReoWH0uzbU5w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello Greg,

On Wed, Feb 25, 2004 at 11:56:09PM -0800, Gregory Finch wrote:
> My workstation has a problem with power-off as well. It is a dual P3
> (Katmai) Epox motherboard with Intel 440BX chipset. About 50% of the
> time I try powering off the system, the NMI watchdog fires detecting
> CPU1 as locked up. I would be willing to try any patches that may fix
> this, as I miss being able to let my workstation shutdown on it's own.

OK, could you try this patch ? please note that it's just a test patch, not
one which should be applied to any tree !
If it hangs, it may be interesting to know what is the last line displayed.
Please halt your system out of X11 to see console messages.
It works for me on the P4 HT 100% of the time now.

Cheers,
Willy

--- linux-2.4.25/drivers/acpi/system.c	Wed Nov 19 15:31:22 2003
+++ linux-2.4.25-wt1/drivers/acpi/system.c	Mon Feb 23 20:03:27 2004
@@ -89,12 +89,69 @@
    -------------------------------------------------------------------------- */
 
 #ifdef CONFIG_PM
+#include <asm/smpboot.h>
 
 static void
 acpi_power_off (void)
 {
+	static int reboot_cpu = -1;
+	int cpuid;
 	if (unlikely(in_interrupt())) 
 		BUG();
+#ifdef CONFIG_SMP
+	
+	cpuid = GET_APIC_ID(apic_read(APIC_ID));
+	printk(KERN_EMERG "running on cpu %d\n", cpuid);
+
+	if (cpuid != boot_cpu_physical_apicid) {
+printk(KERN_EMERG "within if(cpuid)\n");
+
+		/* check to see if reboot_cpu is valid 
+		   if its not, default to the BSP */
+		if ((reboot_cpu == -1) ||  
+		      (reboot_cpu > (NR_CPUS -1))  || 
+		      !(phys_cpu_present_map & apicid_to_phys_cpu_present(cpuid)))
+			reboot_cpu = boot_cpu_physical_apicid;
+
+		/* re-run this function on the other CPUs
+		   it will fall though this section since we have 
+		   cleared reboot_smp, and do the reboot if it is the
+		   correct CPU, otherwise it halts. */
+		if (reboot_cpu != cpuid)
+			smp_call_function((void *)acpi_power_off , NULL, 1, 0);
+	}
+printk(KERN_EMERG "after if(cpuid)\n");
+
+	/* if reboot_cpu is still -1, then we want a tradional reboot, 
+	   and if we are not running on the reboot_cpu,, halt */
+	if ((reboot_cpu != -1) && (cpuid != reboot_cpu)) {
+printk(KERN_EMERG "halting this cpu: %d\n", cpuid);
+		for (;;)
+		__asm__ __volatile__ ("hlt");
+	}
+	/*
+	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
+	 * other OSs see a clean IRQ state.
+	 */
+printk(KERN_EMERG "before smp_send_stop()\n");
+	smp_send_stop();
+printk(KERN_EMERG "after smp_send_stop()\n");
+#elif CONFIG_X86_LOCAL_APIC
+	if (cpu_has_apic) {
+printk(KERN_EMERG "before __cli()\n");
+		__cli();
+printk(KERN_EMERG "between __cli() and disable_local_APIC()\n");
+		disable_local_APIC();
+printk(KERN_EMERG "between disable_local_APIC() and __sti()\n");
+		__sti();
+printk(KERN_EMERG "after __cli()\n");
+	}
+#endif
+#ifdef CONFIG_X86_IO_APIC
+printk(KERN_EMERG "before disable_IO_APIC()\n");
+	disable_IO_APIC();
+printk(KERN_EMERG "after disable_IO_APIC()\n");
+#endif
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
