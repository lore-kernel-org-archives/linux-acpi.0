From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 1/6]SEP initialization rework
Date: Mon, 04 Apr 2005 16:52:26 +0800
Message-ID: <1112604746.4194.374.camel@sli10-desk.sh.intel.com>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
	 <20050404084638.GB14642@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050404084638.GB14642-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Mon, 2005-04-04 at 16:46, Pavel Machek wrote:
> > ---
> > 
> >  linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
> >  linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
> >  linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
> > --- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
> > +++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
> > @@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
> >  	int cpu = get_cpu();
> >  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
> >  
> > +	if (!boot_cpu_has(X86_FEATURE_SEP)) {
> > +		put_cpu();
> > +		return;
> > +	}
> > +
> >  	tss->ss1 = __KERNEL_CS;
> >  	tss->esp1 = sizeof(struct tss_struct) + (unsigned long) tss;
> >  	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
> > @@ -41,7 +46,7 @@ void enable_sep_cpu(void *info)
> >  extern const char vsyscall_int80_start, vsyscall_int80_end;
> >  extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
> >  
> > -static int __init sysenter_setup(void)
> > +int __init sysenter_setup(void)
> >  {
> >  	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
> >  
> 
> Can this still be __init? I think you are calling it from hotplug code
> now, right?
Only BP executes it. AP calls enable_sep_cpu.

> 
> > diff -puN arch/i386/kernel/smpboot.c~sep_init_cleanup arch/i386/kernel/smpboot.c
> > --- linux-2.6.11/arch/i386/kernel/smpboot.c~sep_init_cleanup	2005-03-28 09:33:49.972288952 +0800
> > +++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-03-28 09:46:01.814032096 +0800
> > @@ -415,6 +415,8 @@ static void __init smp_callin(void)
> >  
> >  static int cpucount;
> >  
> > +extern int sysenter_setup(void);
> > +extern void enable_sep_cpu(void *);
> >  /*
> >   * Activate a secondary processor.
> >   */
> 
> Perhaps these should go to header file somewhere?
in asm-i386/smp.h?

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
