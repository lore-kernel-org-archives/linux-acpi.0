From: James Hogan <jhogan@kernel.org>
Subject: Re: [REGRESSION] [v2] ACPI / video: Default lcd_only to true on Win8
 ready and newer machines
Date: Sun, 15 Apr 2018 23:54:06 +0100
Message-ID: <20180415225403.GA6373@jamesdev>
References: <20171223184147.12016-1-hdegoede@redhat.com>
 <20180414230746.GA29537@saruman>
 <d5ff7ff3-4fa1-0f8c-e0a9-6779b9185e14@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5ff7ff3-4fa1-0f8c-e0a9-6779b9185e14@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Apr 15, 2018 at 02:04:26PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 15-04-18 01:07, James Hogan wrote:
> > On Sat, Dec 23, 2017 at 07:41:47PM +0100, Hans de Goede wrote:
> > > We're seeing a lot of bogus backlight interfaces on newer machines without
> > > a LCD such as desktops, servers and HDMI sticks. This causes userspace to
> > > show a non-functional brightness slider in e.g. the GNOME3 system menu,
> > > which is undesirable. More in general we should simply just not register
> > > a non functional backlight interface.
> > > 
> > > Checking the lcd flag causes the bogus acpi_video backlight interfaces to
> > > go away (on the machines this was tested on).
> > > 
> > > This commit enables the lcd_only option by default on any machines which
> > > are win8 ready, fixing this.
> > > 
> > > This is not entirely without risk of regressions, but video_detect.c
> > > already prefers native-backlight interfaces over the acpi_video one
> > > on win8 ready machines, calling acpi_video_unregister_backlight() as soon
> > > as a native interface shows up. This is done because the acpi backlight
> > > interface often is broken on win8 ready machines, because win8 does not
> > > seem to actually use it.
> > 
> > This patch (in the form of commit 965736ee654d ("ACPI / video: Default
> > lcd_only to true on Win8-ready and newer machines") in stable v4.15.17),
> > breaks backlight control on my 2013 XPS13 laptop.
> > 
> > It normally uses the acpi backlight device, but after this patch that
> > device no longer shows up in sysfs.
> > 
> > This isn't the first time the backlight has gotton broken on this
> > system, though I think last time it was because the intel backlight
> > driver got used instead of the ACPI one and that didn't work properly
> > with it, so it needed a quirk to make it use ACPI instead.
> > 
> > Is some other quirk needed around here too?
> 
> Yes looks like it (sigh), but I cannot find an existing quirk for
> your laptop.

I did at one point have to revert commit bc0bb9fd1c78 ("drm/i915: remove
QUIRK_NO_PCH_PWM_ENABLE") for a few kernel releases until 4.3,
presumably fixed by commit b029e66fa8e3 ("drm/i915: Backlight control
using CRC PMIC based PWM driver").

> When you say quirk do you mean you add something to
> the kernel commandline to work around this?

No, it was automatic, in the source. I don't know this code well enough
to know how they got it working.

> Normally we would add
> a dmi based quirk so that future versions automatically do the
> right thing.  I was looking for the existing quirk so that I
> could re-use the dmi strings, but I don't see an existing quirk.
> 
> Can you run:
> 
> sudo dmidecode > dell-xps13-2013-dmi.log
> 
> And then send me a *personal* mail with that file attached.
> It is best to not send this to the list as it will contain you
> machines serial number and other unique information.

Will do.

Thanks
James
