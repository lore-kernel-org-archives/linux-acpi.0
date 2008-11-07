From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: EC: make kernel messages more useful when GPE storm is
 detected
Date: Thu, 06 Nov 2008 22:47:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062247230.3106@localhost.localdomain>
References: <490C37F6.5060000@tuffmail.co.uk> <490C4C76.8050605@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:54562 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYKGDrc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 22:47:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y006NO2J7HZ21@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 21:47:32 -0600 (CST)
In-reply-to: <490C4C76.8050605@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

applied.

thanks,
-len

On Sat, 1 Nov 2008, Alexey Starikovskiy wrote:

> ACK
> Thanks,
> Alex.
> Alan Jenkins wrote:
> > Make sure we can tell if the GPE storm workaround gets activated,
> > and avoid flooding the logs afterwards.
> > 
> > <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
> > "plenty of line "ACPI: EC: non-query interrupt received,
> >  switching to interrupt mode" in dmesg"
> > 
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index ef42316..139046c 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -286,7 +286,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec
> > *ec,
> >  		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
> >  	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> >  		   t->irq_count > ACPI_EC_STORM_THRESHOLD) {
> > -		pr_debug(PREFIX "GPE storm detected\n");
> > +		pr_info(PREFIX "GPE storm detected, "
> > +			"transactions will use polling mode\n");
> >  		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
> >  	}
> >  	return ret;
> > @@ -566,9 +567,15 @@ static u32 acpi_ec_gpe_handler(void *data)
> >  	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
> >  	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
> >  		/* this is non-query, must be confirmation */
> > -		if (printk_ratelimit())
> > -			pr_info(PREFIX "non-query interrupt received,"
> > +		if (!test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> > +			if (printk_ratelimit())
> > +				pr_info(PREFIX "non-query interrupt received,"
> > +					" switching to interrupt mode\n");
> > +		} else {
> > +			/* hush, STORM switches the mode every transaction */
> > +			pr_debug(PREFIX "non-query interrupt received,"
> >  				" switching to interrupt mode\n");
> > +		}
> >  		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
> >  	}
> >  	return ACPI_INTERRUPT_HANDLED;
> > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
