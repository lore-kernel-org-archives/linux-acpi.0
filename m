From: Mattia Dongili <malattia@linux.it>
Subject: Re: RFC: Cleanup firmware backlight control method selection
Date: Mon, 19 May 2014 08:24:42 +0900
Message-ID: <20140518232442.GA2060@taihen.jp>
References: <53748332.50909@redhat.com>
 <20140515222938.GA29253@taihen.jp>
 <5375C6F7.7090305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5375C6F7.7090305@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 16, 2014 at 10:06:15AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 05/16/2014 12:29 AM, Mattia Dongili wrote:
> > On Thu, May 15, 2014 at 11:04:50AM +0200, Hans de Goede wrote:
> >> Hi All,
> >>
> >> There are various issues with how the linux kernel currently select which
> >> firmware backlight control (*) method to use:
> >>
> >> 1) There are various module loading ordering issues, leading to different
> >> behavior depending on module load ordering:
> >>
> >> * http://www.spinics.net/lists/linux-acpi/msg50443.html
> >> * Sometimes we register and immediately unregister the acpi_video# backlight
> >>   devices, some ACPI implementations don't like this, so we've special
> >>   quirks to avoid the register + unregister on some machines
> >>
> >> 2) There are 2 main kernel commandline options involved acpi_backlight and
> >> video.use_native_backlight. With the latter only working if certain firmware
> >> checks succeed *and* the former has the right value. This is confusing not
> >> only for end users but also for people trying to read the code in question.
> >> Note some vendor specific firmware backlight drivers, ie thinkpad_acpi.c
> >> have their own related options, leading to 3 kernel cmdline options coming
> >> into play.
> >>
> >> 3) We have quirks everywhere. I'm afraid we cannot get rid of these, but
> >> at least we should try to clean up where they live and how they interact
> >> with each other. acpi_backlight=vendor quirks mostly live in vendor specific
> >> firmware backlight drivers. But we also have a couple in acpi/video_detect.c.
> >> video.use_native_backlight=1 quirks otoh live in acpi/video.c.
> >>
> >> In the end all these options and quirks all work together in a complicated
> >> manor to achieve one simple goal: decide which firmware interface to use
> >> for backlight control (*). Which comes down to choosing between the
> >> following 3 options:
> >>
> >> 1 Native (raw) backlight control (so no firmware backlight control)
> >> 2 Control by the standard acpi-video firmware backlight driver
> >> 3 Control by a vendor specific firmware backlight driver
> >>
> >> So I would like to propose to give the acpi_backlight= kernel commandline
> >> option which currently accepts values "vendor" and "video" a third value
> >> "native", and to get rid of the video.use_native_backlight option.
> > 
> > the "acpi_" prefix here sounds inappropriate at this point. And
> > descending from that, shouldn't a mechanism like you describe being
> > implemented in the backlight subsystem?
> 
> This is only a problem with crazy PC's which have multiple firmware
> API's (both standardized and custom ACPI) to control the backlight, which
> also are sometimes all broken. So this really is an acpi thing, and I believe
> this should stay in acpi/video_detect.c where it already lives, I just think
> the video.use_native_backlight option which clearly interacts with this needs
> to be moved to acpi/video_detect.c too.

I didn't realize the use_native_backlight option was in acpi/video.c.
Nevemind what I said, leave this crazyness to stay in the acpi world
only then.
Don't you still have ordering issues though? can the raw device be
loaded after video_detect runs?

...
> >> 3) Add an acpi_backlight_method() function which will:
> >>   - return acpi_backlight_method_cmdline if not -1; else
> >>   - return acpi_backlight_method_dmi if not -1; else
> >>   - return ACPI_BACKLIGHT_NATIVE if acpi_osi_is_win8(); else

this seems to be a way more wide case than today's code that combines it
with quirks or the kernel option.

> >>   - return ACPI_BACKLIGHT_VIDEO if supported; else
> >>   - return ACPI_BACKLIGHT_VENDOR

