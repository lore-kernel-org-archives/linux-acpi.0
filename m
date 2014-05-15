From: Mattia Dongili <malattia@linux.it>
Subject: Re: RFC: Cleanup firmware backlight control method selection
Date: Fri, 16 May 2014 07:29:38 +0900
Message-ID: <20140515222938.GA29253@taihen.jp>
References: <53748332.50909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53748332.50909@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 15, 2014 at 11:04:50AM +0200, Hans de Goede wrote:
> Hi All,
> 
> There are various issues with how the linux kernel currently select which
> firmware backlight control (*) method to use:
> 
> 1) There are various module loading ordering issues, leading to different
> behavior depending on module load ordering:
> 
> * http://www.spinics.net/lists/linux-acpi/msg50443.html
> * Sometimes we register and immediately unregister the acpi_video# backlight
>   devices, some ACPI implementations don't like this, so we've special
>   quirks to avoid the register + unregister on some machines
> 
> 2) There are 2 main kernel commandline options involved acpi_backlight and
> video.use_native_backlight. With the latter only working if certain firmware
> checks succeed *and* the former has the right value. This is confusing not
> only for end users but also for people trying to read the code in question.
> Note some vendor specific firmware backlight drivers, ie thinkpad_acpi.c
> have their own related options, leading to 3 kernel cmdline options coming
> into play.
> 
> 3) We have quirks everywhere. I'm afraid we cannot get rid of these, but
> at least we should try to clean up where they live and how they interact
> with each other. acpi_backlight=vendor quirks mostly live in vendor specific
> firmware backlight drivers. But we also have a couple in acpi/video_detect.c.
> video.use_native_backlight=1 quirks otoh live in acpi/video.c.
> 
> In the end all these options and quirks all work together in a complicated
> manor to achieve one simple goal: decide which firmware interface to use
> for backlight control (*). Which comes down to choosing between the
> following 3 options:
> 
> 1 Native (raw) backlight control (so no firmware backlight control)
> 2 Control by the standard acpi-video firmware backlight driver
> 3 Control by a vendor specific firmware backlight driver
> 
> So I would like to propose to give the acpi_backlight= kernel commandline
> option which currently accepts values "vendor" and "video" a third value
> "native", and to get rid of the video.use_native_backlight option.

the "acpi_" prefix here sounds inappropriate at this point. And
descending from that, shouldn't a mechanism like you describe being
implemented in the backlight subsystem?

> This would be combined with a major cleanup of the existing code for
> firmware backlight control method selection:
> 
> 1) Replace the ACPI_VIDEO_BACKLIGHT_* flags with an enum listing the 3 options
> 2) Replace the acpi_video_support variable with
>    acpi_backlight_method_cmdline and acpi_backlight_method_dmi variables,
>    both initialzed to -1
> 3) Add an acpi_backlight_method() function which will:
>   - return acpi_backlight_method_cmdline if not -1; else
>   - return acpi_backlight_method_dmi if not -1; else
>   - return ACPI_BACKLIGHT_NATIVE if acpi_osi_is_win8(); else
>   - return ACPI_BACKLIGHT_VIDEO if supported; else
>   - return ACPI_BACKLIGHT_VENDOR
> 4) Have all drivers that use acpi_video_dmi_promote_vendor move their
>    quirks for this to acpi/video_detect.c, removing the need for them to
>    call acpi_video_dmi_promote_vendor() and acpi_video_unregister(), removing
>    the load ordering issues and removing them depending on video.ko

I think the whole idea of promote/demote_vendor was to avoid adding
vendor specific quirks to acpi's video code. If it was the right
implementation different story, but it sure sounded like a sensble idea.
We do have platform drivers that know if they should control backlight
or let it do to ACPI or even the native driver. Quirks in the patform
specific code _is_ IMO the right place to have those quirks.

> 5) Switch all drivers from acpi_video_backlight_support() to
>    acpi_backlight_method()
> 
> The plan would be to do 1-3 in a single patch and ASAP and then do 4 and 5
> driver by driver, and once done remove acpi_video_dmi_promote_vendor() and
> acpi_video_backlight_support(), and mark acpi_video_register /
> acpi_video_unregister as "only for i915 use".
> 
> Regards,
> 
> Hans
> 
> 
> *) Note I'm only talking about controlling the actual brightness of the
> backlight, not detecting brighness/backlight hotkey presses, there are
> similar issues there. But I believe that that should be treated as an
> orthogonal problem which should be fixed independently of this.

Maybe I'm missing some recent evolution but except for some special
cases, backlight hotkeys generally result in an input event sent to
userspace and it then becomese a userspace problem to choose which
interface to use.

Last, just to add another use case, vaio laptops in specific
configurations require both ACPI and vendor backlight to be registered
as the former will notify the latter to change the backlight rather than
doing it itself. It's explained here (with a potential implementation):
http://www.spinics.net/lists/platform-driver-x86/msg05191.html

Regards,
-- 
mattia
:wq!
