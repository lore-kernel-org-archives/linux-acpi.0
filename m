From: Daniel Drake <dsd-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: Early init patch breaks Dell laptops
Date: Sun, 10 Oct 2004 19:42:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41698289.2020108@gentoo.org>
References: <3ACA40606221794F80A5670F0AF15F8405BD1224@pdsmsx403>	 <416822C3.1040503@gentoo.org> <1097397880.16792.23.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1097397880.16792.23.camel@d845pe>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> Let me know if this doesn't address all of the regressions.

At least for 1 user, that appears to have solved it. Thanks!

Daniel

> 
> ===== arch/i386/kernel/apic.c 1.60 vs 1.61 =====
> --- 1.60/arch/i386/kernel/apic.c	2004-10-06 21:10:37 -04:00
> +++ 1.61/arch/i386/kernel/apic.c	2004-10-10 04:12:38 -04:00
> @@ -690,22 +690,8 @@
>  		goto no_apic;
>  	}
>  
> -	if (!cpu_has_apic) {
> -		/*
> -		 * Some BIOSes disable the local APIC in the
> -		 * APIC_BASE MSR. This can only be done in
> -		 * software for Intel P6 and AMD K7 (Model > 1).
> -		 */
> -		rdmsr(MSR_IA32_APICBASE, l, h);
> -		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
> -			apic_printk(APIC_VERBOSE, "Local APIC disabled "
> -					"by BIOS -- reenabling.\n");
> -			l &= ~MSR_IA32_APICBASE_BASE;
> -			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
> -			wrmsr(MSR_IA32_APICBASE, l, h);
> -			enabled_via_apicbase = 1;
> -		}
> -	}
> +	if (!cpu_has_apic)
> +		goto no_apic;
>  	/*
>  	 * The APIC feature bit should now be enabled
>  	 * in `cpuid'



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
