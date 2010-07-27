From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook functions
Date: Mon, 26 Jul 2010 20:19:10 -0500
Message-ID: <4C4E340E.3050003@acm.org>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
 <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
 <201007261052.04772.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:45251 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0G0BTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jul 2010 21:19:37 -0400
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L66009P5ZO2YR15@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 26 Jul 2010 20:19:15 -0500 (CDT)
In-reply-to: <201007261052.04772.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: yakui.zhao@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

On 07/26/2010 11:52 AM, Bjorn Helgaas wrote:
> On Monday, July 26, 2010 08:46:04 am yakui.zhao@intel.com wrote:
>    
>> From: Zhao yakui<yakui.zhao@intel.com>
>>
>>      
> This needs a changelog.
>
> This seems like a complicated solution to a simple problem.
>
> I don't understand why the ACPI IPMI opregion stuff can't be made an
> optional feature of the ACPI IPMI driver.  Trying to completely decouple
> things is just going to add corner cases and weird dependencies.
>    
Well, ipmi_si_intf is pretty darn big as it is.  I would like to break 
it up.

I spent a little time reading the ACPI spec to understand just what the 
heck this thing is.  So now my head hurts a little.  But from what I can 
tell, this provides a way for the ACPI system to specify operations that 
are done by sending IPMI messages.  For instance, if power control was 
done via IPMI, the various control methods for power control would work 
their way down the to access to opregion interfaces mapping to IPMI 
functions, and that's where this piece of code takes over.

If so, this code has nothing to do with the IPMI system interface.  It's 
really more ACPI than IPMI.  It's sending messages at the very top of 
the IPMI stack, where it should.  The only reason it cares about ipmi_si 
at all is the discovery of the IPMI interfaces.

I agree that a notifier framework seems like massive overkill for this 
interface.  I will note that there are already interfaces for 
registering to receive callbacks when an IPMI device is added or 
removed.  What's missing is a way to ask "Is this an ACPI PNP device?".

Since this same function will be needed for IPMI SMBus interfaces, if 
that ever becomes a reality in the kernel, it seems more reasonable to 
provide some type of addition to the IPMI interface to be able to store 
this in the low-level code and retrieve this from the IPMI user 
interface.  So you can use the standard mechanisms to watch for devices 
being added, and then query to see if they are PNP at that point.

Does that make sense?

-corey
