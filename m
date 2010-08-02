From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] acpi: x2apic entry with uid < 255 could use processor
 statement
Date: Mon, 02 Aug 2010 12:06:54 -0700
Message-ID: <1280776014.2703.9.camel@sbsiddha-MOBL3.sc.intel.com>
References: <4C53C7E7.4040204@kernel.org>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56657 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab0HBTHY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Aug 2010 15:07:24 -0400
In-Reply-To: <4C53C7E7.4040204@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Sat, 2010-07-31 at 07:51 +0100, Yinghai Lu wrote:
> According to Intel x2apic spec page 46
> 
> " The hand-off to
> OSPM will have processor IDs in the range of 0 to 254 for xAPIC/x2APIC and 0 to 255
> for SAPIC declared as either Processor() or Device() objects, but not both. Processor
> IDs outside these ranges must be declared as Device() objects."
> 
> So only check if Device is used when acpi_id >=255.
> 
> that will help system with less 255 cpus, but some cpus apic id > 255,
> still can use Processor statement instead of Device() objects.

But the entries with apic_id < 255 are supposed to use local APIC
structure and not local x2apic structure. So entries with apic id < 255
must be processed using map_lapic_id() which doesn't have any
device_declaration checks.

Only for apic ids > 255, we use map_x2apic_id() which needs device
declaration. So this patch is not needed. or Am I missing something?

thanks,
suresh

> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/acpi/processor_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/processor_core.c
> +++ linux-2.6/drivers/acpi/processor_core.c
> @@ -69,7 +69,7 @@ static int map_x2apic_id(struct acpi_sub
>  	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
>  		return 0;
>  
> -	if (device_declaration && (apic->uid == acpi_id)) {
> +	if ((device_declaration || (acpi_id < 255)) && (apic->uid == acpi_id)) {
>  		*apic_id = apic->local_apic_id;
>  		return 1;
>  	}

