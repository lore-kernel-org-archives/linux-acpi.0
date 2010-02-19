From: Len Brown <lenb@kernel.org>
Subject: Re: T400 does not enter C4/C6 sleep state with USB devices connected
Date: Fri, 19 Feb 2010 00:51:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190045420.17638@localhost.localdomain>
References: <74fd948d1002180539xc1ff413mb3c8a600e6d85d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:65106 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0BSFv1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 00:51:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200M8BQXM638G@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 23:51:27 -0600 (CST)
In-reply-to: <74fd948d1002180539xc1ff413mb3c8a600e6d85d50@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-acpi@vger.kernel.org


On Thu, 18 Feb 2010, Pedro Ribeiro wrote:

> Hi all,
> 
> I spent lots of hours trying to figure out why my T400 would not enter
> C4 and C6 sleep states.
> 
> Here are my findings:
> 
> - When a USB device is connected, even if it supports USB autosuspend,
> the cpu will never go down more than C3 (apparently the mode is
> disabled by the BIOS).
> 
> - After removing all the USB devices, in AC it enters C4 and in
> battery it enters C6.
> The BIOS apparently replaces C3 with C4 and C6, respectively, because
> /sys/devices/system/cpu/cpu0/cpuidle/
> 
> always shows 4 states, whatever the situation.
> 
> So one more reason not to use USB devices while on battery...
> 
> Is this normal behaviour or I have a retarded BIOS? And if so, is
> there a workaround?

Yes, it is normal, and retarded:-)

Ideally, if a USB device is not used and usb autosuspend
is successful, then I would hope that you'd be able to
get into the deep C-state - but autosuspend is not
universally successful; and in some cases does nothing at all.

It is common for the BIOS to hide the higher latency deep
C-state on AC and expose it on DC.  I think that this technique
is largely obsolete today, and I'm hopeful that the practice
will eventually die out.

cheers,
-Len Brown, Intel Open Source Technology Center
