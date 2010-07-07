From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: a question about lid input device
Date: Wed, 07 Jul 2010 11:14:20 -0400
Message-ID: <8005.1278515660@foxharp.boston.ma.us>
References: <1276412011.19052.19294.camel@rzhang1-desktop> <20100614020127.GA30773@khazad-dum.debian.net> (sfid-20100613_220136_963531_F0446252)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colo4.heeltoe.com ([207.210.93.145]:34386 "EHLO
	colo4.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab0GGPlq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jul 2010 11:41:46 -0400
In-reply-to: <20100614020127.GA30773@khazad-dum.debian.net> (sfid-20100613_220136_963531_F0446252)
Content-ID: <8002.1278515660.1@foxharp.boston.ma.us>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, dmitry.torokhov@gmail.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <lenb@kernel.org>

henrique de moraes holschuh wrote:
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

i understand that it's not fully general, but for the case of
the lid:  is /proc/acpi/button/lid/LID/state going away?

paul
=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 87.1 degrees)
