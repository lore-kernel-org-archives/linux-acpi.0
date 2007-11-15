From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH with title] priority fix in acpi_map_lsapic()  arch/ia64/kernel/acpi.c
Date: Thu, 15 Nov 2007 23:32:39 +0100
Message-ID: <473CC907.4040106@tiscali.nl>
References: <473CC232.6020901@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:34516 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765466AbXKOWcq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Nov 2007 17:32:46 -0500
In-Reply-To: <473CC232.6020901@tiscali.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, len.brown@intel.com
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org

As above should have been its title.

Roel Kluin wrote:
> I have sent this patch before to lkml, but it appears it wasn't picked up. Also
> I have to admit this isn't tested. This is a patch against linus' tree.
> 
> ACPI_MADT_ENABLED is defined 1    (include/acpi/actbl1.h 501)
> lapic_flags: an u32 of struct acpi_madt_local_sapic (include/acpi/actbl1.h 467)
> --
> '!' has a higher priority than '&', so as was
> this won't test the first bit, but rather evaluates to false for any non-zero
> lsapic->lapic_flags.
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 3d45d24..7d78d22 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -858,7 +858,7 @@ int acpi_map_lsapic(acpi_handle handle, int *pcpu)
>  	lsapic = (struct acpi_madt_local_sapic *)obj->buffer.pointer;
>  
>  	if ((lsapic->header.type != ACPI_MADT_TYPE_LOCAL_SAPIC) ||
> -	    (!lsapic->lapic_flags & ACPI_MADT_ENABLED)) {
> +	    (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))) {
>  		kfree(buffer.pointer);
>  		return -EINVAL;
>  	}
> 

