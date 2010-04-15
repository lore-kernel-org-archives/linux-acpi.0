From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [Acpi4asus-user] 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 21:00:31 -0500
Message-ID: <y2wdb599ead1004141900g5073bbb2m62facafc7a6672bd@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
	 <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
	 <20100414164030.GA14758@srcf.ucam.org>
	 <v2vdb599ead1004141014qb02bc808l6aa29c3b5b23de51@mail.gmail.com>
	 <20100414172608.GA15965@srcf.ucam.org>
	 <w2rdb599ead1004141518ze39ccb45g8b588888e6a87fcf@mail.gmail.com>
	 <1271295002.7167.187.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1271295002.7167.187.camel@rzhang1-desktop>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2010 at 8:30 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2010-04-15 at 06:18 +0800, Chris Bagwell wrote:
>> On Wed, Apr 14, 2010 at 12:26 PM, Matthew Garrett <mjg59@srcf.ucam.o=
rg> wrote:
>> > On Wed, Apr 14, 2010 at 12:14:04PM -0500, Chris Bagwell wrote:
>> >
>> >> Does the acpi-video logic not have logic on its own to send key
>> >> events? =A0So I guess laptops that don't have custom modules to h=
andle
>> >> this type of stuff don't get visual feedback from gnome-power-man=
ager?
>> >
>> > It does, but it's dependent upon the firmware sending them.
>>
>> I think the following tells me firmware is sending them. =A0If I lea=
ve
>> acpi_osi=3D"Windows 2009" so that eeepc_laptop doesn't get loaded, I=
 see
>> events like this on /pro/acpi/event:
>>
>> video LCDD 00000087 00000000
>> video LCDD 00000087 00000000
>> video LCDD 00000086 00000000
>> video LCDD 00000086 00000000
>>
>> Thats a couple decreases followed by a couple increases.
>>
> I have a EEEpc 1005PE. I'm looking at the backlight problem on this
> machine, but it seems to be different from this one.
>
> The hotkey seems to work perfectly when ACPI video driver is loaded.
> i.e. I get a single hotkey event when pressing the hotkey and the val=
ue
> of /sys/class/backlight/acpi_video0/brightness changes correctly.
>
> The only problem I get is that the actual brightness does not change
> consistently.
> say, there are 15 brightness levels in all,
> level 0, level 5 and level 12 give me a screen with lowest brightness=
=2E
> If I want to get maximum backlight, I need to set it to level 4 or le=
vel
> 11.

If I do not set acpi_backlight=3Dvendor and then change brightness by
writing to above /sys/* link this is same behaviour I see as well.  If
I use Fn-F5 and Fn-F6, I do not see the issue (brightness increments
linearly).  I believe thats because events are not sent to
/dev/input/event* and so software (gnome-power-manager) is never
notified and won't wrote to /sys/*.  If I launch power manager
preferences and change brightness then I do see issue.

In this case, I'm using Fedora 13 beta's kernel 2.6.33.2-41.

>
> could you tell me your BIOS version please?

Yesterday, I was running 0901 and today I'm running 1003.  Same
behaviour in both cases.
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
