From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/6] Fix ACPI documentation in kernel-parameters.txt
Date: Wed, 7 Mar 2007 03:08:02 -0500
Message-ID: <200703070308.02500.lenb@kernel.org>
References: <200703061029.l26ATiiQ019139@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57730 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964962AbXCGIJw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:09:52 -0500
In-Reply-To: <200703061029.l26ATiiQ019139@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org, "Luck, Tony" <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, bwalle@suse.de

okay, sure.

applied.

thanks,
-Len

On Tuesday 06 March 2007 05:29, akpm@linux-foundation.org wrote:
> From: Bernhard Walle <bwalle@suse.de>
> 
> Add hint that acpi=off doesn't work on IA64.
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  Documentation/kernel-parameters.txt |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN Documentation/kernel-parameters.txt~fix-acpi-documentation-in-kernel-parameterstxt Documentation/kernel-parameters.txt
> --- a/Documentation/kernel-parameters.txt~fix-acpi-documentation-in-kernel-parameterstxt
> +++ a/Documentation/kernel-parameters.txt
> @@ -125,7 +125,8 @@ and is between 256 and 4096 characters. 
>  			See header of drivers/scsi/53c7xx.c.
>  			See also Documentation/scsi/ncr53c7xx.txt.
>  
> -	acpi=		[HW,ACPI] Advanced Configuration and Power Interface
> +	acpi=		[HW,ACPI,X86-64,i386]
> +			Advanced Configuration and Power Interface
>  			Format: { force | off | ht | strict | noirq }
>  			force -- enable ACPI if default was off
>  			off -- disable ACPI if default was on
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
