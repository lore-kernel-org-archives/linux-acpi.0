From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Pcihpd-discuss] what is writing to /sys/bus/pci/slot/<slot_no>/power really supposed to do?
Date: Mon, 1 Oct 2007 11:46:55 -0600
Message-ID: <20071001174655.GK12049@parisc-linux.org>
References: <20071001100858.06919a1e.kristen.c.accardi@intel.com> <20071001171932.GA6801@suse.de> <20071001103557.a1252b78.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57563 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbXJARq4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2007 13:46:56 -0400
Content-Disposition: inline
In-Reply-To: <20071001103557.a1252b78.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Greg KH <gregkh@suse.de>, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net

On Mon, Oct 01, 2007 at 10:35:57AM -0700, Kristen Carlson Accardi wrote:
> So - here's where we get to interpret.  The spec says that _EJ0 is
> used to "eject" the card.  From the spec:
> 6.3.3 _EJx (Eject)
> These control methods are optional and are supplied for devices that 
> support a software-controlled VCR-style ejection mechanism or that 
> require an action be performed such as isolation of power/data lines 
> before the device can be removed from the system. 
> <snip>
> For hot removal, the device must be immediately ejected when OSPM calls 
> the _EJ0 control method. The _EJ0 control method does not return until 
> ejection is complete. After calling _EJ0, OSPM verifies the
> device no longer exists to determine if the eject succeeded. 
> For _HID devices, OSPM evaluates the _STA method. For _ADR devices, 
> OSPM checks with the bus driver for that device.
> 
> So, when I read this, it seems like if a vendor followed the spec,
> executing _EJ0 would hang until we physically pulled the card out
> of the system, which seems bad.  So, maybe this is why we don't call
> _EJ0?  

I think you've misread it.  Follow the other arm of the 'or':
	"require an action be performed such as isolation of power/data
	lines before the device can be removed from the system."
So I interpret "the eject succeeded" as "power/data lines are isolated"
for PCI cards.

> _PS3 apparently is used to put a device into D3.  By "device" here
> I'm not sure if we are talking about the adapter in the slot, or the
> slot itself.

Slots don't have a D3.  If you're talking about the bus, I guess there's
a B3.  But D is for devices.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
