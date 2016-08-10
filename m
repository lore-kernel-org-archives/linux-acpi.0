From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3 1/2] x86/mm/numa: Open code function
 early_get_boot_cpu_id
Date: Wed, 10 Aug 2016 22:39:53 +0800
Message-ID: <20160810143953.GB5477@x1.redhat.com>
References: <1469877001-18393-1-git-send-email-bhe@redhat.com>
 <20160810140148.GA22965@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160810140148.GA22965@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/10/16 at 04:01pm, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > Previously early_acpi_boot_init is called in early_get_boot_cpu_id()
> > to get value for boot_cpu_physical_apicid. Now early_acpi_boot_init()
> > has been taken out and moved to setup_arch(), the name of
> > early_get_boot_cpu_id doesn't match its implementation. And only the
> > getting boot-time SMP configuration code is left. So in this patch
> > open code it.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v1->v3:
> >   No change from v1.
> > 
> >  arch/x86/mm/amdtopology.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
> > index 2ca15b59..9928dad 100644
> > --- a/arch/x86/mm/amdtopology.c
> > +++ b/arch/x86/mm/amdtopology.c
> > @@ -53,21 +53,6 @@ static __init int find_northbridge(void)
> >  	return -ENOENT;
> >  }
> >  
> > -static __init void early_get_boot_cpu_id(void)
> > -{
> > -	/*
> > -	 * need to get the APIC ID of the BSP so can use that to
> > -	 * create apicid_to_node in amd_scan_nodes()
> > -	 */
> > -#ifdef CONFIG_X86_MPPARSE
> > -	/*
> > -	 * get boot-time SMP configuration:
> > -	 */
> > -	if (smp_found_config)
> > -		early_get_smp_config();
> > -#endif
> > -}
> > -
> >  int __init amd_numa_init(void)
> >  {
> >  	u64 start = PFN_PHYS(0);
> > @@ -181,8 +166,14 @@ int __init amd_numa_init(void)
> >  	cores = 1 << bits;
> >  	apicid_base = 0;
> >  
> > -	/* get the APIC ID of the BSP early for systems with apicid lifting */
> > -	early_get_boot_cpu_id();
> > +#ifdef CONFIG_X86_MPPARSE
> > +	/*
> > +	 * get boot-time SMP configuration:
> > +	 */
> > +	if (smp_found_config)
> > +		early_get_smp_config();
> > +#endif
> 
> So I think this cleanup could be improved: any reason why the smp_found_config 
> check is not done in early_get_smp_config()?

Yes, you are quite right. Both early_get_smp_config and get_smp_config
call default_get_smp_config() if CONFIG_X86_MPPARSE is defined. The
smp_found_config check should be done inside default_get_smp_config to
simplify code.

> 
> Plus it appears there's already a !CONFIG_X86_MPPARSE version of 
> early_get_smp_config() [but please double check that it's available under all 
> legitimate Kconfig variants] so we could drop the ugly #ifdef as well.

Yes, just as you said, if !CONFIG_X86_MPPARSE default_get_smp_config()
will be defined as x86_init_noop in arch/x86/include/asm/mpspec.h. So
the #ifdef checking can be removed.

I will repost with the change you suggested. Thanks for your comments.

Thanks
Baoquan
