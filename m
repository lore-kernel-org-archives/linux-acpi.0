From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Tue, 28 Oct 2008 21:25:18 +0300
Message-ID: <4907590E.4070104@suse.de>
References: <49071C33.7030308@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44888 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751379AbYJ1SZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 14:25:21 -0400
In-Reply-To: <49071C33.7030308@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
> "plenty of line "ACPI: EC: non-query interrupt received,
>  switching to interrupt mode" in dmesg"
Probably, it is better to make pr_debug().
> 
> GPE storm avoidance involves disabling the EC GPE during transactions.
> Unfortunately we forget to re-enable EC_FLAGS_GPE_MODE afterwards.
"We" don't forget it, "we" just use same mechanism as driver init. Thus if
for some reason interrupts do not start to arrive after we issue enable_gpe(),
we will not fall to timeouts. 
> 
> This happens to work because we re-enable it anyway when we detect
> the first confirmation interrupt of the next transaction.  However,
> this causes lots of bogus "switching to interrupt mode" messages.
they are not "bogus", it is really switching the mode...
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 7f0d81c..ba47c7c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -285,6 +285,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
>  		/* check if we received SCI during transaction */
>  		ec_check_sci(ec, acpi_ec_read_status(ec));
>  		/* it is safe to enable GPE outside of transaction */
> +		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
>  		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
>  	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
>  		   t.irq_count > ACPI_EC_STORM_THRESHOLD) {
> 
> 

