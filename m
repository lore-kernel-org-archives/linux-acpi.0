From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 3/3] acpiphp: prevent duplicate slot numbers when no
	_SUN
Date: Fri, 14 Apr 2006 14:39:22 -0700
Message-ID: <1145050762.29319.38.camel@whizzy>
References: <20060412221027.472109000@intel.com>
	 <1144880327.11215.46.camel@whizzy>
	 <87bqv51wld.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31866 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965180AbWDNVao (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 17:30:44 -0400
In-Reply-To: <87bqv51wld.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, pavel@ucw.cz, temnota@kmv.ru

On Thu, 2006-04-13 at 21:36 +0900, MUNEDA Takahiro wrote:
> At Wed, 12 Apr 2006 15:18:47 -0700,
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> > 
> > Dock bridges generally do not implement _SUN, yet show up as ejectable slots.
> > If you have more than one ejectable slot that does not implement SUN, with the
> > current code you will get duplicate slot numbers.  So, if there is no _SUN,
> > use the current count of the number of slots found instead.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > 
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c |    9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > --- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp_glue.c
> > +++ 2.6-git-kca2/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -218,8 +218,13 @@ register_slot(acpi_handle handle, u32 lv
> >  		newfunc->flags |= FUNC_HAS_DCK;
> >  
> >  	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
> > -	if (ACPI_FAILURE(status))
> > -		sun = -1;
> > +	if (ACPI_FAILURE(status)) {
> > +		/*
> > +		 * use the count of the number of slots we've found
> > +		 * for the number of the slot
> > +		 */
> > +		sun = bridge->nr_slots+1;
> > +	}
> >  
> >  	/* search for objects that share the same slot */
> >  	for (slot = bridge->slots; slot; slot = slot->next)
> > 
> > --
> 
> No, "sun = bridge->nr_slots+1" might have been defined for
> another device. Please consider the following case.
> 
>   Device (PCI0) {                 /* Root bridge */
>       Name (_HID, "PNP0A03")
>       Device (P2PA) {             /* PCI-to-PCI bridge */
>           Name (_ADR, ...)
>           Device (S0F0) {         /* hotplug slot */
>               Name (_ADR, ...)
>               Name (_SUN, 0x01)
>               Method (_EJ0, ...) { ... }
>           }
>           Device (S1F0) {         /* hotplug slot */
>               Name (_ADR, ...)
>               Name (_SUN, 0x02)
>               Method (_EJ0, ...) { ... }
>           }
>           Device (GDCK) {         /* Docking Station */
>               Method (_DCK, ...) { ... }
>               Method (_EJ0, ...) { ... }
>       }
>       Device (P2PB) {             /* PCI-to-PCI bridge */
>           Name (_ADR, ...)
>           Device (S0F0) {         /* hotplug slot */
>               Name (_ADR, ...)
>               Name (_SUN, 0x03)
>               Method (_EJ0, ...) { ... }
>           }
>           Device (S1F0) {         /* hotplug slot */
>               Name (_ADR, ...)
>               Name (_SUN, 0x04)
>               Method (_EJ0, ...) { ... }
>           }
>       }
>   }
> 
> In this case, there are two hotplug slots under the P2PA.
> GDCK doesn't have SUN, so acpiphp sets SUN#3 for GDCK. But
> SUN#3 is for the PCI0.P2PB.S0F0. sun is not unique!
> 
> But I have never seen the dsdt like above.
> 
> Thanks,
> MUNE

I could invent other methods of making up sun, but it is always possible
that _SUN could be defined for whatever I make up - although of course
some numbers are less likely than others.  Personally I have never seen
a dsdt such as above either - maybe we should leave it and then change
it when we have an example of a case where we run into problems?
Alternatively, I can just bump the sun up to a number that is less
likely to be in use, such as bridge->nr_slots+100.  Opinions?

Kristen

