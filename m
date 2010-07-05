From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: a question about lid input device
Date: Mon, 05 Jul 2010 09:09:00 +0800
Message-ID: <1278292140.4537.6088.camel@rzhang1-desktop>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
	 <20100614020127.GA30773@khazad-dum.debian.net>
	 <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
	 <20100704083553.GE32427@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57646 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab0GEBHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jul 2010 21:07:55 -0400
In-Reply-To: <20100704083553.GE32427@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-07-04 at 16:35 +0800, Dmitry Torokhov wrote:
> On Mon, Jun 21, 2010 at 09:56:37PM -0400, Len Brown wrote:
> > Dmitry,
> > Is there a reason not to simply add a "state" attribute
> > to a LID input device?
> > 
> 
> Len,
> 
> There is no LED input device, there is an input device that happens to
> report EV_SW/SW_LID state. If we did that we'd need to add attributes
> for all types of switches, keys, current values of REL and ABS axis,
> min/max/fuzz/flat settings of ABS axis and so forth that input device
> might report. I do not think it is a good idea.
> 
I agree.
How about adding a field in uevent file that reports the switch status?

thanks,
rui
> > 
> > thanks,
> > Len Brown, Intel Open Source Technology Center
> > 
> > On Sun, 13 Jun 2010, Henrique de Moraes Holschuh wrote:
> > 
> > > On Sun, 13 Jun 2010, Zhang Rui wrote:
> > > > Then we update the lid switch status when a Lid notification comes.
> > > > right?
> > > 
> > > Yes.
> > > 
> > > > Then, IMO, userspace can get the lid status
> > > > via /sys/class/input/inputX/uevent, right?
> > > 
> > > No, only through an IOCTL.
> > > 
> > > > /sys/class/input/input1/uevent:EV==21
> > > 
> > > That's an bitmap of al EV_EV it supports.
> > > 
> > > > /sys/class/input/input1/uevent:SW==1
> > > 
> > > That's an bitmap of al EV_SW it supports.
> > > 
> > > > Lid is opened but SW is set, I tried to close/open the lid and found
> > > > that this bit never changes. is there something I misunderstand? can we
> > > > get the lid status in userspace?
> > > 
> > > IOCTL(), only.
> > > 
> > > Since nobody got a input-utils standard package (or added something to
> > > util-linux) yet to do that (AFAIK anyway), it is a MAJOR annoyance for
> > > shell scripts that want to query EV_SW state...
> > > 
> > 
> 


