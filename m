From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no resume after	undocking
Date: Mon, 01 Sep 2008 14:16:44 +0200
Message-ID: <48BBDD2C.5020804@dbservice.com>
References: <200808301535.22419.sfking@fdwdc.com> <1220239048.24775.152.camel@rzhang-dt> <48BBC8FC.1020809@dbservice.com> <20080901112816.GA21970@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:33664 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753135AbYIAMRB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2008 08:17:01 -0400
In-Reply-To: <20080901112816.GA21970@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, Steven King <sfking@fdwdc.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Henrique de Moraes Holschuh wrote:
> On Mon, 01 Sep 2008, Tomas Carnecky wrote:
>> There is one question though that was never answered: Is there any
>> interaction needed from the userspace when docking/undocking? Something
> 
> Yes.  umount filesystems on any device in the dock, and issue the "power off
> dock" command (i.e. tell the kernel to *eject* the dock).  This is *very*
> important, although the ThinkPad firmware/hardware will _try_ to protect the
> electronics if you just pull the laptop off the dock while it is still
> powered (but it might just not be able to do it, so Don't Do That!).
> 
> Anyway, if your dock led is going off before you remove the laptop from the
> dock, you're doing everything correctly as far as the hardware is concerned.
> 
> And the kernel will scream bloody murder if you remove a device with live
> filesystems in it, so it should be trivial to check if that part is being
> taken care of by your userspace as well.  Not that something like this would
> be an excuse to fail to suspend/resume after being undocked, mind you.

To undock, I press the button on the dock, the led blinks a couple times
and turns green (also, dmesg tells me that all USB devices have been
removed and they indeed stop functioning). Then I take the laptop out of
the dock.

Because the X61 lacks a CDROM drive, I bought a bay CDROM drive along
with the UltraBase. But there is no CDROM inside it (so no mounted
filesystems). I also have an USB keyboard and mouse plugged into the USB
slots in the dock. So it seems the kernel *should* take care of those
things without any userspace interaction.

I just tested suspend/resume with the CDROM drive removed (an empty
bay). Suspend/resume now works just fine, regardless how I dock/undock
the laptop.

Anyway, regarding the additional patches, which tree can I pull them
from? (I'm eager to test them, I very much want my dock to work properly)

thanks
tom

