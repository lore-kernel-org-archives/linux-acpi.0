From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Thu, 15 Apr 2010 19:02:25 -0500
Message-ID: <o2mdb599ead1004151702x5ec21e37j9d69ac1dbf5f1742@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
	 <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
	 <20100414172608.GA15965@srcf.ucam.org>
	 <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
	 <1271295002.7167.187.camel@rzhang1-desktop>
	 <1271295779.7167.188.camel@rzhang1-desktop>
	 <j2vdb599ead1004141910r2a3206f8nb17d055db0ba2959@mail.gmail.com>
	 <1271298553.7167.230.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1271298553.7167.230.camel@rzhang1-desktop>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2010 at 9:29 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2010-04-15 at 10:10 +0800, Chris Bagwell wrote:
>> On Wed, Apr 14, 2010 at 8:42 PM, Zhang Rui <rui.zhang@intel.com> wro=
te:
>> > On Thu, 2010-04-15 at 09:30 +0800, Zhang Rui wrote:
>> >> On Thu, 2010-04-15 at 06:18 +0800, Chris Bagwell wrote:
>> >> > On Wed, Apr 14, 2010 at 12:26 PM, Matthew Garrett <mjg59@srcf.u=
cam.org> wrote:
>> >> > > On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote=
:
>> >> > >
>> >> > >> Does the acpi-video logic not have logic on its own to send =
key
>> >> > >> events? =A0So I guess laptops that don't have custom modules=
 to handle
>> >> > >> this type of stuff don't get visual feedback from gnome-powe=
r-manager?
>> >> > >
>> >> > > It does, but it's dependent upon the firmware sending them.
>> >> >
>> >> > I think the following tells me firmware is sending them. =A0If =
I leave
>> >> > acpi_osi=3D"Windows 2009" so that eeepc_laptop doesn't get load=
ed, I see
>> >> > events like this on /pro/acpi/event:
>> >> >
>> >> > video LCDD 00000087 00000000
>> >> > video LCDD 00000087 00000000
>> >> > video LCDD 00000086 00000000
>> >> > video LCDD 00000086 00000000
>> >> >
>> >> > Thats a couple decreases followed by a couple increases.
>> >> >
>> >> I have a EEEpc 1005PE. I'm looking at the backlight problem on th=
is
>> >> machine, but it seems to be different from this one.
>> >>
>> >> The hotkey seems to work perfectly when ACPI video driver is load=
ed.
>> >> i.e. I get a single hotkey event when pressing the hotkey and the=
 value
>> >> of /sys/class/backlight/acpi_video0/brightness changes correctly.
>> >>
>> >> The only problem I get is that the actual brightness does not cha=
nge
>> >> consistently.
>> >> say, there are 15 brightness levels in all,
>> >> level 0, level 5 and level 12 give me a screen with lowest bright=
ness.
>> >> If I want to get maximum backlight, I need to set it to level 4 o=
r level
>> >> 11.
>>
>> I'm curious, do you still see this issue if you first kill
>> gnome-power-manager first?
>>
>> >>
>> > Oh, this have already been fixed in the latest BIOS.
>>
>> Wasn't fixed in my case. =A0I'd be curious to here if it fixes for y=
ou.
>>
> no, the problem still exists.
> I misread your comment at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15182#c33
>
>> >
>> > Chris,
>> > do you mean you get duplicate hotkey events after upgrading the BI=
OS?
>>
>> With latest firmware, I get zero hotkey events over /dev/input/event=
*
>> unless I add acpi_backlight=3Dvendor to boot options.
>
> I just upgrade the BIOS to 1003, and I can still get input event
> from /dev/input/event4 (which is ACPI video bus).
> and there is no duplicate input events when pressing hotkey.
>
> thanks,
> rui

OK, I played around a little more and can now  reproduce what your
seeing.  What I need to do is boot such that eeepc-laptop is not
loaded.

Thanks for mentioning exact device name /dev/input/event4.  Its
interesting that mine is registered so late at /dev/input/event7.

input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)

If I bootup with no options then eeepc-laptop is not loaded.  In this
case, I do see events on input7 (I previously stated that I didn't.
Sorry about that).  In this case, it appears that gnome-power-manager
gets involved (I see the percentage bar updates) and the screen does
those funky non-linear updates.

If I bootup with just acpi_osi=3D"!Windows 2009" then eeepc-laptop does
get loaded.  In this case, the input7 still gets created but no events
are sent on it.  Also, an input9 device is created for eeepc-laptop
and brightness keys are NOT sent over it as well.  In this case, the
brightness levels are linear as long as I use Fn-keys only (not the
/sys/* interface).

And finally, if I boot with both acpi_osi=3D"!Windows 2009" and
acpi_backlight=3Dvendor then I  see events on eeepc-laptop input9 and
gnome-power-manager seems to get involved as well but this time the
display is updated linearly.

So in summary, I think it tells me this:

1) If ACPI only is involved then brightness controls work fine.  By
ACPI only, I mean using Fn-keys for brightness and doing something to
prevent software like gnome-power-manager from getting involved with
/sys/* interface.
2) Anything that writes to /sys/class/backlight/acpi_video0/brightness
works non-linearly.
3) If you keep software from writing to
/sys/class/backlight/acpi_video0/brightness then brightness changes
made with Fn-keys do not get reflected into any of those acpi_video0
files.  Writing to those files controls brightness non-linearly and
show up when you read back.
4) If I use acpi_backlight=3Dvendor then I can access
/sys/class/backlight/eeepc/brightness and it works linearly.  Things
like gnome-power-manager work good with this interface.

Chris
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
