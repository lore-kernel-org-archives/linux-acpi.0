From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] acpi-video: Add a parameter to not register the backlight sysfs interface
Date: Tue, 16 Jun 2015 01:18:35 +0200
Message-ID: <1457636.70KYTLePgN@vostro.rjw.lan>
References: <1433838745-8857-1-git-send-email-hdegoede@redhat.com> <87mw065wls.fsf@intel.com> <55797B83.7010903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58548 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751202AbbFOWwi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 18:52:38 -0400
In-Reply-To: <55797B83.7010903@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Sylvain Pasche <sylvain.pasche@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>

On Thursday, June 11, 2015 02:13:55 PM Hans de Goede wrote:
> Hi,
> 
> On 11-06-15 13:10, Jani Nikula wrote:
> > On Thu, 11 Jun 2015, Hans de Goede <hdegoede@redhat.com> wrote:
> >> Hi,
> >>
> >> On 11-06-15 03:43, Aaron Lu wrote:
> >>> On Tue, Jun 09, 2015 at 11:54:45PM +0200, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 06/09/2015 11:10 AM, Aaron Lu wrote:
> >>>>> On Tue, Jun 09, 2015 at 10:32:25AM +0200, Hans de Goede wrote:
> >>>>>> On some systems acpi-video backlight is broken in the sense that it cannot
> >>>>>> control the brightness of the backlight, but it must still be called on
> >>>>>> resume to power-up the backlight after resume.
> >>>>>
> >>>>> All the video module does on resume is a backlight set operation, it
> >>>>> can't control backlight but can turn on the screen on resume? Hmm...
> >>>>>
> >>>>> I'll ask Sylvain to attach acpidump, let's see if there is anything
> >>>>> special there.
> >>>>
> >>>> Ok, lets see what comes out of that. Note in the mean time Sylvain has
> >>>> attached his acpidump.
> >>>
> >>> Thanks.
> >>> According to the discussion in the bugzilla place, it doesn't seem we
> >>> have any other way to handle this at the moment.
> >>>
> >>> Acked-by: Aaron Lu <aaron.lu@intel.com>
> >>
> >> Thanks. So that only leaves Jani's remark:
> >>
> >>   > Nitpick, I'd prefer positively named variables, like enable_foo to avoid
> >>   > the double negative !disable_foo. enable_foo and !enable_foo read much
> >>   > better. But up to Aaron and friends.
> >>
> >> I personally believe that having the option named disable_backlight_sysfs_if
> >> is better here since I believe that things which are always enabled except
> >> on a few broken model laptops the option name should be disable_foo so
> >> that people can clearly see in /proc/cmdline / dmesg that the user is passing
> >> an option to disable something which is normally enabled.
> >
> > Fair enough.
> >
> >>
> >> As for the (!disabled) argument, the code in question here actually is:
> >>
> >> if (disabled)
> >> 	return 0;
> >>
> >> :)
> >>
> >> Still if people want me to change the option to a default-on
> >> enable_backlight_sysfs_if option I can do a v3...
> >
> > I'm not insisting.
> 
> Great, thanks :)
> 
> So I'm going to assume this v2 patch is ready for merging then, if anyone
> wants me to make any changes please let me know.

The v2 queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
