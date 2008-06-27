From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 14:53:05 +0200
Message-ID: <4864E2B1.3040308@keyaccess.nl>
References: <20080627123316.8122.15241.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:40007 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYF0MwW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2008 08:52:22 -0400
In-Reply-To: <20080627123316.8122.15241.stgit@warthog.procyon.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: bjorn.helgaas@hp.com, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On 27-06-08 14:33, David Howells wrote:

> Fix the test pnpacpi_parse_irq_option() makes against PNP_IRQ_NR by sticking
> p->interrupt[i] into an unsigned int and then using it in the three places
> that want it.

Pedantically, a simple unadorned int would be better it seems. The 
#define is an int, __set_bit(_) takes an int and an int is printed.

> This gets rid of the warning:
> 
> drivers/pnp/pnpacpi/rsparser.c:500: warning: comparison is always true due to limited range of data type
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/pnp/pnpacpi/rsparser.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
> index d2abc87..b0d89eb 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -497,12 +497,13 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
>  	bitmap_zero(map.bits, PNP_IRQ_NR);
>  	for (i = 0; i < p->interrupt_count; i++) {
>  		if (p->interrupts[i]) {
> -			if (p->interrupts[i] < PNP_IRQ_NR)
> -				__set_bit(p->interrupts[i], map.bits);
> +			unsigned irq = p->interrupts[i];
> +			if (irq  < PNP_IRQ_NR)

Hyper-pedantically, this adds one space too many :-)

> +				__set_bit(irq, map.bits);
>  			else
>  				dev_err(&dev->dev, "ignoring IRQ %d option "
>  					"(too large for %d entry bitmap)\n",
> -					p->interrupts[i], PNP_IRQ_NR);
> +					irq, PNP_IRQ_NR);
>  		}
>  	}
>  

Rene.
