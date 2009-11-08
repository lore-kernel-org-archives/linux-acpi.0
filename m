From: Len Brown <lenb@kernel.org>
Subject: LED suspend inicator (Re: Suspend locks up Toshiba Satelite L355-S7915
 (no longer))
Date: Sun, 08 Nov 2009 11:37:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911081136060.4300@localhost.localdomain>
References: <200911051928.38825.kencx@peak.org>
 <200911070809.23947.kencx@peak.org>
 <alpine.LFD.2.00.0911072138260.4291@localhost.localdomain>
 <200911071930.50420.kencx@peak.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:39070 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbZKHQh7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Nov 2009 11:37:59 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSS006ZVU74F0O4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 08 Nov 2009 10:37:55 -0600 (CST)
In-reply-to: <200911071930.50420.kencx@peak.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Corbin <kencx@peak.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux-acpi@vger.kernel.org

> > The LED indicator on sleeping, however, is generally standard
> > (there is a method called "_SST" that we invoke that tells the BIOS
> >  to start & stop blinking the suspend LED)
> >
> > Do you know if the LED blinked when Windows suspended on this laptop?

> The LED blinks when suspended under Windows.  It also blinks, at a much slower 
> rate, when suspended in Ubuntu of I have the omnibook module loaded.  I'm 
> still looking at how it does that.   Is this something that we should expect 
> the stock acpi process to take care of?

_SST, mentioned above, is the standard method to control
the suspend indicator LED, and has been included in the
generic part of Linux for a long time.

-Len
