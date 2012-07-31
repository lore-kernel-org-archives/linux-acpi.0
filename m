From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 31 Jul 2012 12:17:05 -0400
Message-ID: <CADnq5_OszT7MkTOYNuABbNtg2Fvd7hGddrWLNAukmCXyKVh3Ow@mail.gmail.com>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	<3502295.b9B3oqyYO6@pali>
	<CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
	<5231555.Ogc4s2l7Ug@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <5231555.Ogc4s2l7Ug@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Artur Flinta <aflinta@gmail.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, joeyli <jlee@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 31, 2012 at 12:03 PM, Pali Roh=E1r <pali.rohar@gmail.com> w=
rote:
> On Tuesday 31 July 2012 17:49:32 Luca Tettamanti wrote:
>> I'm putting back the CC and adding Alex.
>>
>> On Tue, Jul 31, 2012 at 5:07 PM, Pali Roh=E1r
> <pali.rohar@gmail.com> wrote:
>> > Thanks, now working. When I write to acpi video brightness
>> > file it change brightness and in dmesg is:
>> >
>> > [   47.200998] [drm:radeon_atif_handler], event, device_class
>> > =3D video, type =3D 0xd0
>> > [   47.201102] [drm:radeon_atif_get_sbios_requests], SBIOS
>> > pending requests: 0x80
>> > [   47.201104] [drm:radeon_atif_handler], ATIF: 1 pending
>> > SBIOS requests
>> > [   47.201105] [drm:radeon_atif_handler], Changing brightness
>> > to 11
>>
>> Great! I'll send an updated patch to Alex soon.
>>
>> > I think that acpi only sent event about brightness key
>> > pressed, because nothing happened when I pressed it.
>> >
>> > Also for windows is needed special HP application (hp hotkey)
>> > for brightness keys. Without it brightness keys not working
>> > too...
>> I've looked at hp-wmi: the hotkey is indeed dispatched via WMI
>> (hp-wmi) so you need something in userspace (KDE, Gnome, etc)
>> to respond to that key press.
>>
>
> No, when I rmmod hp-wmi brightness keys still generate events.
> And when I disable acpi then brightness keys do not generate
> events but adjust brightness automatically (by BIOS).
>
> I think that hp-wmi on my notebook only handle bluetooth & wifi
> rfkills and ALS switch. All button working without hp-wmi too.
>
>> > And there is one problem with /sys/class/backlight/radeon_bl.
>> > When I enable Ambient Light Sensor which auto adjust
>> > brightness based on sensor data, writing value 0 (min) or
>> > 255 (max) to /sys/class/backlight/radeon_bl/brightness turn
>> > off display.
>> Ok, that's weird. 0 turns off the panel by design, 255 should
>> not...
>
> But when ALS is disabled 0 did not turn display off.

0 only turns off the backlight, not the panel itself.  Is the
backlight still partially on or is it just the actual panel (timing
and image)?

Alex
