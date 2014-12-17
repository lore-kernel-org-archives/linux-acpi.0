From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: update the skip case for acpi_video_device_in_dod
Date: Wed, 17 Dec 2014 01:28:54 +0100
Message-ID: <1521043.H5AWqcztdI@vostro.rjw.lan>
References: <548E9559.3080707@intel.com> <87r3w1jnf6.fsf@intel.com> <548FA52B.6060602@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51118 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751000AbaLQAHJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2014 19:07:09 -0500
In-Reply-To: <548FA52B.6060602@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Dmitry Tunin <hanipouspilot@gmail.com>, Jimbo <jaime.91@hotmail.es>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>

On Tuesday, December 16, 2014 11:21:15 AM Aaron Lu wrote:
> On 12/15/2014 05:02 PM, Jani Nikula wrote:
> > On Mon, 15 Dec 2014, Aaron Lu <aaron.lu@intel.com> wrote:
> >> If the firmware has declared more than 8 video output devices, and the
> >> one that control the internal panel's backlight is listed after the
> >> first 8 output devices, the _DOD will not include it due to the current
> >> i915 operation region implementation. As a result, we will not create a
> >> backlight device for it while we should. Solve this problem by special
> >> case the firmware that has 8+ output devices in that if we see such a
> >> firmware, we do not test if the device is in _DOD list. The creation of
> >> the backlight device will also enable the firmware to emit events on
> >> backlight hotkey press when the acpi_osi= cmdline option is specified on
> >> those affected ASUS laptops.
> >>
> >> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=70241
> >> Reported-and-tested-by: Oleksij Rempel <linux@rempel-privat.de>
> >> Reported-and-tested-by: Dmitry Tunin <hanipouspilot@gmail.com>
> >> Reported-and-tested-by: Jimbo <jaime.91@hotmail.es>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > 
> > Obviously I'd like to have the proper information in the opregion
> > DIDL/CADL fields, but it's not going to happen soon, nor is it going to
> > fit under stable size limits.
> > 
> > I like the simplicity here. FWIW,
> > 
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> Thanks :-)
> 
> BTW, this patch is more of a fix for my previous commit 0b8db271f159
> ("ACPI / video: check _DOD list when creating backlight devices") that
> made the acpi_video interface disappear on these affected laptops so I
> would like to fix it quickly. And I agree that a proper implementation
> of the DIDL/CADL list is needed so that people can get rid of the
> acpi_osi= cmdline option they currently need to get hotkey events.

Patch applied, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
