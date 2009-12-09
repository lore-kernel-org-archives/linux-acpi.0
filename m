From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 07:38:36 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912090959230.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35826 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753105AbZLIPin (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 10:38:43 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912090959230.4120-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Wed, 9 Dec 2009, Alan Stern wrote:
> 
> In fact these considerations already affect the USB resume operations, 
> even without asynchronous resume.  The code relies on the fact that the 
> PCI layer registers sibling devices on a slot in order of increasing 
> function number.  There's no guarantee this will remain true in the 
> future (it may already be wrong AFAIK), so putting in some explicit 
> list manipulation is the prudent thing to do.

I do think we want to keep the slot ordering.

One of the silent issues that the device management code has always had is 
the whole notion of naming stability. Now, udev and various fancy naming 
schemes solve that at a higher level, but it is still the case that we 
_really_ want basic things like your PCI controllers to show up in stable 
order.

For example, it is _very_ inconvenient if things like PCI probing ends up 
allocating different bus numbers (or resource allocations) across reboots 
even if the hardware hasn't been changed. Just from a debuggability 
standpoint, that just ends up being a total disaster.

For example, we continually hit odd special cases where PCI resource 
allocation has some unexplained problem because there is some motherboard 
resource that is hidden and invisible to our allocator. They are rare in 
the sense that it's usually just a couple of odd laptops or something, but 
they are not rare in the sense that pretty much _every_ single time we 
change some resource allocation logic, we find one or two machines that 
have some issue.

Things like that would be total disasters if the core device layer then 
ended up also not having well-defined ordering. This is why I don't want 
to do asynchronous PCI device probing, for example (ie we probe the 
hardware synchronously, the PCI driver sets it all up synchronously, and 
the asynchronous portion is the non-PCI part if any - things like PHY 
detection, disk spinup etc).

So async things are fine, but they have _huge_ disadvantages, and I'll 
personally take reliability and a stable serial algorithm over an async 
one as far as possible. 

That's partly why I realy did suggest that we do the async stuff purely in 
the USB layer, rather than try to put it deeper in the device layer. And 
if we do support it "natively" in the device layer like Rafael's latest 
patch, I still think we should be very very nervous about making devices 
async unless there is a measured - and very noticeable - advantage.

So I really don't want to push things any further than absolutely 
necessary. I do not think that something like "embedded audio" is a reason 
for async, for example. 

				Linus
