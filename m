From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook functions
Date: Tue, 27 Jul 2010 09:04:26 -0500
Message-ID: <4C4EE76A.2080506@acm.org>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com>
 <1280155565-2938-2-git-send-email-yakui.zhao@intel.com>
 <201007261052.04772.bjorn.helgaas@hp.com> <4C4E340E.3050003@acm.org>
 <20100727132239.GA25190@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42617 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0G0OEg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2010 10:04:36 -0400
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L6700JCHZ3G1L51@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 27 Jul 2010 09:04:34 -0500 (CDT)
In-reply-to: <20100727132239.GA25190@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, yakui.zhao@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

On 07/27/2010 08:22 AM, Matthew Garrett wrote:
> On Mon, Jul 26, 2010 at 08:19:10PM -0500, Corey Minyard wrote:
>
>    
>> I agree that a notifier framework seems like massive overkill for this
>> interface.  I will note that there are already interfaces for
>> registering to receive callbacks when an IPMI device is added or
>> removed.  What's missing is a way to ask "Is this an ACPI PNP device?".
>>      
> So we just want something that returns addr_source, along with moving
> that enum into a global header?
>
>    

Yes, I think that makes sense.  A new function in struct 
ipmi_smi_handlers and a new interface in ipmi.h/ipmi_msghandler.c.  And 
move ipmi_addr_src into ipmi.h.

-corey
