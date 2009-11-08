From: Len Brown <lenb@kernel.org>
Subject: Re: Suspend locks up Toshiba Satelite L355-S7915 (no longer)
Date: Sat, 07 Nov 2009 21:44:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911072138260.4291@localhost.localdomain>
References: <200911051928.38825.kencx@peak.org> <4AF39E45.7050803@gmail.com>
 <200911070809.23947.kencx@peak.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:59299 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbZKHCop (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:44:45 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR0027BRMOD4KJ@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:44:49 -0600 (CST)
In-reply-to: <200911070809.23947.kencx@peak.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Corbin <kencx@peak.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

> ... upgrade ... that fixed my suspend problem.

good.

> There are other problems, but they are minor and can be lived with.  Most 
> hotkeys do not work.  And the computer doesn't flash the power button when it 
> is suspended.  There is a omnibook module that purports do do these 
> functions, but it isn't coded to work with the Satelite L355-S7915.  I've 
> been looking into fixing that.  But it has occurred to me that that driver is 
> largely duplicating standard acpi functions.  And that it might be a better 
> use of my time to look into configuring acpi to work with this laptop.  Any 
> recommendations?

Generally the platform drivers implement support for non-standard
features that are not included in the generic ACPI support.
Often the non-standard support is implemented with vendor-specific
extensions to ACPI.

Unfortunately, except in a few cases, hotkeys are non-standard.
So extending the platform driver for boxes similar to your own
to talk to your box may be the way to go..

The LED indicator on sleeping, however, is generally standard
(there is a method called "_SST" that we invoke that tells the BIOS
 to start & stop blinking the suspend LED)

Do you know if the LED blinked when Windows suspended on this laptop?

cheers,
Len Brown, Intel Open Source Technology Center
