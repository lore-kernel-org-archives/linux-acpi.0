From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: revert msleep patch
Date: Tue, 28 Oct 2008 00:23:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280023190.24123@localhost.localdomain>
References: <20081027213530.7104.27639.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63964 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYJ1EXh (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 00:23:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9F009X3LJ2VA03@vms173003.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Mon, 27 Oct 2008 23:23:26 -0500 (CDT)
In-reply-to: <20081027213530.7104.27639.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test

On Tue, 28 Oct 2008, Alexey Starikovskiy wrote:

> With the better solution for EC interrupt storm issue,
> there is no need to use msleep over udelay.
> 
> References:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=11810
> 	http://bugzilla.kernel.org/show_bug.cgi?id=10724
> 
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index ef42316..3ef5b79 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -239,10 +239,10 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
>  static int ec_poll(struct acpi_ec *ec)
>  {
>  	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> -	msleep(1);
> +	udelay(ACPI_EC_UDELAY);
>  	while (time_before(jiffies, delay)) {
>  		gpe_transaction(ec, acpi_ec_read_status(ec));
> -		msleep(1);
> +		udelay(ACPI_EC_UDELAY);
>  		if (ec_transaction_done(ec))
>  			return 0;
>  	}
> 
