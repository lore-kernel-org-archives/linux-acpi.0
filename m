From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Paravirtualizing bits of acpi access
Date: Sat, 21 Mar 2009 18:10:53 +0100
Message-ID: <200903211810.53990.rjw@sisk.pl>
References: <49C484B7.20100@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51528 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbZCURLB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Mar 2009 13:11:01 -0400
In-Reply-To: <49C484B7.20100@goop.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>

On Saturday 21 March 2009, Jeremy Fitzhardinge wrote:
> Hi Len,
> 
> I have a patch here ported from the linux2.6.18-xen tree to make host S3 
> suspend work under Xen (attached).
> 
> The salient part is this:
> 
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -46,6 +46,9 @@
>  #include "accommon.h"
>  #include "actables.h"
>  
> +#include <xen/acpi.h>
> +#include <asm/xen/hypervisor.h>
> +
>  #define _COMPONENT          ACPI_HARDWARE
>  ACPI_MODULE_NAME("hwsleep")
>  
> @@ -337,14 +340,19 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
>  
>  	ACPI_FLUSH_CPU_CACHE();
>  
> -	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
> -					PM1Acontrol);
> -	if (ACPI_FAILURE(status)) {
> -		return_ACPI_STATUS(status);
> -	}
> +	if (!xen_pv_domain()) {
> +		status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
> +						PM1Acontrol);
> +		if (ACPI_FAILURE(status)) {
> +			return_ACPI_STATUS(status);
> +		}
> +
> +		status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
> +						PM1Bcontrol);
> +	} else
> +		status = acpi_notify_hypervisor_state(sleep_state,
> +						      PM1Acontrol, PM1Bcontrol);
>  
> -	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
> -					PM1Bcontrol);
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> 
> 
> where acpi_notify_hypervisor_state() more or less maps directly onto a 
> Xen hypercall, which in turn performs the corresponding acpi operation 
> from within Xen.
> 
> I'm guessing you won't find this patch appealing as-is because it sticks 
> a great big if (xen) into an otherwise arch (and OS?) independent piece 
> of code.  In this particular instance, its fairly easy to envisage 
> encapsulating these two register writes into their own function which 
> architectures can override, which makes it fairly easy for me to put a 
> Xen hook in somewhere on the arch/x86 side of the fence.
> 
> But because Xen ends up doing the low-level cpu state save/restore, 
> several other parts of the S3 suspend path can be skipped on the Linux 
> side.  I'm wondering if you have any thoughts about how that can be 
> done, or if putting the Xen code in as-is is acceptable?
> 
> (BTW, xen_pv_domain() expands to a constant 0 when Xen isn't enabled in 
> the config, so the Xen-dependent bits will collapse down to nothing.  
> But it is defined in asm/xen/hypervisor.h, which is only present on x86 
> and ia64 architectures; on the other hand, believe those are the only 
> architectures using acpi.)

Well, why don't you implement the platform suspend operations for Xen?
I guess you don't want ACPI _PTS to be executed during suspend as well.

Rafael
