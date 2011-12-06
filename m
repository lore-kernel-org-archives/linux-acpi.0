From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [Dual-LVDS Acer Iconia laptop] i915/DRM issue: one screen stays
 off [3.2-rc4+]
Date: Tue, 6 Dec 2011 23:12:26 +0100
Message-ID: <CAN+gG=EaG1h=seuKQa_SF2O033WWn52USh=tjO9F9O55DgH17Q@mail.gmail.com>
References: <20111204160728.GA27292@archminux>
	<1323054041.6046.79.camel@linux-s257.site>
	<20111206215137.GA20907@archminux>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20111206215137.GA20907@archminux>
Sender: platform-driver-x86-owner@vger.kernel.org
To: joeyli <jlee@suse.com>, Baptiste Jonglez <baptiste@jonglez.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org, Mathieu Magnaudet <mathieu.magnaudet@enac.fr>
List-Id: linux-acpi@vger.kernel.org

Hi Baptiste,

On Tue, Dec 6, 2011 at 22:51, Baptiste Jonglez <baptiste@jonglez.org> w=
rote:
> On Mon, Dec 05, 2011 at 11:00:41AM +0800, joeyli wrote:
>> Add Cc. to platform-driver-x86 and linux-acpi
>>
>> Hi Baptiste
>>
>> =A9=F3 =A4=E9=A1A2011-12-04 =A9=F3 17:07 +0100=A1ABaptiste Jonglez =B4=
=A3=A8=EC=A1G
>> > Hi,
>> >
>> > I've got a lot of troubles with a dual-LVDS Acer laptop (it doesn'=
t
>> > have a keyboard, but two displays with touchscreens)
>> >
>> > The Intel GPU is integrated into the Core i5-480M CPU: it's a bit
>> > older than Sandybridge, as it seems to be based on the Arrandale
>> > micro-architecture.
>> >
>> > In the BIOS, both displays work fine; but as soon as the kernel bo=
ots
>> > up, the second display (i.e. the one where you usually find a
>> > keyboard) is turned off. The main display works as expected.
>> >
>> > xrandr reports two LVDS displays: LVDS1, which is connected, and
>> > LVDS2, which is marked as "disconnected". No matter what I tried, =
I
>> > can't bring that second display up.
>> >
>> > During the boot, just after the drm is set up, the following messa=
ge
>> > shows up:
>> >
>> >   [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM f=
unctions
>> >
>> > (attached is the relevant part of dmesg [1])
>
> The second screen works fine with the attached patch. It actually is
> 6 months old but seems to have been lost in the wild...

You don't have the problem of the second backlight still off?
On our Iconia, we need to trigger a special DMI command to set it up
(SDSS, IIRC).

>
> Thanks Benjamin!

All the credits are from Ajax and somebody else on IRC I don't recall,
really sorry. Thanks to them.

Cheers,
Benjamin.

>
> There is still the issue of unhandled acer-wmi events, but it's far
> less incapacitating. I wonder what's the best way to report events to
> userspace, though (e.g. for the "keyboard" button, userspace might
> want to know when it is pressed in order to display a virtual keyboar=
d
> or any other fancy stuff)
>
> Joey, if you need more logs for acer-wmi, I'll be happy to provide.
>
>
> Baptiste
