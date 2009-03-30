From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Mon, 30 Mar 2009 08:20:23 +0200
Message-ID: <200903300820.23868.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <20090329164107.GA9566@srcf.ucam.org> <20090330035238.GA3317@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:23733
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbZC3GUa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 02:20:30 -0400
In-Reply-To: <20090330035238.GA3317@kamineko.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Monday 30 March 2009 05:52:39 Mattia Dongili wrote:
> On Sun, Mar 29, 2009 at 05:41:07PM +0100, Matthew Garrett wrote:
> > On Sun, Mar 29, 2009 at 06:38:14PM +0200, Matthias Welwarsky wrote:
> > > Whoops, just noticed that there was a bug in my patch. No wonder it
> > > confused you.  Should untranslated events >= 0x90 still generate ACPI
> > > events? In that case, the following patch would fix it. If not, the
> > > acpi event reporting must be moved into the else path, too.
> >
> > I don't think it's likely to be useful - if we ever implement support
> > for them then we'll generate different events and generate user
> > confusion.
>
> yes, but up to 2.6.29 they are being reported for all the models
> supported by the former SNC initialization code. I'd rather keep them
> until /proc/acpi/event goes away.

Hm, but if you keep them, there would be the possibility of ambiguous events. 
Events >= 0x90 are being translated and possibly (mostly) become < 0x90, so 
there's something like a namespace clash here. I think there should be a 
marker for translated events.

> > > --- sony-laptop.c.orig	2009-03-29 12:41:44.000000000 +0200
> > > +++ sony-laptop.c	2009-03-29 18:36:31.000000000 +0200
> > > @@ -865,7 +865,7 @@
> > >  static struct sony_nc_event sony_100_events[] = {
> > >  	{ 0x90, SONYPI_EVENT_PKEY_P1 },
> > >  	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > > -	{ 0x91, SONYPI_EVENT_PKEY_P1 },
> > > +	{ 0x91, SONYPI_EVENT_PKEY_P2 },
> > >  	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > >  	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
> > >  	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
> > > @@ -929,7 +929,7 @@
> > >  		if (sony_find_snc_handle(0x127) == ev)
> > >  			key_handle = 0x127;
> > >
> > > -		if (handle) {
> > > +		if (key_handle) {
> > >  			struct sony_nc_event *key_event;
> > >
> > >  			if (sony_call_snc_handle(key_handle, 0x200, &result))
> > > @@ -955,15 +955,16 @@
> > >  				printk(KERN_INFO DRV_PFX
> > >  				       "Unknown event: 0x%x 0x%x\n", key_handle,
> > >  				       ev);
> > > -			}
> > > +			} else
> > > +				sony_laptop_report_input_event(ev);
> > >  		} else if (sony_find_snc_handle(0x124) == ev) {
> > >  			sony_nc_rfkill_update();
> > >  			return;
> > >  		}
> > > -	}
> > > +	} else
> > > +		sony_laptop_report_input_event(ev);
> > >
> > >  	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
> > > -	sony_laptop_report_input_event(ev);
> > >  	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
> > >  }
> >
> > Yes, that looks good, just move the acpi_bus_generate_proc_event into
> > the same blocks as sony_laptop_report_input_event.
> >
> > Acked-by: Matthew Garrett <mjg@redhat.com>
>
> I'll take this version of the patch.

What's about rfkill then? Should rfkill hardware switch activations also send 
an acpi event in addition? Currently they don't.

> Len, this patch isn't upstream yet, would you prefer me to resend
> only this one with the fixes from Matthias merged in or do you want it
> as a separate fix?
>
> Also, Matthias can we have your signoff line?

I'll resend the patch with a proper sign-off once we're clear about these 
questions, ok?

regards,
matthias