...
> >> *) Note I'm only talking about controlling the actual brightness of the
> >> backlight, not detecting brighness/backlight hotkey presses, there are
> >> similar issues there. But I believe that that should be treated as an
> >> orthogonal problem which should be fixed independently of this.
> > 
> > Maybe I'm missing some recent evolution but except for some special
> > cases, backlight hotkeys generally result in an input event sent to
> > userspace and it then becomese a userspace problem to choose which
> > interface to use.
> 
> Not sure if you're referring to the above discussion here, or to my remark
> about hotkey issues, so let me answer both:
> 
> * As for why we cannot simply register all firmware backlight drivers
> and let userspace figure things out. There are 2 reasons:
> 1) Userspace will pick the first firmware driver it sees, to avoid this
> causing issues we've historically always registered only one. So we're
> stuck with this approach to avoid causing regressions

well, in my limited experience I have seen userspace anyway blacklist
the sony/acpi backlight control for the intel one since it is available
regardless of acpi and gives (actually used to give) better granularity.

> 2) Having multiple pieces of firmware code frob the same hardware seems
> like a really really bad idea.
> 
> * As for the hotkeys issue, the problem is actually very much the same as
> with the backlight control. laptop brightness hotkeys tend to generate 3
> events for each press:
> 1) A ps2 atkbd scancode
> 2) an acpi-video event
> 3) a vendor-wmi event.
> 
> 1) may be mapped to generate input events through /lib/udev/hwdb.d/60-keyboard.hwdb
> 2) will generate input events if the acpi-video driver is registered
>    (independent of it also exporting a backlight control interface)
> 3) may or may not generate events depending on the vendor specific driver
> 
> I know of at least one laptop where all 3 methods are hooked up, causing
> the brightness to go down 3 levels for each keypress. This is something else
> wrt backlight control which we clearly need to fix, to ensure that we only
> send one input event per key press.
> 
> > Last, just to add another use case, vaio laptops in specific
> > configurations require both ACPI and vendor backlight to be registered
> > as the former will notify the latter to change the backlight rather than
> > doing it itself. It's explained here (with a potential implementation):
> > http://www.spinics.net/lists/platform-driver-x86/msg05191.html
> 
> Hmm, that sounds like something which is going to turn very ugly very soon.

it is already... the problem is really the AML code, when the ALS device
is enabled a different code path is run in _BCM[1]. A call to _BCM
results in a Notify(SNC) rather than changing brigthenss level. SNC
needs to be able to see what is the new brightness level and set it.
I think having the backlight subsystem to allow drivers to cooperate
nicely instead of stomping on each other is the best way to go around
this.

> Have tried using acpi_backlight=vendor, so that the acpi-video driver will
> only catch events and not try to do any backlight control? Then the

the hotkeys go through the vendor/platform driver for vaios.

But anyway, I think the specific discussion about sony-laptop doesn't
belong to here, what I wanted to mention was that there's other use
cases and maybe changing approach to a runtime cooperation rather than
being exclusive at load time may be a workable option. Of course there
will be all sort corner cases with either approach.

[1]: just for reference here is the snippet from a vaio SSDT:
BRTL is the value returned in _BCQ, what SNC knows is that there was a
brightness change request, not actioned.

                    If (Local1)
                    {
                        Store (One, ALER)
                        Store (Arg0, BRTL)
                        Notify (\_SB.PCI0.LPCB.SNC, 0x93)
                    }
                    Else
                    {
                        Store (Zero, ALER)
                        If (LAnd (LGreaterEqual (Arg0, Zero), LLessEqual (Arg0, 0xFF)))
                        {
                            If (LGreaterEqual (OSYS, 0x07DC))
                            {
                                Store (Subtract (Match (ICL1, MEQ, Arg0, MTR, Zero, 0x02), 0x02
                                    ), Local0)
                                Store (DerefOf (Index (RTL1, Local0)), Local0)
                            }
                            Else
                            {
                                Store (Subtract (Match (ICL0, MEQ, Arg0, MTR, Zero, 0x02), 0x02
                                    ), Local0)
                                Store (DerefOf (Index (RTL0, Local0)), Local0)
                            }

                            \_SB.PCI0.GFX0.AINT (One, Local0)
                            Store (Arg0, BRTL)
                        }
                    }

-- 
mattia
:wq!
