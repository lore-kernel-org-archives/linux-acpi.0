From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: Don't do transaction from GPE handler in poll
 mode.
Date: Tue, 11 Nov 2008 17:22:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111722020.4480@localhost.localdomain>
References: <4919556F.6060607@suse.de>
 <20081111095411.18397.7673.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39031 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYKKWWV (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 17:22:21 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA60065AWSXKFQ1@vms173001.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 16:22:09 -0600 (CST)
In-reply-to: <20081111095411.18397.7673.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Tue, 11 Nov 2008, Alexey Starikovskiy wrote:

> Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=12004
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 628b076..985fb50 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -576,9 +576,12 @@ static u32 acpi_ec_gpe_handler(void *data)
>  	pr_debug(PREFIX "~~~> interrupt\n");
>  	status = acpi_ec_read_status(ec);
>  
> -	gpe_transaction(ec, status);
> -	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
> -		wake_up(&ec->wait);
> +	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) {
> +		gpe_transaction(ec, status);
> +		if (ec_transaction_done(ec) &&
> +		    (status & ACPI_EC_FLAG_IBF) == 0)
> +			wake_up(&ec->wait);
> +	}
>  
>  	ec_check_sci(ec, status);
>  	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> 
