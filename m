From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Sun, 08 Apr 2007 22:35:49 -0700
Message-ID: <20070409053549.C7C64229527@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200704031741.42273.david-b@pacbell.net>
 <200704060843.30723.david-b@pacbell.net>
 <20070407050131.GB25511@kroah.com>
 <200704071308.07571.david-b@pacbell.net>
 <1176086185.2650.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:37260 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752940AbXDIFfw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 01:35:52 -0400
In-Reply-To: <1176086185.2650.28.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, akpm@linux-foundation.org

> On Sat, 2007-04-07 at 13:08 -0700, David Brownell wrote:
> > On Friday 06 April 2007 10:01 pm, Greg KH wrote:
> > 
> > > Are you _sure_ you have a 1-to-1 relationship here?  No multiple devices
> > > pointing to the same acpi node?  Or the other way around?  If so, you
> > > are going to have to change the name to be something more unique.
> > 
> > I've wondered that too.  The short answer:  APCI only supports 1-1
> > here.
>
> Right.
>
> >   It will emit warnings if it tries to bind more than one ACPI
> > device to a given "real" device ... but errors the other way are
> > silently ignored.
>
> My understanding is different.
> First, one "real" device can only have one device.archdata.acpi_handle,
> which means it can only be bound to one ACPI device.
> Second, AE_ALREADY_EXISTS will be returned when ACPI tries to bind more
> than one "real" devices to the same ACPI device.

Exactly.  The "first" case emits a warning, the "second" case doesn't;
no matter what it is (though I only saw ALREADY_EXISTS).


When I added a warning to that case:

> > By adding a warning over this create-links patch, I found that the
> > system in the $SUBJECT patch (and likely every ACPI system) has
> > two different nodes that correspond to one ACPI node:
> > 
> > 	/sys/devices/pci0000:00 ... pci root node
> > 	/sys/devices/pnp0/00:00 ... id PNP0a03
> > 	/sys/devices/acpi_system:00/device:00/PNP0A03:00 ... ditto
> > 
> > Arguably that's too many sysfs nodes for one device...

Presumably you've noticed this same thing (not necessarily pnp0/00:00)
on other systems ...


> > Plus, there's the issue of flakey ACPI tables; in the $SUBJECT patch
> > both MDM and AUD nodes exist in the ACPI namespace, but they could
> > only refer to one PCI device (with MDM as the wakeup source, not AUD
> > as listed in the table).  Or maybe that's another case where the ACPI
> > code isn't handling the tables as sensibly as it might...
>
> Could you attach this acpidump please? :)

Off-list; yes.

- Dave

