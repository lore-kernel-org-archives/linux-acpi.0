From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 17:41:07 +0100
Message-ID: <20090329164107.GA9566@srcf.ucam.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200903291751.45455.matze@welwarsky.de> <20090329160212.GA9129@srcf.ucam.org> <200903291838.14723.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52892 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759177AbZC2QlM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 12:41:12 -0400
Content-Disposition: inline
In-Reply-To: <200903291838.14723.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sun, Mar 29, 2009 at 06:38:14PM +0200, Matthias Welwarsky wrote:

> Whoops, just noticed that there was a bug in my patch. No wonder it confused 
> you.  Should untranslated events >= 0x90 still generate ACPI events? In that 
> case, the following patch would fix it. If not, the acpi event reporting must 
> be moved into the else path, too.

I don't think it's likely to be useful - if we ever implement support 
for them then we'll generate different events and generate user 
confusion.

> --- sony-laptop.c.orig	2009-03-29 12:41:44.000000000 +0200
> +++ sony-laptop.c	2009-03-29 18:36:31.000000000 +0200
> @@ -865,7 +865,7 @@
>  static struct sony_nc_event sony_100_events[] = {
>  	{ 0x90, SONYPI_EVENT_PKEY_P1 },
>  	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
> -	{ 0x91, SONYPI_EVENT_PKEY_P1 },
> +	{ 0x91, SONYPI_EVENT_PKEY_P2 },
>  	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
>  	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
>  	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
> @@ -929,7 +929,7 @@
>  		if (sony_find_snc_handle(0x127) == ev)
>  			key_handle = 0x127;
>  
> -		if (handle) {
> +		if (key_handle) {
>  			struct sony_nc_event *key_event;
>  
>  			if (sony_call_snc_handle(key_handle, 0x200, &result))
> @@ -955,15 +955,16 @@
>  				printk(KERN_INFO DRV_PFX
>  				       "Unknown event: 0x%x 0x%x\n", key_handle,
>  				       ev);
> -			}
> +			} else
> +				sony_laptop_report_input_event(ev);
>  		} else if (sony_find_snc_handle(0x124) == ev) {
>  			sony_nc_rfkill_update();
>  			return;
>  		}
> -	}
> +	} else
> +		sony_laptop_report_input_event(ev);
>  
>  	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
> -	sony_laptop_report_input_event(ev);
>  	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
>  }

Yes, that looks good, just move the acpi_bus_generate_proc_event into 
the same blocks as sony_laptop_report_input_event.

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
