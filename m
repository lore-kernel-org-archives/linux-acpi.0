From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: a question about lid input device
Date: Sun, 4 Jul 2010 01:35:53 -0700
Message-ID: <20100704083553.GE32427@core.coreip.homeip.net>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
 <20100614020127.GA30773@khazad-dum.debian.net>
 <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51511 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847Ab0GDIgK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 04:36:10 -0400
Received: by pwi5 with SMTP id 5so1128612pwi.19
        for <linux-acpi@vger.kernel.org>; Sun, 04 Jul 2010 01:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Jun 21, 2010 at 09:56:37PM -0400, Len Brown wrote:
> Dmitry,
> Is there a reason not to simply add a "state" attribute
> to a LID input device?
> 

Len,

There is no LED input device, there is an input device that happens to
report EV_SW/SW_LID state. If we did that we'd need to add attributes
for all types of switches, keys, current values of REL and ABS axis,
min/max/fuzz/flat settings of ABS axis and so forth that input device
might report. I do not think it is a good idea.

> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 
> On Sun, 13 Jun 2010, Henrique de Moraes Holschuh wrote:
> 
> > On Sun, 13 Jun 2010, Zhang Rui wrote:
> > > Then we update the lid switch status when a Lid notification comes.
> > > right?
> > 
> > Yes.
> > 
> > > Then, IMO, userspace can get the lid status
> > > via /sys/class/input/inputX/uevent, right?
> > 
> > No, only through an IOCTL.
> > 
> > > /sys/class/input/input1/uevent:EV==21
> > 
> > That's an bitmap of al EV_EV it supports.
> > 
> > > /sys/class/input/input1/uevent:SW==1
> > 
> > That's an bitmap of al EV_SW it supports.
> > 
> > > Lid is opened but SW is set, I tried to close/open the lid and found
> > > that this bit never changes. is there something I misunderstand? can we
> > > get the lid status in userspace?
> > 
> > IOCTL(), only.
> > 
> > Since nobody got a input-utils standard package (or added something to
> > util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
> > shell scripts that want to query EV_SW state...
> > 
> 

-- 
Dmitry
