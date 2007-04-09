From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Mon, 09 Apr 2007 10:36:25 +0800
Message-ID: <1176086185.2650.28.camel@localhost.localdomain>
References: <200704031741.42273.david-b@pacbell.net>
	 <200704060843.30723.david-b@pacbell.net> <20070407050131.GB25511@kroah.com>
	 <200704071308.07571.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752391AbXDIChj@vger.kernel.org>
In-Reply-To: <200704071308.07571.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2007-04-07 at 13:08 -0700, David Brownell wrote:
> On Friday 06 April 2007 10:01 pm, Greg KH wrote:
> 
> > Are you _sure_ you have a 1-to-1 relationship here?  No multiple devices
> > pointing to the same acpi node?  Or the other way around?  If so, you
> > are going to have to change the name to be something more unique.
> 
> I've wondered that too.  The short answer:  APCI only supports 1-1
> here.
Right.
>   It will emit warnings if it tries to bind more than one ACPI
> device to a given "real" device ... but errors the other way are
> silently ignored.
> 
My understanding is different.
First, one "real" device can only have one device.archdata.acpi_handle,
which means it can only be bound to one ACPI device.
Second, AE_ALREADY_EXISTS will be returned when ACPI tries to bind more
than one "real" devices to the same ACPI device.
> By adding a warning over this create-links patch, I found that the
> system in the $SUBJECT patch (and likely every ACPI system) has
> two different nodes that correspond to one ACPI node:
> 
> 	/sys/devices/pci0000:00 ... pci root node
> 	/sys/devices/pnp0/00:00 ... id PNP0a03
> 	/sys/devices/acpi_system:00/device:00/PNP0A03:00 ... ditto
> 
> Arguably that's too many sysfs nodes for one device...
> 
> Plus, there's the issue of flakey ACPI tables; in the $SUBJECT patch
> both MDM and AUD nodes exist in the ACPI namespace, but they could
> only refer to one PCI device (with MDM as the wakeup source, not AUD
> as listed in the table).  Or maybe that's another case where the ACPI
> code isn't handling the tables as sensibly as it might...
> 
Could you attach this acpidump please? :)

Thanks,
Rui
