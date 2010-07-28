From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook
	functions
Date: Wed, 28 Jul 2010 09:09:16 +0800
Message-ID: <1280279356.13929.139.camel@localhost.localdomain>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
	 <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
	 <201007261052.04772.bjorn.helgaas@hp.com>  <4C4E340E.3050003@acm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56585 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0G1BM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jul 2010 21:12:56 -0400
In-Reply-To: <4C4E340E.3050003@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>

On Tue, 2010-07-27 at 09:19 +0800, Corey Minyard wrote:
> On 07/26/2010 11:52 AM, Bjorn Helgaas wrote:
> > On Monday, July 26, 2010 08:46:04 am yakui.zhao@intel.com wrote:
> >    
> >> From: Zhao yakui<yakui.zhao@intel.com>
> >>
> >>      
> > This needs a changelog.
> >
> > This seems like a complicated solution to a simple problem.
> >
> > I don't understand why the ACPI IPMI opregion stuff can't be made an
> > optional feature of the ACPI IPMI driver.  Trying to completely decouple
> > things is just going to add corner cases and weird dependencies.
> >    
> Well, ipmi_si_intf is pretty darn big as it is.  I would like to break 
> it up.
> 
> I spent a little time reading the ACPI spec to understand just what the 
> heck this thing is.  So now my head hurts a little.  But from what I can 
> tell, this provides a way for the ACPI system to specify operations that 
> are done by sending IPMI messages.  For instance, if power control was 
> done via IPMI, the various control methods for power control would work 
> their way down the to access to opregion interfaces mapping to IPMI 
> functions, and that's where this piece of code takes over.

> If so, this code has nothing to do with the IPMI system interface.  It's 
> really more ACPI than IPMI.  It's sending messages at the very top of 
> the IPMI stack, where it should.  The only reason it cares about ipmi_si 
> at all is the discovery of the IPMI interfaces.

Yes. Agree with what you said.
The trouble in the patch set is to confirm whether the IPMI device is
what ACPI expects to communicate especially when there exist multiple
IPMI devices.

> 
> I agree that a notifier framework seems like massive overkill for this 
> interface.  I will note that there are already interfaces for 
> registering to receive callbacks when an IPMI device is added or 
> removed.  What's missing is a way to ask "Is this an ACPI PNP device?".

Not sure whether the ipmi_smi_watcher is the interfaces you mentioned?

The ipmi_smi_watcher is already used in the second patch in order to
create the user interface. But now the callback function of new_smi only
provides very limited info about the IPMI device. In order to assure
that ACPI can communicate with the IPMI device, I have to compare the
corresponding device pointer to confirm whether this is what ACPI want
to communicate. Then I tried the several mechanisms to make it work
while touch IPMI code/structure as little as possible.
     >manually discover the pnp device with the pnpid of "IPI0001"
     >using one notifier in course of loading IPMI pnp device driver.
     >Merge the opregion code into the PNP IPMI discovery code.
     
> 
> Since this same function will be needed for IPMI SMBus interfaces, if 
> that ever becomes a reality in the kernel, it seems more reasonable to 
> provide some type of addition to the IPMI interface to be able to store 
> this in the low-level code and retrieve this from the IPMI user 
> interface.  So you can use the standard mechanisms to watch for devices 
> being added, and then query to see if they are PNP at that point.
> 
> Does that make sense?

Yes. If this interface can be available, it will be easier for me to
write the patch to enable that the ACPI can communicate with the BMC. 

Best regards.
   Yakui

> -corey

