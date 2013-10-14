From: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] acpi/video: Add Lenovo IdeaPad Yoga 13 to acpi video
  detect blacklist
Date: Mon, 14 Oct 2013 17:36:21 +0200
Message-ID: <20131014153621.GA7758@tango.0pointer.de>
References: <20131014005505.GA30503@tango.0pointer.de>
 <525B44C0.3010204@intel.com>
 <20131014022325.GA2248@tango.0pointer.de>
 <525B58BE.5050009@intel.com>
 <20131014034927.GA3638@tango.0pointer.de>
 <525B703E.7080102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tango.0pointer.de ([85.214.72.216]:48186 "EHLO
	tango.0pointer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3JNPgX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2013 11:36:23 -0400
Content-Disposition: inline
In-Reply-To: <525B703E.7080102@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org

On Mon, 14.10.13 12:17, Aaron Lu (aaron.lu@intel.com) wrote:

> > Hmm, regarding your patch series, do you plan to skip the registration
> > of the acpi backlight device if the "raw" device is supported? I mean,
> 
> Yes, that's right.
> 
> > the intel driver could be compiled as a module (and generally is on the
> > popular distros), so at the time the ACPI subsystem wants to register
> > the backlight device and know if a raw backlight device is around it
> > never will be, so what is the point of that? Or am I missing something?
> 
> For systems with Intel i915 GPU, ACPI video will wait for GPU driver to
> run first, see drivers/acpi/video.c acpi_video_init, the actual
> acpi_video_register function is called by i915 driver in
> i915_driver_load due to operation region related stuff. Since all
> problematic systems reported so far has an Intel GPU, I'm doing it this
> way now. If things change, we can enhance it then.

Sorry, still not getting this. How should this ever work if the intel
video driver is compiled as kmod? That means that it isn't clear at all
when the kmod is going to be loaded or if it is loaded at all, you
cannot delay the registration of the acpi backlight that long, since the
time you'd have to wait is basically unbounded...

So, how could this ever work?

AFAICS all popular distros ship the video drivers as kernel modules,
hence trying to avoid registration of the ACPI backlight if the intel
driver is compiled will be an entirely pointless excercise on all
distros?

What am I missing?

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
