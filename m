From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] acpi: silence kmemcheck false positive
Date: Thu, 22 Apr 2010 16:32:20 -0600
Message-ID: <201004221632.21129.bjorn.helgaas@hp.com>
References: <20100422194346.GB29093@bicker> <20100422200220.GC29093@bicker>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:25181 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab0DVWcX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2010 18:32:23 -0400
In-Reply-To: <20100422200220.GC29093@bicker>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, vegardno@ifi.uio.no, casteyde.christian@free.fr

On Thursday 22 April 2010 02:02:20 pm Dan Carpenter wrote:
> On Thu, Apr 22, 2010 at 09:43:46PM +0200, Dan Carpenter wrote:
> > This addresses: https://bugzilla.kernel.org/show_bug.cgi?id=14998
> > 
> > We copy some strings into "event" and kmemcheck complains that the bytes 
> > after the NULL terminators are uninitialized.  That's true but it's
> > harmless.  The "event" struct is used in acpi_system_read_event() and we
> > don't read past the terminator.
> > 
> > This patch just silences the warning.
> > 
> > Reported-by: Christian Casteyde <casteyde.christian@free.fr>
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > Tested-by: Christian Casteyde <casteyde.christian@free.fr>
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 37132dc..4ef7c97 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -527,7 +527,7 @@ int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id,
> >  	if (!event_is_open)
> >  		return 0;
> >  
> > -	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
> > +	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC | __GFP_NOTRACK_FALSE_POSITIVE);

Just in terms of reading the code, this solution is fairly ugly.
I think __GFP_NOTRACK should be sort of the last resort, after we've
ruled out all the more conventional strategies.

Has anybody tried any of the alternatives Vegard suggested here:
https://bugzilla.kernel.org/show_bug.cgi?id=14998#c35 ?

Bjorn
