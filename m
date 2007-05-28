From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: =?utf-8?b?UlRDX0RSVl9DTU9T?= can break userspace interface
Date: Mon, 28 May 2007 07:45:33 +0000 (UTC)
Message-ID: <loom.20070528T094140-471@post.gmane.org>
References: <20070527190351.GA21387@srcf.ucam.org> <20070527233911.GA23491@srcf.ucam.org> <20070528003822.GA23759@srcf.ucam.org> <200705271844.54589.david-b@pacbell.net> <20070528021622.GA24517@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36847 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762293AbXE1RpM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2007 13:45:12 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HsjHC-0004He-CX
	for linux-acpi@vger.kernel.org; Mon, 28 May 2007 19:45:02 +0200
Received: from 88-136-166-18.adslgp.cegetel.net ([88.136.166.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 19:45:02 +0200
Received: from castet.matthieu by 88-136-166-18.adslgp.cegetel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 19:45:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Matthew Garrett <mjg59 <at> srcf.ucam.org> writes:

> 
> On Sun, May 27, 2007 at 06:44:49PM -0700, David Brownell wrote:
> > On Sunday 27 May 2007, Matthew Garrett wrote:
> > > Actually, it seems to be worse than that - the PNP entry for my cmos 
> > > clock doesn't appear to mention an irq, so the wakealarm entry doesn't 
> > > work. I can happily wake it using the /proc/acpi/alarm interface.
> > > 
> > > David, would you be happy with hardcoding the rtc-cmos IRQ to 8 on PCs 
> > > if there's inadequate PNP information available?
> > 
> > That would seem to naturally belong in the PNP code, yes?
> > 
> > Agreed that it seems like it needs to be hardcoded somewhere.
> 
> The PNP code is reporting what's in the tables - I'd be a bit surprised 
> if it special-cased specific devices, but I guess there's an argument 
> for that. All the other machines I've checked report an IRQ, so I guess 
> Apple just didn't take much care in getting this right.
> 
Did you check if there aren't multiple configuration for rtc (one with irq, and
one without it) ?

What's the ouput of 
$ for i in /sys/bus/pnp/devices/*; do if [ "$(cat $i/id)" = PNP0b00 ]; then cat
$i/resources; echo options; cat $i/options; fi; done


Matthieu

