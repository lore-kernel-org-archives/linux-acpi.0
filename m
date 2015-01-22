From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] ACPI/EC: Cleanup transaction wakeup code
Date: Thu, 22 Jan 2015 17:00:53 +0100
Message-ID: <10635172.oMTtcxH2fm@vostro.rjw.lan>
References: <cover.1418966602.git.lv.zheng@intel.com> <5637874.BqR4k3zUAA@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E88026B9F86@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59732 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752500AbbAVPiQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jan 2015 10:38:16 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026B9F86@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, January 22, 2015 06:37:28 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Thursday, January 22, 2015 6:17 AM
> > 
> > On Wednesday, January 14, 2015 07:28:22 PM Lv Zheng wrote:
> > > This patch moves transaction wakeup code into advance_transaction().
> > > No functional changes.
> > >
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > ---
> > >  drivers/acpi/ec.c |   17 +++++++++--------
> > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > > index 1b5853f..3e19123 100644
> > > --- a/drivers/acpi/ec.c
> > > +++ b/drivers/acpi/ec.c
> > > @@ -200,7 +200,7 @@ static int ec_transaction_completed(struct acpi_ec *ec)
> > >  	return ret;
> > >  }
> > >
> > > -static bool advance_transaction(struct acpi_ec *ec)
> > > +static void advance_transaction(struct acpi_ec *ec)
> > >  {
> > >  	struct transaction *t;
> > >  	u8 status;
> > > @@ -235,7 +235,7 @@ static bool advance_transaction(struct acpi_ec *ec)
> > >  			t->flags |= ACPI_EC_COMMAND_COMPLETE;
> > >  			wakeup = true;
> > >  		}
> > > -		return wakeup;
> > > +		goto out;
> > >  	} else {
> > >  		if (EC_FLAGS_QUERY_HANDSHAKE &&
> > >  		    !(status & ACPI_EC_FLAG_SCI) &&
> > > @@ -251,7 +251,7 @@ static bool advance_transaction(struct acpi_ec *ec)
> > >  			t->flags |= ACPI_EC_COMMAND_POLL;
> > >  		} else
> > >  			goto err;
> > > -		return wakeup;
> > > +		goto out;
> > >  	}
> > >  err:
> > >  	/*
> > > @@ -262,14 +262,16 @@ err:
> > >  		if (in_interrupt() && t)
> > >  			++t->irq_count;
> > >  	}
> > > -	return wakeup;
> > > +out:
> > > +	if (wakeup && in_interrupt())
> > > +		wake_up(&ec->wait);
> > >  }
> > >
> > >  static void start_transaction(struct acpi_ec *ec)
> > >  {
> > >  	ec->curr->irq_count = ec->curr->wi = ec->curr->ri = 0;
> > >  	ec->curr->flags = 0;
> > > -	(void)advance_transaction(ec);
> > > +	advance_transaction(ec);
> > 
> > Well, this looks like a functional change, because we wouldn't call
> > wake_up(&ec->wait) here before.
> 
> Ah, Yes.
> But here, since the only advancement that can happen here is to send the EC command and there are always further advancements until transaction completion, the wake_up() won't be invoked at this point.
> So IMO, there is no functional changes here.
> 
> > 
> > >  }
> > >
> > >  static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
> > > @@ -304,7 +306,7 @@ static int ec_poll(struct acpi_ec *ec)
> > >  					return 0;
> > >  			}
> > >  			spin_lock_irqsave(&ec->lock, flags);
> > > -			(void)advance_transaction(ec);
> > > +			advance_transaction(ec);
> > 
> > Ditto.
> 
> Yes. I changed this logic.
> 
> By invoking wake_up() here, we can break the ec_poll() loop.
> Because if the transaction has completed due to the polling advancement, we really don't need to wait for another interrupt.
> So this new logic makes this patch more like a race fix, not a simple cleanup.
> And IMO, it might also be a stable material.
> I didn't notice this race bug because there is no bug report against this.
> 
> Should I change the description around this and re-send the patch?

Yes, please.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
