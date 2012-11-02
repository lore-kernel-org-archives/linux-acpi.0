From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] ACPI: EC: Don't count a SCI interrupt as a false one
Date: Fri, 02 Nov 2012 13:48:38 +0100
Message-ID: <3194270.jpLtSvvqWu@vostro.rjw.lan>
References: <1351561961-23821-1-git-send-email-feng.tang@intel.com> <1351561961-23821-4-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52153 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2KBMob (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Nov 2012 08:44:31 -0400
In-Reply-To: <1351561961-23821-4-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, October 30, 2012 09:52:41 AM Feng Tang wrote:
> Currently when advance_transaction() is called in EC interrupt handler,
> if there is nothing driver can do with the interrupt, it will be taken
> as a false one.
> 
> But this is not always true, as there may be a SCI EC interrupt fired
> during normal read/write operation, which should not be counted as a
> false one. This patch fixes the problem.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael



> ---
>  drivers/acpi/ec.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index f272880..6bdea02 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -198,9 +198,13 @@ static void advance_transaction(struct acpi_ec *ec, u8 status)
>  		t->done = true;
>  	goto unlock;
>  err:
> -	/* false interrupt, state didn't change */
> -	if (in_interrupt())
> +	/*
> +	 * If SCI bit is set, then don't think it's a false IRQ
> +	 * otherwise will take a not handled IRQ as a false one.
> +	 */
> +	if (in_interrupt() && !(status & ACPI_EC_FLAG_SCI))
>  		++t->irq_count;
> +
>  unlock:
>  	spin_unlock_irqrestore(&ec->lock, flags);
>  }
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
