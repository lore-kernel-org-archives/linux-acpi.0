From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] switch the Asus Pundit P1-AH2 to old acpi sleep
 ordering
Date: Sat, 21 Feb 2009 22:28:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902212228280.5009@localhost.localdomain>
References: <1234375882-5193-1-git-send-email-apw@canonical.com>
 <1234377014.6932.2.camel@t61p>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58285 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZBVD3K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Feb 2009 22:29:10 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG0072O6ZMBB20@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 21 Feb 2009 21:28:40 -0600 (CST)
In-reply-to: <1234377014.6932.2.camel@t61p>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dustin Kirkland <kirkland@canonical.com>
Cc: Andy Whitcroft <apw@canonical.com>, linux-acpi@vger.kernel.org

applied

thanks,
--
Len Brown, Intel Open Source Technology Center

On Wed, 11 Feb 2009, Dustin Kirkland wrote:

> On Wed, 2009-02-11 at 18:11 +0000, Andy Whitcroft wrote:
> > Switch the Asus Pundit P1-AH2 (M2N8L motherboard) to the old ACPI 1.0
> > sleep ordering by default.  Without this it will not suspend/resume
> > correctly.
> > 
> > Signed-off-by: Andy Whitcroft <apw@canonical.com>
> > Tested-by: Dustin Kirkland <kirkland@canonical.com>
> 
> Ack.  I've tested this and it solves this problem on this hardware.
> 
> Thanks, Andy.
> 
> > ---
> >  drivers/acpi/sleep.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 5192666..3ca9868 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -378,6 +378,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
> >  		DMI_MATCH(DMI_PRODUCT_NAME, "Macmini1,1"),
> >  		},
> >  	},
> > +	{
> > +	.callback = init_old_suspend_ordering,
> > +	.ident = "Asus Pundit P1-AH2 (M2N8L motherboard)",
> > +	.matches = {
> > +		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek Computer INC."),
> > +		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
> > +		},
> > +	},
> >  	{},
> >  };
> >  #endif /* CONFIG_SUSPEND */
> 
