From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] x86/acpi: Remove the repeated lapic address override
 entry parsing
Date: Tue, 28 Jun 2016 11:30:50 +0800
Message-ID: <20160628033050.GA2732@x1.redhat.com>
References: <1467070896-4186-1-git-send-email-bhe@redhat.com>
 <1467070896-4186-2-git-send-email-bhe@redhat.com>
 <13220110.pDtUHjvoJt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbcF1DbB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 23:31:01 -0400
Content-Disposition: inline
In-Reply-To: <13220110.pDtUHjvoJt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Shaohua Li <shli@fb.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Juergen Gross <jgross@suse.com>, Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Mark Salter <msalter@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 06/28/16 at 03:25am, Rafael J. Wysocki wrote:
 
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 9414f84..6ef3694 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -990,21 +992,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
> >  	if (!boot_cpu_has(X86_FEATURE_APIC))
> >  		return -ENODEV;
> >  
> > -	/*
> > -	 * Note that the LAPIC address is obtained from the MADT (32-bit value)
> > -	 * and (optionally) overridden by a LAPIC_ADDR_OVR entry (64-bit value).
> > -	 */
> > -
> > -	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE,
> > -				      acpi_parse_lapic_addr_ovr, 0);
> > -	if (count < 0) {
> > -		printk(KERN_ERR PREFIX
> > -		       "Error parsing LAPIC address override entry\n");
> > -		return count;
> > -	}
> > -
> > -	register_lapic_address(acpi_lapic_addr);
> > -
> 
> I'm not really sure if this change is correct.
> 
> Does it only deal with the override?

Hi Rafael,

Thanks for your comments.

Yes, it only deals with the override and it will call
register_lapic_address to set fixed mapping for lapic and get value for
boot_cpu_physical_apicid. Since this has heen done in
early_acpi_boot_init() there's no need to do it again in
acpi_boot_init().


> 
> >  	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
> >  				      acpi_parse_sapic, MAX_LOCAL_APIC);
> >  
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 60078a6..504311c 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -1799,7 +1799,7 @@ void __init register_lapic_address(unsigned long address)
> >  	if (!x2apic_mode) {
> >  		set_fixmap_nocache(FIX_APIC_BASE, address);
> >  		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
> > -			    APIC_BASE, mp_lapic_addr);
> > +			    APIC_BASE, address);
> >  	}
> >  	if (boot_cpu_physical_apicid == -1U) {
> >  		boot_cpu_physical_apicid  = read_apic_id();
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index c4e7b39..059680d 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1157,6 +1157,9 @@ void __init setup_arch(char **cmdline_p)
> >  	 */
> >  	acpi_boot_table_init();
> >  
> > +	/*
> > +	 * AMD NUMA support need get boot_cpu_id earlier.
> > +	 */
> 
> Surely that's not the only goal of early_acpi_boot_init(), is it?

In commit cbf9bd60(acpi: get boot_cpu_id as early for k8_scan_nodes)
Yinghai added early_acpi_boot_init() and called it in amd numa code.
Then commit 2e42060c(x86, uv: add early detection of UV system types)
put it in arch/x86/kernel/setup.c to discover the apic type earlier.

So, you are right. This command adding is not correct.

> 
> >  	early_acpi_boot_init();
> >  
> >  	initmem_init();
> > 
> 
> Please CC ACPI-related patches to linux-acpi@vger.kernel.org.

Will do when repost.

> 
> Thanks,
> Rafael
> 
