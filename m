From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Thu, 15 Apr 2010 10:29:13 +0800
Message-ID: <1271298553.7167.230.camel@rzhang1-desktop>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
	 <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
	 <20100414172608.GA15965@srcf.ucam.org>
	 <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
	 <1271295002.7167.187.camel@rzhang1-desktop>
	 <1271295779.7167.188.camel@rzhang1-desktop>
	 <j2vdb599ead1004141910r2a3206f8nb17d055db0ba2959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51463 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab0DOC2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Apr 2010 22:28:18 -0400
In-Reply-To: <j2vdb599ead1004141910r2a3206f8nb17d055db0ba2959@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>

On Thu, 2010-04-15 at 10:10 +0800, Chris Bagwell wrote:
> On Wed, Apr 14, 2010 at 8:42 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > On Thu, 2010-04-15 at 09:30 +0800, Zhang Rui wrote:
> >> On Thu, 2010-04-15 at 06:18 +0800, Chris Bagwell wrote:
> >> > On Wed, Apr 14, 2010 at 12:26 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> > > On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote:
> >> > >
> >> > >> Does the acpi-video logic not have logic on its own to send key
> >> > >> events?  So I guess laptops that don't have custom modules to handle
> >> > >> this type of stuff don't get visual feedback from gnome-power-manager?
> >> > >
> >> > > It does, but it's dependent upon the firmware sending them.
> >> >
> >> > I think the following tells me firmware is sending them.  If I leave
> >> > acpi_osi="Windows 2009" so that eeepc_laptop doesn't get loaded, I see
> >> > events like this on /pro/acpi/event:
> >> >
> >> > video LCDD 00000087 00000000
> >> > video LCDD 00000087 00000000
> >> > video LCDD 00000086 00000000
> >> > video LCDD 00000086 00000000
> >> >
> >> > Thats a couple decreases followed by a couple increases.
> >> >
> >> I have a EEEpc 1005PE. I'm looking at the backlight problem on this
> >> machine, but it seems to be different from this one.
> >>
> >> The hotkey seems to work perfectly when ACPI video driver is loaded.
> >> i.e. I get a single hotkey event when pressing the hotkey and the value
> >> of /sys/class/backlight/acpi_video0/brightness changes correctly.
> >>
> >> The only problem I get is that the actual brightness does not change
> >> consistently.
> >> say, there are 15 brightness levels in all,
> >> level 0, level 5 and level 12 give me a screen with lowest brightness.
> >> If I want to get maximum backlight, I need to set it to level 4 or level
> >> 11.
> 
> I'm curious, do you still see this issue if you first kill
> gnome-power-manager first?
> 
> >>
> > Oh, this have already been fixed in the latest BIOS.
> 
> Wasn't fixed in my case.  I'd be curious to here if it fixes for you.
> 
no, the problem still exists.
I misread your comment at
https://bugzilla.kernel.org/show_bug.cgi?id=15182#c33

> >
> > Chris,
> > do you mean you get duplicate hotkey events after upgrading the BIOS?
> 
> With latest firmware, I get zero hotkey events over /dev/input/event*
> unless I add acpi_backlight=vendor to boot options.

I just upgrade the BIOS to 1003, and I can still get input event
from /dev/input/event4 (which is ACPI video bus).
and there is no duplicate input events when pressing hotkey.

thanks,
rui

