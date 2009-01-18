From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Fix crash on ASUS laptops
Date: Sat, 17 Jan 2009 20:17:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901172017390.20606@localhost.localdomain>
References: <alpine.LFD.2.00.0901171303040.3032@localhost.localdomain>
 <49721342.40305@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:55621 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbZARBSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 20:18:08 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDN0050M7LQ5JQ5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 17 Jan 2009 19:17:55 -0600 (CST)
In-reply-to: <49721342.40305@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Tero Roponen <tero.roponen@gmail.com>, linux-acpi@vger.kernel.org, len.brown@intel.com

applied.

thanks,
--
Len Brown, Intel Open Source Technology Center

On Sat, 17 Jan 2009, Alexey Starikovskiy wrote:

> Thanks, ACK
> Alex.
> Tero Roponen wrote:
> > This patch fixes the crash I experienced in 2.6.29-rc2.
> > Tested on ASUS M50vm.
> > 
> > Signed-off-by: Tero Roponen <tero.roponen@gmail.com>
> > 
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index a2b82c9..5c2f5d3 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
> >  		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
> >  		if (!saved_ec)
> >  			return -ENOMEM;
> > -		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
> > +		memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
> >  	/* fall through */
> >  	}
> >  	/* This workaround is needed only on some broken machines,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
