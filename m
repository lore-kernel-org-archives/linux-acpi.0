From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Wed, 8 Apr 2009 09:54:01 +0200
Message-ID: <200904080954.03666.trenn@suse.de>
References: <1238737778.3582.163.camel@localhost.localdomain> <20090407082256.GA17012@srcf.ucam.org> <1239094102.7661.103.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54716 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbZDHHyI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Apr 2009 03:54:08 -0400
In-Reply-To: <1239094102.7661.103.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tuesday 07 April 2009 10:48:22 Zhang Rui wrote:
> CC Thomas, Len and linux-acpi mail list.
> 
> On Tue, 2009-04-07 at 16:22 +0800, Matthew Garrett wrote:
> > On Tue, Apr 07, 2009 at 04:20:34PM +0800, Zhang Rui wrote:
> > 
> > > All subsystems can register a set of callbacks for backlight control in
> > > its own way, e.g. ACPI, platform driver, i915.
> > > And the backlight manager only exports one single I/F to users, like:
> > > ----|
> > >     |----brightness
> > >     |----actual_brightness
> > >     |----max_brightness
> > >     |----...
> > >     |----mode
> > > and it supports multiple modes, e.g.
> > > 1. generic ---ACPI
> > > 2. platform---platform drivers
> > > 3. legacy-----i915
> > 
> > This seems to be a lot of complexity for an uncommon case. Is there any 
> > real need to modify the mode at runtime?
Whatabout several graphics cards, vendors are already selling.
If you switch the graphics cards you also might have to pick up another
backlight back-end?
 
> if this is implemented, the video_detect.c can be removed because we
> don't need to detect the ACPI video extension when loading platform
> drivers.
Hmm, above pretty much looks like what video_detect.c does + i915 detection.
One problem is that you have to detect things before drivers are loaded and
possibly register the wrong interface, so this needs to be implemented in
code that is always compiled in.
Are there more details where and how this should get implemented?
Or can someone provide a pointer to the beginning of the thread?
The graphics driver was the missing part when choosing who is going to
switch things. Now that it moves into the kernel, synchronization between
all above drivers is probably a good idea.

Whatabout display output switching?
The problem is similar, you have:
  - vendor specific (e.g. in thinkpad-laptop)
  - ACPI
  - graphics driver
Here the first two never really worked (at least for a large range of systems)
AFAIK. AFAIK 3D graphics drivers disable IO regions so that ACPI
or others cannot change them anymore and take over. How is this supposed to
work with (and without) KMS?

   Thomas

> every driver that has its own ways to control the backlight can register
> a set of callbacks and then it's the backlight manager's responsibility
> to choose which one to use.
> 
> >  What happens if the platform 
> > driver gets loaded before i915?
> > 
> the backlight manager always choose the one with the highest priority if
> multiple callbacks are registered. i.e
> if (ACPI control methods are available)
> 	changes to the "generic" mode
> else if (platform specific callbacks are available)
> 	changes to the "platform" mode
> else if (i915 callbacks are available)
> 	changes to the "legacy" mode
> 
> the backlight manager always run this logic when a new set of callbacks
> is registered/unregistered.
> 
> thanks,
> rui
> 


