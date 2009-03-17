From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/8] acpi: get_throttling_state() cannot be larger than
 state_count
Date: Tue, 17 Mar 2009 01:19:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903170119160.4473@localhost.localdomain>
References: <200903041955.n24JtRIO027997@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45021 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZCQFT5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 01:19:57 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGM000QSXH7ZDEB@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 17 Mar 2009 00:19:56 -0500 (CDT)
In-reply-to: <200903041955.n24JtRIO027997@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, roel.kluin@gmail.com, yakui.zhao@intel.com

Andrew,
you'll want to drop this one from your series
b/c I checked in the simpler version.

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

> From: Roel Kluin <roel.kluin@gmail.com>
> 
> With for(i = 0; i < n; i++) { ... } i reaches n.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Acked-by: <yakui.zhao@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/processor_throttling.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count drivers/acpi/processor_throttling.c
> --- a/drivers/acpi/processor_throttling.c~acpi-get_throttling_state-cannot-be-larger-state_count
> +++ a/drivers/acpi/processor_throttling.c
> @@ -785,7 +785,7 @@ static int acpi_get_throttling_state(str
>  		if (tx->control == value)
>  			break;
>  	}
> -	if (i > pr->throttling.state_count)
> +	if (i >= pr->throttling.state_count)
>  		i = -1;
>  	return i;
>  }
> _
> 
