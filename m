From: Greg KH <gregkh@suse.de>
Subject: Re: what is writing to /sys/bus/pci/slot/<slot_no>/power really
	supposed to do?
Date: Mon, 1 Oct 2007 10:19:32 -0700
Message-ID: <20071001171932.GA6801@suse.de>
References: <20071001100858.06919a1e.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55398 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbXJARTz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 13:19:55 -0400
Content-Disposition: inline
In-Reply-To: <20071001100858.06919a1e.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Mon, Oct 01, 2007 at 10:08:58AM -0700, Kristen Carlson Accardi wrote:
> Hi,
> I notice in acpiphp that the code path for powering down the slot
> via sysfs does not execute the _EJ0 method, but instead simply
> looks for _PS3 and of couse disables all the bridges and devices.  
> I suppose this could be valid depending on your definition of what 
> /sys/bus/pci/slots/<slot_no>/power should do.
> 
> Is it intended to just power down the adapter that's in the slot, 
> or is it intended to make the adapter in the slot able to be removed?
> If it's intended to make the adapter able to be removed, shouldn't
> we be calling _EJ0?

If that is required to power down the device, yes, it should be called.

> As a comparison, in pciehp when the sysfs power file is written,
> we do actually go out and send the commands to the hotplug controller
> to physically power off the slot.

Yes, that is the intention of writing that value to that file.  The
power should be gone and it should be safe for the user to physically
remove the device after that write has succeeded.

Perhaps this is not happening due to the age of when the acpiphp driver
was first written?  If I recall, there was no ACPI pci hotplug spec at
the time and so it just used one specific bios implementation of what
was needed.  Things might have changed in the 5 or so years since then
:)

thanks,

greg k-h
