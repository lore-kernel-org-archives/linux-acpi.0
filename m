From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] [15/105] x86_64: Add documentation for CPU hotplug ACPI  extension
Date: Mon, 16 Jan 2006 23:08:58 +0100
Message-ID: <200601162308.59433.ak@suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005B83B30@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005B83B30-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 16 January 2006 23:02, Brown, Len wrote:
> (corrected Ashok Raj's e-mail address, added linux-acpi).
> 
> One problem here is that big systems will not specify
> even all the _present_ CPUs in the MADT -- they'll be
> in the DSDT; as the MADT method I s limited to 256.

The x86 APICs are limited to 256 CPUs anyways, so I don't see
any bigger systems any time soon. Before going to that
size x86 Linux will have many other scaling issues fixed
anyways - for example you can't have more than 256 interrupt
vectors right now and only one per CPU is definitely not
enough. There are other issues like this. I would guess
the practical limit right now is 64 maybe 128 threads

Anyways, DSDT is supported too. We'll use the standard
callback which is AFAIK run by the DSDT too.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
