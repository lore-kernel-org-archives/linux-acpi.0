From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 13/14] ACPI: Correctly recover from a failed S3 attempt
Date: Wed, 16 Aug 2006 18:00:45 -0400
Message-ID: <200608161800.45712.len.brown@intel.com>
References: <200608150537.k7F5bVsB011566@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41910 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932276AbWHPV7C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 17:59:02 -0400
In-Reply-To: <200608150537.k7F5bVsB011566@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, william.morrow@amd.com, jordan.crouse@amd.com, luming.yu@intel.com

Applied.

This may be the start of unlocking the door to a new class of S3 resume failures.

thanks,
-Len

On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
> From: William Morrrow <william.morrow@amd.com>
> 
> This was discovered on a broken BIOS that simply returned from its suspend
> procedure, appearing to the OS as a failed S3 attempt.
> 
> It is possible to invoke the protected mode register restore routine (which
> would normally restore the sysenter registers) when the bios returns from
> S3.  This has no effect on a correctly running system and repairs the
> damage from broken BIOS.
> 
> Signed-off-by: William Morrow <william.morrow@amd.com>
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Cc: "Yu, Luming" <luming.yu@intel.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/acpi/wakeup.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/acpi/wakeup.S~acpi-correctly-recover-from-a-failed-s3-attempt arch/i386/kernel/acpi/wakeup.S
> --- a/arch/i386/kernel/acpi/wakeup.S~acpi-correctly-recover-from-a-failed-s3-attempt
> +++ a/arch/i386/kernel/acpi/wakeup.S
> @@ -292,7 +292,10 @@ ENTRY(do_suspend_lowlevel)
>  	pushl	$3
>  	call	acpi_enter_sleep_state
>  	addl	$4, %esp
> -	ret
> +
> +#	In case of S3 failure, we'll emerge here.  Jump
> +# 	to ret_point to recover
> +	jmp	ret_point
>  	.p2align 4,,7
>  ret_point:
>  	call	restore_registers
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
