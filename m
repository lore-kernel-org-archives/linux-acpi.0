From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 17:18:40 -0500
Message-ID: <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
	 <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
	 <20100414172608.GA15965@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100414172608.GA15965@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2010 at 12:26 PM, Matthew Garrett <mjg59@srcf.ucam.org>=
 wrote:
> On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote:
>
>> Does the acpi-video logic not have logic on its own to send key
>> events? =A0So I guess laptops that don't have custom modules to hand=
le
>> this type of stuff don't get visual feedback from gnome-power-manage=
r?
>
> It does, but it's dependent upon the firmware sending them.

I think the following tells me firmware is sending them.  If I leave
acpi_osi=3D"Windows 2009" so that eeepc_laptop doesn't get loaded, I se=
e
events like this on /pro/acpi/event:

video LCDD 00000087 00000000
video LCDD 00000087 00000000
video LCDD 00000086 00000000
video LCDD 00000086 00000000

Thats a couple decreases followed by a couple increases.

If I change acpi_osi=3D"!Windows 2009" with and without
acpi_backlight=3Dvendor then I get events like:

hotkey ATKD 00000027 00000000
hotkey ATKD 00000026 00000000
hotkey ATKD 00000025 00000000
hotkey ATKD 00000024 00000000

The main difference is that with acpi_backlight=3Dvendor then I also ge=
t
events sent on /dev/input/event*.

=46rom here, I'd have to compile some custom eeepc-laptop's and see if
bd->props.brightness is being updated with correct values and then we
could do just the event send while skipping the update part.

=2E..or is there a way to not register for events 0x20 to 0x2f and let
ACPI Video process those?  If later is more correct way, is it obvious
why that code isn't sending key events today?

Chris
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
