From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: what is writing to /sys/bus/pci/slot/<slot_no>/power really
 supposed to do?
Date: Mon, 1 Oct 2007 10:35:57 -0700
Message-ID: <20071001103557.a1252b78.kristen.c.accardi@intel.com>
References: <20071001100858.06919a1e.kristen.c.accardi@intel.com>
	<20071001171932.GA6801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52751 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbXJARmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 13:42:38 -0400
In-Reply-To: <20071001171932.GA6801@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Mon, 1 Oct 2007 10:19:32 -0700
Greg KH <gregkh@suse.de> wrote:

> On Mon, Oct 01, 2007 at 10:08:58AM -0700, Kristen Carlson Accardi wrote:
> > Hi,
> > I notice in acpiphp that the code path for powering down the slot
> > via sysfs does not execute the _EJ0 method, but instead simply
> > looks for _PS3 and of couse disables all the bridges and devices.  
> > I suppose this could be valid depending on your definition of what 
> > /sys/bus/pci/slots/<slot_no>/power should do.
> > 
> > Is it intended to just power down the adapter that's in the slot, 
> > or is it intended to make the adapter in the slot able to be removed?
> > If it's intended to make the adapter able to be removed, shouldn't
> > we be calling _EJ0?
> 
> If that is required to power down the device, yes, it should be called.

So - here's where we get to interpret.  The spec says that _EJ0 is
used to "eject" the card.  From the spec:
6.3.3 _EJx (Eject)
These control methods are optional and are supplied for devices that 
support a software-controlled VCR-style ejection mechanism or that 
require an action be performed such as isolation of power/data lines 
before the device can be removed from the system. 
<snip>
For hot removal, the device must be immediately ejected when OSPM calls 
the _EJ0 control method. The _EJ0 control method does not return until 
ejection is complete. After calling _EJ0, OSPM verifies the
device no longer exists to determine if the eject succeeded. 
For _HID devices, OSPM evaluates the _STA method. For _ADR devices, 
OSPM checks with the bus driver for that device.

So, when I read this, it seems like if a vendor followed the spec,
executing _EJ0 would hang until we physically pulled the card out
of the system, which seems bad.  So, maybe this is why we don't call
_EJ0?  

_PS3 apparently is used to put a device into D3.  By "device" here
I'm not sure if we are talking about the adapter in the slot, or the
slot itself.


> 
> > As a comparison, in pciehp when the sysfs power file is written,
> > we do actually go out and send the commands to the hotplug controller
> > to physically power off the slot.
> 
> Yes, that is the intention of writing that value to that file.  The
> power should be gone and it should be safe for the user to physically
> remove the device after that write has succeeded.
> 
> Perhaps this is not happening due to the age of when the acpiphp driver
> was first written?  If I recall, there was no ACPI pci hotplug spec at
> the time and so it just used one specific bios implementation of what
> was needed.  Things might have changed in the 5 or so years since then
> :)
> 
> thanks,
> 
> greg k-h
> 
