From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 17:51:45 +0200
Message-ID: <200903291751.45455.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200903291253.05030.matze@welwarsky.de> <20090329150338.GA8500@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:15045
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZC2Pvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 11:51:51 -0400
In-Reply-To: <20090329150338.GA8500@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sunday 29 March 2009 17:03:38 Matthew Garrett wrote:
> On Sun, Mar 29, 2009 at 12:53:04PM +0200, Matthias Welwarsky wrote:
> >  	{ 0x90, SONYPI_EVENT_PKEY_P1 },
> >  	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > -	{ 0x91, SONYPI_EVENT_PKEY_P1 },
> > +	{ 0x91, SONYPI_EVENT_PKEY_P2 },
> >  	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
> >  	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
> >  	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
>
> Oops, yes...
>
> > @@ -929,7 +929,7 @@
> >  		if (sony_find_snc_handle(0x127) == ev)
> >  			key_handle = 0x127;
> >
> > -		if (handle) {
> > +		if (key_handle) {
>
> Indeed.
>
> > -		}
> > +		} else
> > +			sony_laptop_report_input_event(ev);
>
> That doesn't look right, though - sony_laptop_report_input_event expects
> a value that matches the input_index array, and an unprocessed event
> >0x90 isn't going to satisfy that.

The call to sony_laptop_report_input_event() used to be further down, right 
before the call to acpi_bus_generate_proc_event(). It was called 
unconditionally, with whatever value ev happened to have at that time, i.e. 
also unprocessed events < 0x90 or events where the translation failed. Moving 
the call makes sure that only properly processed events are reported. Without, 
I was seeing a lot of bogus events reported, e.g. volume-down when the stamina 
switch was flipped, or when the rf kill switch was operated.


