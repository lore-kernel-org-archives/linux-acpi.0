From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Wed, 08 Apr 2009 08:59:55 +0800
Message-ID: <1239152395.3635.13.camel@localhost.localdomain>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090403092408.66809996@hobbes> <20090403162906.GB23243@srcf.ucam.org>
	 <1239075911.3582.206.camel@localhost.localdomain>
	 <20090407055717.GA14710@srcf.ucam.org>
	 <1239089123.3582.228.camel@localhost.localdomain>
	 <1239092434.7661.87.camel@rzhang-dt> <20090407082256.GA17012@srcf.ucam.org>
	 <1239094102.7661.103.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55806 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbZDHA6r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Apr 2009 20:58:47 -0400
In-Reply-To: <1239094102.7661.103.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, 2009-04-07 at 16:48 +0800, Zhang, Rui wrote:
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
> 
> if this is implemented, the video_detect.c can be removed because we
> don't need to detect the ACPI video extension when loading platform
> drivers.
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
Is this manager realized in kernel space or user space?
> 
> thanks,
> rui

