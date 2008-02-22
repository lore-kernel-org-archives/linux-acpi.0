From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk.
 Screen becomes green.
Date: Fri, 22 Feb 2008 12:32:12 -0500
Message-ID: <47BF071C.6040308@rtr.ca>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <alpine.LFD.1.00.0802210819560.1777@xo-0C-FC-0F.localdomain> <47BEFEC4.7090904@rtr.ca> <200802221802.18640.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2212 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbYBVRcO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 12:32:14 -0500
In-Reply-To: <200802221802.18640.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-acpi@vger.kernel.org, Greg KH <gregkh@suse.de>

Rafael J. Wysocki wrote:
> On Friday, 22 of February 2008, Mark Lord wrote:
>> david@lang.hm wrote:
>> ..
>>> I've been watching for kexec hibernate for a little while now, and the 
>>> last I saw was that acpi was incompatible with the kexec hibernate (but 
>>> the suspend folks were still claiming that devices needed to be put in 
>>> the 'right mode' not just powered off. I've been waiting to see this 
>>> resolved.
>> ..
>>
>> Yeah, exactly.  What's so special about poweroff on hibernation?
>> Why even bother with the special "S4" state there?
> 
> (1) To be able to wake up with the help of devices that can't wake
>     the system up from S5 (power off)
> (2) To handle some platform devices appropriately over the cycle
..

That's the theory.  I've read about it, but have yet to imagine
any real-life situation where it applies.

But this isn't my speciality, so.. do you have experience with any real examples?

Thanks!

>> I want a real full poweroff, or at least I think I do.  Why wouldn't I?
>>
>> ????
> 
> You may want that, some people may not want it.
> 
> We are supposed to handle S4, the BIOS/platform may expect us to do that, so
> IMO this is a good enough reason to do it.  Especially that we can.
> 
> Thanks,
> Rafael

