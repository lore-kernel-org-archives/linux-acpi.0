From: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC 1/6]SEP initialization rework
Date: Tue, 5 Apr 2005 02:00:16 -0600 (MDT)
Message-ID: <Pine.LNX.4.61.0504050159590.2566@montezuma.fsmlabs.com>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
 <Pine.LNX.4.61.0504041235001.30273@montezuma.fsmlabs.com>
 <1112662825.17861.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1112662825.17861.4.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 5 Apr 2005, Li Shaohua wrote:

> On Tue, 2005-04-05 at 03:10, Zwane Mwaikambo wrote:
> > On Mon, 4 Apr 2005, Li Shaohua wrote:
> > 
> > >  linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
> > >  linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
> > >  linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
> > >  3 files changed, 18 insertions(+), 4 deletions(-)
> > > 
> > > diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
> > > --- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
> > > +++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
> > > @@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
> > >  	int cpu = get_cpu();
> > >  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
> > >  
> > > +	if (!boot_cpu_has(X86_FEATURE_SEP)) {
> > > +		put_cpu();
> > > +		return;
> > > +	}
> > > +
> > 
> > Do you have systems like this? Is it really skipping SEP if the boot 
> > processor doesn't have SEP?
> No, I haven't such system. This is the logic of original SEP
> initialization. If the CPU hasn't SEP, original logic doesn't call
> 'on_each_cpu(enable_sep_cpu,...)'.

Got it, so i misread.

Thanks,
	Zwane



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
