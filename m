From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 31 Jul 2012 11:56:56 -0400
Message-ID: <CADnq5_OE-ms7JO8OyYj8dyXDJbnay2kxD3LAJ8CkGAG29ttjHw@mail.gmail.com>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	<1539163.XtGOYjTjgt@pali>
	<CAKPcRGp+1DBjP7ZTnVUphtY2acdU64gGBi9VO5WG7+83revV9g@mail.gmail.com>
	<3502295.b9B3oqyYO6@pali>
	<CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Artur Flinta <aflinta@gmail.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, joeyli <jlee@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 31, 2012 at 11:49 AM, Luca Tettamanti <kronos.it@gmail.com>=
 wrote:
> I'm putting back the CC and adding Alex.
>
> On Tue, Jul 31, 2012 at 5:07 PM, Pali Roh=E1r <pali.rohar@gmail.com> =
wrote:
>> Thanks, now working. When I write to acpi video brightness file
>> it change brightness and in dmesg is:
>>
>> [   47.200998] [drm:radeon_atif_handler], event, device_class =3D
>> video, type =3D 0xd0
>> [   47.201102] [drm:radeon_atif_get_sbios_requests], SBIOS
>> pending requests: 0x80
>> [   47.201104] [drm:radeon_atif_handler], ATIF: 1 pending SBIOS
>> requests
>> [   47.201105] [drm:radeon_atif_handler], Changing brightness to
>> 11
>
> Great! I'll send an updated patch to Alex soon.
>
>> I think that acpi only sent event about brightness key pressed,
>> because nothing happened when I pressed it.
>>
>> Also for windows is needed special HP application (hp hotkey) for
>> brightness keys. Without it brightness keys not working too...
>
> I've looked at hp-wmi: the hotkey is indeed dispatched via WMI
> (hp-wmi) so you need something in userspace (KDE, Gnome, etc) to
> respond to that key press.
>
>> And there is one problem with /sys/class/backlight/radeon_bl.
>> When I enable Ambient Light Sensor which auto adjust brightness
>> based on sensor data, writing value 0 (min) or 255 (max) to
>> /sys/class/backlight/radeon_bl/brightness turn off display.
>
> Ok, that's weird. 0 turns off the panel by design, 255 should not...
>
>> All
>> other values (1-254) are OK (adjust brightness level). When I
>> turn off Ambient Light Sensor (via hp-wmi kernel module) then
>> values 0 and 255 also set brightness level (min and max). My
>> suggestion is to convert value 0 to 1 and 255 to 254 to prevent
>> this problem.
>
> No idea what's going on here... might be some weird vendor magic.
> The WMI code is rather obscure...

=46WIW, there is also a bit in the atom firmware info table
(WMI_SUPPORT) to tell whether the system uses WMI or not.  We can
probably use that to limit the max backlight if 255 causes problems
for other WMI systems.  I'm not sure how the interaction with WMI is
supposed to work however.

Alex
