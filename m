From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] x86/acpi: Remove the repeated lapic address override entry parsing
Date: Tue, 28 Jun 2016 03:25:57 +0200
Message-ID: <13220110.pDtUHjvoJt@vostro.rjw.lan>
References: <1467070896-4186-1-git-send-email-bhe@redhat.com> <1467070896-4186-2-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467070896-4186-2-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Shaohua Li <shli@fb.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Juergen Gross <jgross@suse.com>, Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Mark Salter <msalter@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, June 28, 2016 07:41:36 AM Baoquan He wrote:
> ACPI MADT has a 32-bit field providing lapic address at which
> each processor can access its lapic information. MADT also contains
> an optional entry to provide a 64-bit address to override the 32-bit
> one. However the current code does the lapic address override entry
> parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
> get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
> all MADT entries. The relevant log will be printed out twice too and
> this may confuse people.
> 
> So in this patch remove the repeated code in the 2nd part. Meanwhile
> add code comment above early_acpi_boot_init() to explain why its
> calling need be earlier, and print lapic override inforamtion like
> other MADT entry.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 17 ++---------------
>  arch/x86/kernel/apic/apic.c |  2 +-
>  arch/x86/kernel/setup.c     |  3 +++
>  3 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 9414f84..6ef3694 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -274,6 +274,8 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
>  	if (BAD_MADT_ENTRY(lapic_addr_ovr, end))
>  		return -EINVAL;
>  
> +	acpi_table_print_madt_entry(header);
> +
>  	acpi_lapic_addr = lapic_addr_ovr->address;
>  
>  	return 0;
> @@ -990,21 +992,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
>  	if (!boot_cpu_has(X86_FEATURE_APIC))
>  		return -ENODEV;
>  
> -	/*
> -	 * Note that the LAPIC address is obtained from the MADT (32-bit value)
> -	 * and (optionally) overridden by a LAPIC_ADDR_OVR entry (64-bit value).
> -	 */
> -
> -	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE,
> -				      acpi_parse_lapic_addr_ovr, 0);
> -	if (count < 0) {
> -		printk(KERN_ERR PREFIX
> -		       "Error parsing LAPIC address override entry\n");
> -		return count;
> -	}
> -
> -	register_lapic_address(acpi_lapic_addr);
> -

I'm not really sure if this change is correct.

Does it only deal with the override?

>  	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
>  				      acpi_parse_sapic, MAX_LOCAL_APIC);
>  
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 60078a6..504311c 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1799,7 +1799,7 @@ void __init register_lapic_address(unsigned long address)
>  	if (!x2apic_mode) {
>  		set_fixmap_nocache(FIX_APIC_BASE, address);
>  		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
> -			    APIC_BASE, mp_lapic_addr);
> +			    APIC_BASE, address);
>  	}
>  	if (boot_cpu_physical_apicid == -1U) {
>  		boot_cpu_physical_apicid  = read_apic_id();
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index c4e7b39..059680d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1157,6 +1157,9 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	acpi_boot_table_init();
>  
> +	/*
> +	 * AMD NUMA support need get boot_cpu_id earlier.
> +	 */

Surely that's not the only goal of early_acpi_boot_init(), is it?

>  	early_acpi_boot_init();
>  
>  	initmem_init();
> 

Please CC ACPI-related patches to linux-acpi@vger.kernel.org.

Thanks,
Rafael
