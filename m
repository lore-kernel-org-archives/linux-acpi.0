From: Nigel <nigels@hotmail.com>
Subject: RE: [repost] acpi on gentoo
Date: Mon, 12 Mar 2007 10:11:58 +0100
Message-ID: <45F5195E.6080903@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp7-g19.free.fr ([212.27.42.64]:39588 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965365AbXCLJMF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2007 05:12:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org


 > Date: Sun, 11 Mar 2007 18:57:58 +0300
 > From: alexey.y.starikovskiy@linux.intel.com
 > To: nigels@hotmail.com
 > CC: luming.yu@gmail.com; linux-acpi@vger.kernel.org
 > Subject: Re: [repost] acpi on gentoo
 >
 > Nigel wrote:
 > > response inline
 > >
 > > Luming Yu said on 11/3/2007 3:12 PM:
 > >> On 3/11/07, Nigel <nigels@hotmail.com> wrote:
 > >>>
 > >>> Trying again to see if anyone had any other ideas.
 > >>>
 > >>> In addition:
 > >>> The acpid daemon is running.
 > >>> The same machine when booted into windows will automatically go to
 > >>> powersave mode when the power cable is removed.
 > >>>
 > >>
 > >> what condition is your battery in? It makes sense if battery power is
 > >> very low.
 > > Battery #1 : present
 > > Remaining capacity : 47822 mWh, 100.0%
 > > Design capacity : 50760 mWh
 > > Last full capacity : 47822 mWh, 94.21% of design capacity
 > > (similar output was included in the original post)
 > >
 > > Regardless of battery condition should I not still get an event for
 > > removing and reinserting the power cable? (Obviously waiting for a
 > > minute or two in-between )
 > >
 > >> If battery is still full, then it sounds like a bug. You need to test
 > >> the latest base kernel before entering a acpi bug into
 > >> bugzilla.kernel.org.
 > >
 > > It works just fine on 2.6.19-r5 (gentoo)
 > > Whilst is *may* have been a bug, the issue should no longer exist on a
 > > newer kernel.
 > >
 > >>
 > >>> One interesting though, if I do : modprobe button
 > >>> then every 30 seconds or so I get:
 > >>> received event "battery BAT1 00000080 00000001"
 > >>>
 > >>> Even when i do rmmod button I still keep getting these events.
 > >>> The only way to go back to "normal" behaviour is to reboot.
 > >>>
 > >>> Any suggestions as to what might be my problem here ?
 > >>>
 > >> I guess your battery power level is low.
 > >
 > > Nope, that's not it.
 > > Don't really get your logic either. *Only* when a certain module is
 > > loaded and after that *only* a reboot stops these messages means that
 > > the battery is low?
 > >
 > >> </
 > >>
 > >
 > > So, I take it that my choice is limited to using the newer kernel ?
 > > I would normally not hesitate to use the newer kernel but my
 > > employer's vpn client is limited to 2.6.17
 > >
 > > Nigel.
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe 
linux-acpi" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at http://vger.kernel.org/majordomo-info.html
 >
 > 2.6.19-rc5 has EC driver almost re-written (drivers/acpi/ec.c). Please
 > check if putting it into 2.6.17 works/helps. You may also try to put an
 > 2.6.20/21-rc version of the same file... It has even more changes.
 >
 >
 > Regards,
 > Alex.

I tried copying all of the directories with "acpi" and a few .h files as 
well (from 2.6.19-rc5) . This is what I get:

# make
   CHK     include/linux/version.h
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/basic/split-include
   HOSTCC  scripts/basic/docproc
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/kxgettext.o
   HOSTCC  scripts/kconfig/mconf.o
   HOSTCC  scripts/kconfig/zconf.tab.o
   HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/i386/Kconfig
#
# using defaults found in .config
#
   SPLIT   include/linux/autoconf.h -> include/config/*
   CC      arch/i386/kernel/asm-offsets.s
   GEN     include/asm-i386/asm-offsets.h
   CC      scripts/mod/empty.o
   HOSTCC  scripts/mod/mk_elfconfig
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/modpost.o
   HOSTCC  scripts/mod/sumversion.o
   HOSTLD  scripts/mod/modpost
   HOSTCC  scripts/kallsyms
   HOSTCC  scripts/conmakehash
   HOSTCC  scripts/bin2c
   CC      init/main.o
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/do_mounts.o
   LD      init/mounts.o
   CC      init/initramfs.o
   CC      init/calibrate.o
   LD      init/built-in.o
   HOSTCC  usr/gen_init_cpio
   GEN     usr/initramfs_data.cpio.gz
   AS      usr/initramfs_data.o
   LD      usr/built-in.o
   CC      arch/i386/kernel/process.o
   CC      arch/i386/kernel/semaphore.o
   CC      arch/i386/kernel/signal.o
   AS      arch/i386/kernel/entry.o
   CC      arch/i386/kernel/traps.o
   CC      arch/i386/kernel/irq.o
   CC      arch/i386/kernel/ptrace.o
   CC      arch/i386/kernel/time.o
   CC      arch/i386/kernel/ioport.o
   CC      arch/i386/kernel/ldt.o
   CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c: In function 'parse_cmdline_early':
arch/i386/kernel/setup.c:869: warning: implicit declaration of function 
'disable_ioapic_setup'
   CC      arch/i386/kernel/i8259.o
   CC      arch/i386/kernel/sys_i386.o
   CC      arch/i386/kernel/pci-dma.o
   CC      arch/i386/kernel/i386_ksyms.o
   CC      arch/i386/kernel/i387.o
   CC      arch/i386/kernel/bootflag.o
   CC      arch/i386/kernel/quirks.o
   CC      arch/i386/kernel/i8237.o
   CC      arch/i386/kernel/topology.o
   CC      arch/i386/kernel/alternative.o
   CC      arch/i386/kernel/acpi/boot.o
   CC      arch/i386/kernel/acpi/earlyquirk.o
arch/i386/kernel/acpi/earlyquirk.c: In function 'check_acpi_pci':
arch/i386/kernel/acpi/earlyquirk.c:60: warning: implicit declaration of 
function 'early_pci_allowed'
   CC      arch/i386/kernel/acpi/cstate.o
arch/i386/kernel/acpi/cstate.c: In function 
'acpi_processor_ffh_cstate_enter':
arch/i386/kernel/acpi/cstate.c:141: warning: implicit declaration of 
function 'mwait_idle_with_hints'
   CC      arch/i386/kernel/acpi/processor.o
   LD      arch/i386/kernel/acpi/built-in.o
   CC      arch/i386/kernel/cpu/common.o
   CC      arch/i386/kernel/cpu/proc.o
   CC      arch/i386/kernel/cpu/amd.o
   CC      arch/i386/kernel/cpu/cyrix.o
   CC      arch/i386/kernel/cpu/centaur.o
   CC      arch/i386/kernel/cpu/transmeta.o
arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
arch/i386/kernel/cpu/transmeta.c:12: warning: 'cpu_freq' may be used 
uninitialized in this function
   CC      arch/i386/kernel/cpu/intel.o
   CC      arch/i386/kernel/cpu/intel_cacheinfo.o
   CC      arch/i386/kernel/cpu/rise.o
   CC      arch/i386/kernel/cpu/nexgen.o
   CC      arch/i386/kernel/cpu/umc.o
   LD      arch/i386/kernel/cpu/cpufreq/built-in.o
   CC [M]  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o
   CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
   CC      arch/i386/kernel/cpu/mcheck/mce.o
   CC      arch/i386/kernel/cpu/mcheck/k7.o
   CC      arch/i386/kernel/cpu/mcheck/p4.o
   CC      arch/i386/kernel/cpu/mcheck/p5.o
   CC      arch/i386/kernel/cpu/mcheck/p6.o
   CC      arch/i386/kernel/cpu/mcheck/winchip.o
   CC      arch/i386/kernel/cpu/mcheck/non-fatal.o
   LD      arch/i386/kernel/cpu/mcheck/built-in.o
   CC      arch/i386/kernel/cpu/mtrr/main.o
   CC      arch/i386/kernel/cpu/mtrr/if.o
   CC      arch/i386/kernel/cpu/mtrr/generic.o
   CC      arch/i386/kernel/cpu/mtrr/state.o
   CC      arch/i386/kernel/cpu/mtrr/amd.o
   CC      arch/i386/kernel/cpu/mtrr/cyrix.o
   CC      arch/i386/kernel/cpu/mtrr/centaur.o
   LD      arch/i386/kernel/cpu/mtrr/built-in.o
   LD      arch/i386/kernel/cpu/built-in.o
   CC      arch/i386/kernel/timers/timer.o
   CC      arch/i386/kernel/timers/timer_none.o
   CC      arch/i386/kernel/timers/timer_tsc.o
   CC      arch/i386/kernel/timers/timer_pit.o
   CC      arch/i386/kernel/timers/common.o
   CC      arch/i386/kernel/timers/timer_pm.o
   LD      arch/i386/kernel/timers/built-in.o
   CC      arch/i386/kernel/reboot.o
   CC      arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function 'apm':
arch/i386/kernel/apm.c:1285: warning: 'event' may be used uninitialized 
in this function
   CC      arch/i386/kernel/mpparse.o
   CC      arch/i386/kernel/apic.o
   CC      arch/i386/kernel/nmi.o
   CC      arch/i386/kernel/io_apic.o
   CC      arch/i386/kernel/module.o
   CC      arch/i386/kernel/sysenter.o
   LDS     arch/i386/kernel/vsyscall.lds
   AS      arch/i386/kernel/vsyscall-int80.o
   AS      arch/i386/kernel/vsyscall-note.o
   SYSCALL arch/i386/kernel/vsyscall-int80.so
   AS      arch/i386/kernel/vsyscall-sysenter.o
   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
   AS      arch/i386/kernel/vsyscall.o
   CC      arch/i386/kernel/doublefault.o
   CC      arch/i386/kernel/vm86.o
   CC      arch/i386/kernel/early_printk.o
   SYSCALL arch/i386/kernel/vsyscall-syms.o
   LD      arch/i386/kernel/built-in.o
arch/i386/kernel/acpi/built-in.o:(.bss+0x0): multiple definition of 
`acpi_disabled'
arch/i386/kernel/setup.o:(.bss+0x4): first defined here
make[1]: *** [arch/i386/kernel/built-in.o] Error 1
make: *** [arch/i386/kernel] Error 2

If there is a relatively simple way to get this to work. Let me know.
Otherwise I'll just leave it, and hopefully in a year or so I'll be able 
  to upgrade.

Thanks,
Nigel.
