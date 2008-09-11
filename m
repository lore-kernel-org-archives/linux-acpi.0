From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 1/2] fix acpi ec read write bug
Date: Thu, 11 Sep 2008 10:10:41 +0400
Message-ID: <48C8B661.1030508@suse.de>
References: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com> <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43107 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751483AbYIKGKn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Sep 2008 02:10:43 -0400
In-Reply-To: <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hao <kexin.hao@windriver.com>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Kevin Hao wrote:
> Fill in command unit of transaction_data structure, otherwise
> gpe_transaction will skip read or write instruction.
> 
> Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
> ---
>  drivers/acpi/ec.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index bd3555c..0c65e82 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -240,6 +240,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
>  	}
>  	atomic_set(&ec->irq_count, 0);
>  	/* fill in transaction structure */
> +	ec->t.command = command;
>  	ec->t.wdata = wdata;
>  	ec->t.wlen = wdata_len;
>  	ec->t.rdata = rdata;
NAK
Command is filled in acpi_ec_write_command() in order to make window between start of
the transaction and validity of the transaction data to the bare minimum.

