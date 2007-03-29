From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/4] cpuidle: unsigned bitfield
Date: Wed, 28 Mar 2007 22:56:27 -0400
Message-ID: <200703282256.28050.lenb@kernel.org>
References: <200703270538.l2R5cmFX007936@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55775 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965915AbXC2C51 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2007 22:57:27 -0400
In-Reply-To: <200703270538.l2R5cmFX007936@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, venkatesh.pallipadi@intel.com

applied

thanks,
-len

On Tuesday 27 March 2007 01:38, akpm@linux-foundation.org wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> A 1-bit bitfield has no room for a sign bit.
> drivers/cpuidle/governors/ladder.c:54:16: error: dubious bitfield without explicit `signed' or `unsigned'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/cpuidle/governors/ladder.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/cpuidle/governors/ladder.c~cpuidle-unsigned-bitfield drivers/cpuidle/governors/ladder.c
> --- a/drivers/cpuidle/governors/ladder.c~cpuidle-unsigned-bitfield
> +++ a/drivers/cpuidle/governors/ladder.c
> @@ -51,7 +51,7 @@ struct ladder_device_state {
>  
>  struct ladder_device {
>  	struct ladder_device_state states[CPUIDLE_STATE_MAX];
> -	int bm_check:1;
> +	unsigned int bm_check:1;
>  	unsigned long bm_check_timestamp;
>  	unsigned long bm_activity; /* FIXME: bm activity should be global */
>  	int last_state_idx;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
