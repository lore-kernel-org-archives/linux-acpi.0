From: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: [PATCH 1/6]sep initializing rework
Date: Sat, 30 Apr 2005 14:06:56 +0200
Message-ID: <40f323d0050430050612fb15c9@mail.gmail.com>
References: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261203AbVD3MHP@vger.kernel.org>
In-Reply-To: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

On 4/12/05, Li Shaohua <shaohua.li@intel.com> wrote:
> Hi,
> These patches (together with 5 patches followed this one) are updated
> suspend/resume SMP patches. The patches fixed some bugs and do clean up
> as suggested. Now they work for both suspend-to-ram and suspend-to-disk.
> Patches are against 2.6.12-rc2-mm3.
> 
> Thanks,
> Shaohua
> 
> ---
> Make SEP init per-cpu, so it is hotplug safed.
> 
> Signed-off-by: Li Shaohua<shaohua.li@intel.com>
> 
> ---
> +++ linux-2.6.11-root/arch/i386/power/cpu.c     2005-04-12 10:36:00.175169792 +0800
> @@ -33,8 +33,6 @@ unsigned long saved_context_esp, saved_c
>  unsigned long saved_context_esi, saved_context_edi;
>  unsigned long saved_context_eflags;
> 
> -extern void enable_sep_cpu(void *);
> -
>  void __save_processor_state(struct saved_context *ctxt)
>  {
>         kernel_fpu_begin();


> diff -puN include/asm-i386/smp.h~sep_init_cleanup include/asm-i386/smp.h
> --- linux-2.6.11/include/asm-i386/smp.h~sep_init_cleanup        2005-04-12 10:36:00.170170552 +0800
> +++ linux-2.6.11-root/include/asm-i386/smp.h    2005-04-12 10:36:00.176169640 +0800
> @@ -37,6 +37,9 @@ extern int smp_num_siblings;
>  extern cpumask_t cpu_sibling_map[];
>  extern cpumask_t cpu_core_map[];
> 
> +extern int sysenter_setup(void);
> +extern void enable_sep_cpu(void);
> +
>  extern void smp_flush_tlb(void);
>  extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
>  extern void smp_invalidate_rcv(void);          /* Process an NMI */
> _

This change adds a warning when CONFIG_SMP is not set:

arch/i386/power/cpu.c: In function '__restore_processor_state':
arch/i386/power/cpu.c:137: warning: implicit declaration of function
'enable_sep_cpu'
Maybe those functions should be defined somewhere else.

regards,

Benoit
