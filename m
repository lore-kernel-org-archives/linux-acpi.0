From: Len Brown <lenb@kernel.org>
Subject: Re: a question about lid input device
Date: Mon, 21 Jun 2010 21:56:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:40220 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab0FVB47 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2010 21:56:59 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L4E00L4C82O6XH5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 21 Jun 2010 20:56:49 -0500 (CDT)
In-reply-to: <20100614020127.GA30773@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, dmitry.torokhov@gmail.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Dmitry,
Is there a reason not to simply add a "state" attribute
to a LID input device?


thanks,
Len Brown, Intel Open Source Technology Center

On Sun, 13 Jun 2010, Henrique de Moraes Holschuh wrote:

> On Sun, 13 Jun 2010, Zhang Rui wrote:
> > Then we update the lid switch status when a Lid notification comes.
> > right?
> 
> Yes.
> 
> > Then, IMO, userspace can get the lid status
> > via /sys/class/input/inputX/uevent, right?
> 
> No, only through an IOCTL.
> 
> > /sys/class/input/input1/uevent:EV==21
> 
> That's an bitmap of al EV_EV it supports.
> 
> > /sys/class/input/input1/uevent:SW==1
> 
> That's an bitmap of al EV_SW it supports.
> 
> > Lid is opened but SW is set, I tried to close/open the lid and found
> > that this bit never changes. is there something I misunderstand? can we
> > get the lid status in userspace?
> 
> IOCTL(), only.
> 
> Since nobody got a input-utils standard package (or added something to
> util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
> shell scripts that want to query EV_SW state...
> 

