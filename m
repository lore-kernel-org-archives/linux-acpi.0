From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/24] acpi4asus updates
Date: Sat, 29 Aug 2009 14:14:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908291411500.24904@localhost.localdomain>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
 <4A97F17E.3060908@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:25172 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZH2SOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 14:14:40 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP500H5SHC2QIC1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 29 Aug 2009 13:14:32 -0500 (CDT)
In-reply-to: <4A97F17E.3060908@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-acpi@vger.kernel.org

On Fri, 28 Aug 2009, Alan Jenkins wrote:

> Corentin Chary wrote:
> > Hi Len,
> > Here is acpi4asus series for 2.6.32:
> >  * eeepc-laptop bugfixes and updates.
> >  * asus-laptop updates (keyboard backlight and new hotkeys).
> >  * documentation on asus-laptop, eeepc-laptop, video/lcd,
> >    video/backlight and leds.
> > 
> > Alan Jenkins (9):
> >   eeepc-laptop: don't touch the pci slot if it was claimed by a
> >     different driver
> >   eeepc-laptop: use a mutex to serialize pci hotplug (resume vs.
> >     notify)
> >   
> I'm hoping the two patches above will fix a regression on certain hardware,
> and that they can be pushed into 2.6.31.  Or if they don't fix it, that the
> commits responsible can be reverted - which will conflict with all the
> eeepc-laptop patches.  So you may wish to hold back on eeepc-laptop.
> 
> See linux-acpi thread "[Debian-eeepc-devel] Problems with wlan on a 1005HA-M"
> (regression in 2.6.31-rc6: suspend hangs and causes the wireless to be
> disabled).

Yes, I happened to read that thread (unlike many others that I have
not yet read:-).  When we have clear testing results and know what to do
we can do it.  If it is before Linus returns from vacation and cuts .31,
that is fine.  If not, we can always repair in .stable.

thanks,
Len Brown, Intel Open Source technolgy Center.
