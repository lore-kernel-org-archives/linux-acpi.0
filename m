From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: a question about lid input device
Date: Wed, 07 Jul 2010 11:08:05 +0800
Message-ID: <1278472085.4537.7672.camel@rzhang1-desktop>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
	 <20100614020127.GA30773@khazad-dum.debian.net>
	 <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
	 <20100704083553.GE32427@core.coreip.homeip.net>
	 <1278292140.4537.6088.camel@rzhang1-desktop>
	 <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com>
	 <1278294444.4537.6134.camel@rzhang1-desktop>
	 <20100705194945.GA11096@khazad-dum.debian.net>
	 <20100705202731.GA17013@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54634 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab0GGDGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Jul 2010 23:06:49 -0400
In-Reply-To: <20100705202731.GA17013@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-07-06 at 04:27 +0800, Dmitry Torokhov wrote:
> On Mon, Jul 05, 2010 at 04:49:45PM -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 05 Jul 2010, Zhang Rui wrote:
> > > > I think if you can listen to uevents you can just as easily open /dev/ 
> > > > input/eventX and listen to proper input events.
> > > > 
> > > the question is users may want to get the lid switch STATUS,
> > > asynchronously.
> > 
> > More often than not, you need to know the current state when dealing
> > with EV_SW, to be able to do anything sensbile with it in GUIs, etc.
> > 
> 
> I understand the need of getting the current state of a lid
> switch/key/etc (and for that someone just need to write a utility
> useable from shell scripts). But I do not understand how adding switch
> state to uevents (that are emitted normally only when a new device is
> created) will help here.
> 
driver core creates a sysfs attribute for uevent. and users may query
this file to get the lid state, say:
$ cat /sys/class/input/input1/uevent 
PRODUCT=19/0/5/0
NAME="Lid Switch"
PHYS="PNP0C0D/button/input0"
EV==21
SW==1
MODALIAS=input:b0019v0000p0005e0000-e0,5,kramlsfw0,

I'm not quite familiar with the uevent stuff, so please correct me if
I'm wrong. :)
IMO, for input switch device, it's reasonable to report the switch state
in uevent, in which HAL may also be interested. And users may get the
switch status by running "cat /sys/class/input/inputX/uevent" as well.

thanks,
rui


