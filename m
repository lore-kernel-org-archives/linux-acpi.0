From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [RFD] How to tell ACPI drivers what the target
 sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 11:23:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706211110480.3547-100000@iolanthe.rowland.org>
References: <200706211646.06594.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35239 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752420AbXFUPX7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 11:23:59 -0400
In-Reply-To: <200706211646.06594.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>

On Thu, 21 Jun 2007, Rafael J. Wysocki wrote:

> > Just do 1). Global variables are ugly, and we already have space in
> > pm_message_t. 
> 
> Well, this is what Len voted for, I think.  David is against it.
> 
> I also think that the cleanest way would be to pass that as an argument
> to .suspend(), but currently pm_message_t. is passed by value and if we
> made it a real struct (ie. with more than one field), that would also become
> ugly, IMHO.
> 
> So, can we make pm_message_t consist only of the target state?

You're both repeating the mistakes from two years ago.

You can't use a simple type to describe a target system state.  While 
it might work for ACPI states, it won't work on general (i.e., 
non-ACPI) systems.  It's probably a mistake even to use a data 
structure to describe a system state, since the requirements are so 
complex.  The only reasonable approach is to describe it in code.

What you can do is this: Pick a small enumerated set of labels for some 
selected system states.  For example:

enum pm_system_state {
	PM_STATE_RUNNING,
	PM_STATE_STANDBY,
	PM_STATE_SUSPEND,
	PM_STATE_HIBERNATE,
};

(It might be preferable to make the list more configurable, perhaps 
even allow changes at runtime.  Never mind all that for now.)

These are merely labels, they don't actually describe anything.  To use 
them, you would have to pass them to a subsystem routine for 
interpretation.  For example, pci_select_state() might pass one of 
these things to an ACPI routine, which would know what ACPI state 
corresponded to the given pm_system_state and would be able to say what 
D-state would be appropriate for a given PCI device.  On a non-ACPI 
platform, pci_select_state() would have to call a different routine -- 
something platform-dependent -- to do the same job.


On the other hand, maybe you don't need anything like this at all.  
What would happen if a PCI driver put its device into a D-state which 
wasn't supported under the target ACPI state?  Would it be so terrible?
I can imagine that the requested wakeup functionality might not be 
available, but would it prevent the device from working properly when 
it was resumed?

Alan Stern

