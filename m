From: "Cihula, Joseph" <joseph.cihula@intel.com>
Subject: RE: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Tue, 24 Mar 2009 10:51:02 -0700
Message-ID: <4F65016F6CB04E49BFFA15D4F7B798D9944E2524@orsmsx506.amr.corp.intel.com>
References: <49C484B7.20100@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
 <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com>
 <49C91832.8090300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36057 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbZCXRvJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 13:51:09 -0400
In-Reply-To: <49C91832.8090300@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wang, Shane" <shane.wang@intel.com>

> From: Jeremy Fitzhardinge [mailto:jeremy@goop.org]
> Sent: Tuesday, March 24, 2009 10:28 AM
>
> Bjorn Helgaas wrote:
> > On Tuesday 24 March 2009 01:05:43 am Jeremy Fitzhardinge wrote:
> >
> >> Tian, Kevin wrote:
> >>
> >>> OK, then it's safe to avoid that change. I had thought that dom0's 0-1M
> >>> is identity-mapped to machine 0-1M... :-)
> >>>
> >> No, only the ISA 640k-1M region.
> >>
> >
> > I'm speaking out of turn here because I don't work on Xen or
> > suspend/resume.  However, I do try to clean up random bits of
> > ACPI, and I have to say this patch looks like a pain in the
> > maintenance department.  Having tests for a specific hypervisor
> > is unpleasant.  We don't want to end up with tests for a collection
> > of hypervisors.
>
> I agree.  If we start to see other hypervisor-specific changes in this
> area, we'd need to rethink this approach.  But I'm not inclined to add a
> layer of infrastructure to just deal with Xen. (IOW, abstract only when
> there's something to abstract.)
>
> >   It looks like suspend becomes a weird hybrid of
> > ACPI and Xen, which makes it harder to reason about future suspend
> > changes.  And all this discussion about 640k-1M and dom0 identity
> > mapping and "there's no special effort to remap it" and whether
> > there are conflicts makes me nervous.  There's no way all those
> > assumptions can be remembered or verified five years down the road.
> >
>
> Well, I think Kevin was over-complicating things in his own mind.  The
> upshot is that the normal "running on bare metal" code can do its normal
> thing, and if we happen to be running under Xen we can make it a no-op.
> In other words, the acpi developers don't really need to worry about the
> "running under Xen case", for the most part.
>
> The two changes this patch makes are, unfortunately, unavoidable:
>
>    1. Turn the final "enter sleep" into a hypercall, so that Xen can do
>       all the low-level context save/restore.  The normal baremetal case
>       is still localized in acpica/hwsleep.c, but it (may) make an
>       excursion into arch code to see if it should do something else, and
>    2. Directly enter the sleep state, rather than save cpu context
>       (which Xen does)
>
> Though, come to think of it, perhaps there's no harm in letting the
> kernel do its own state-saving.  I'll check.
>
>     J

The Intel(R) TXT patch that I'm getting ready to post seems like it is logically very similar to Xen in its handling of shutdown (from the perspective of the kernel).  In the TXT case, the kernel performs the various HW and kernel preparation but the final platform entry into Sx is done by the tboot code (after some other work).  Below are the relevant changes from the TXT patch, where tboot_sleep() just translates the ACPI sleep param to a tboot-specific value and then calls tboot_shutdown(), and tboot_shutdown() simply calls into the tboot code to perform the actual platform sleep.

diff -r 855cb34ca992 arch/x86/kernel/reboot.c
--- a/arch/x86/kernel/reboot.c  Tue Mar 17 19:53:17 2009 -0400
+++ b/arch/x86/kernel/reboot.c  Tue Mar 24 09:37:22 2009 -0700
@@ -22,6 +22,8 @@
 #else
 # include <asm/iommu.h>
 #endif
+
+#include <asm/tboot.h>

 #include <mach_ipi.h>

@@ -436,6 +438,8 @@ static void native_machine_emergency_res
        if (reboot_emergency)
                emergency_vmx_disable_all();

+       tboot_shutdown(TB_SHUTDOWN_REBOOT);
+
        /* Tell the BIOS if we want cold or warm reboot */
        *((unsigned short *)__va(0x472)) = reboot_mode;

@@ -501,11 +505,19 @@ static void native_machine_emergency_res

 void native_machine_shutdown(void)
 {
+#ifdef CONFIG_SMP
+       /* The boot cpu is always logical cpu 0 */
+       int reboot_cpu_id = 0;
+#endif
+
+       /* TXT requires VMX to be off for all shutdowns */
+       if (tboot_in_measured_env()) {
+               emergency_vmx_disable_all();
+               local_irq_enable();
+       }
+
        /* Stop the cpus and apics */
 #ifdef CONFIG_SMP
-
-       /* The boot cpu is always logical cpu 0 */
-       int reboot_cpu_id = 0;

 #ifdef CONFIG_X86_32
        /* See if there has been given a command line override */
@@ -562,6 +574,8 @@ static void native_machine_halt(void)
        /* stop other cpus and apics */
        machine_shutdown();

+       tboot_shutdown(TB_SHUTDOWN_HALT);
+
        /* stop this cpu */
        stop_this_cpu(NULL);
 }
@@ -573,6 +587,8 @@ static void native_machine_power_off(voi
                        machine_shutdown();
                pm_power_off();
        }
+       /* a fallback in case there is no PM info available */
+       tboot_shutdown(TB_SHUTDOWN_HALT);
 }

 struct machine_ops machine_ops = {
diff -r 855cb34ca992 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c Tue Mar 17 19:53:17 2009 -0400
+++ b/arch/x86/kernel/smpboot.c Tue Mar 24 09:37:22 2009 -0700
@@ -63,6 +63,7 @@
 #include <asm/vmi.h>
 #include <asm/genapic.h>
 #include <asm/setup.h>
+#include <asm/tboot.h>
 #include <linux/mc146818rtc.h>

 #include <mach_apic.h>
@@ -1436,7 +1437,10 @@ void native_play_dead(void)
 void native_play_dead(void)
 {
        play_dead_common();
-       wbinvd_halt();
+       if (tboot_in_measured_env())
+               tboot_shutdown(TB_SHUTDOWN_WFS);
+       else
+               wbinvd_halt();
 }

 #else /* ... !CONFIG_HOTPLUG_CPU */
diff -r 855cb34ca992 drivers/acpi/acpica/hwsleep.c
--- a/drivers/acpi/acpica/hwsleep.c     Tue Mar 17 19:53:17 2009 -0400
+++ b/drivers/acpi/acpica/hwsleep.c     Tue Mar 24 09:37:22 2009 -0700
@@ -45,6 +45,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
+#include <asm/tboot.h>

 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
@@ -332,6 +333,39 @@ acpi_status asmlinkage acpi_enter_sleep_

        PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
        PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;
+
+#ifdef CONFIG_TXT
+#define TB_COPY_GAS(tbg, g)                 \
+       tbg.space_id = g.space_id;          \
+       tbg.bit_width = g.bit_width;        \
+       tbg.bit_offset = g.bit_offset;      \
+       tbg.access_width = g.access_width;  \
+       tbg.address = g.address;
+
+       if (tboot_in_measured_env()) {
+               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1a_cnt_blk,
+                           acpi_gbl_FADT.xpm1a_control_block);
+               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1b_cnt_blk,
+                           acpi_gbl_FADT.xpm1b_control_block);
+               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1a_evt_blk,
+                           acpi_gbl_FADT.xpm1a_event_block);
+               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1b_evt_blk,
+                           acpi_gbl_FADT.xpm1b_event_block);
+               tboot_shared->acpi_sinfo.pm1a_cnt_val = PM1Acontrol;
+               tboot_shared->acpi_sinfo.pm1b_cnt_val = PM1Bcontrol;
+               /* we need phys addr of waking vector, but can't use
+                  virt_to_phys() on &acpi_gbl_FACS because it is ioremap'ed,
+                  so calc from FACS phys addr */
+               tboot_shared->acpi_sinfo.wakeup_vector = acpi_gbl_FADT.facs +
+                       ((void *)&acpi_gbl_FACS->firmware_waking_vector -
+                        (void *)acpi_gbl_FACS);
+               tboot_shared->acpi_sinfo.vector_width = 32;
+               tboot_shared->acpi_sinfo.kernel_s3_resume_vector =
+                               acpi_wakeup_address;
+
+               tboot_sleep(sleep_state);
+       }
+#endif

        /* Write #2: SLP_TYP + SLP_EN */


