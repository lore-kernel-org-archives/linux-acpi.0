From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Thu, 15 Apr 2010 09:30:02 +0800
Message-ID: <1271295002.7167.187.camel@rzhang1-desktop>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
	 <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
	 <20100414172608.GA15965@srcf.ucam.org>
	 <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2010-04-15 at 06:18 +0800, Chris Bagwell wrote:
> On Wed, Apr 14, 2010 at 12:26 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote:
> >
> >> Does the acpi-video logic not have logic on its own to send key
> >> events?  So I guess laptops that don't have custom modules to handle
> >> this type of stuff don't get visual feedback from gnome-power-manager?
> >
> > It does, but it's dependent upon the firmware sending them.
> 
> I think the following tells me firmware is sending them.  If I leave
> acpi_osi="Windows 2009" so that eeepc_laptop doesn't get loaded, I see
> events like this on /pro/acpi/event:
> 
> video LCDD 00000087 00000000
> video LCDD 00000087 00000000
> video LCDD 00000086 00000000
> video LCDD 00000086 00000000
> 
> Thats a couple decreases followed by a couple increases.
> 
I have a EEEpc 1005PE. I'm looking at the backlight problem on this
machine, but it seems to be different from this one.

The hotkey seems to work perfectly when ACPI video driver is loaded.
i.e. I get a single hotkey event when pressing the hotkey and the value
of /sys/class/backlight/acpi_video0/brightness changes correctly.

The only problem I get is that the actual brightness does not change
consistently.
say, there are 15 brightness levels in all,
level 0, level 5 and level 12 give me a screen with lowest brightness.
If I want to get maximum backlight, I need to set it to level 4 or level
11.

could you tell me your BIOS version please?

thanks,
rui

> If I change acpi_osi="!Windows 2009" with and without
> acpi_backlight=vendor then I get events like:
> 
> hotkey ATKD 00000027 00000000
> hotkey ATKD 00000026 00000000
> hotkey ATKD 00000025 00000000
> hotkey ATKD 00000024 00000000
> 
> The main difference is that with acpi_backlight=vendor then I also get
> events sent on /dev/input/event*.
> 
> From here, I'd have to compile some custom eeepc-laptop's and see if
> bd->props.brightness is being updated with correct values and then we
> could do just the event send while skipping the update part.
> 
> ...or is there a way to not register for events 0x20 to 0x2f and let
> ACPI Video process those?  If later is more correct way, is it obvious
> why that code isn't sending key events today?
> 
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


