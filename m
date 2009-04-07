From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
Date: Tue, 07 Apr 2009 16:48:22 +0800
Message-ID: <1239094102.7661.103.camel@rzhang-dt>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090403092408.66809996@hobbes> <20090403162906.GB23243@srcf.ucam.org>
	 <1239075911.3582.206.camel@localhost.localdomain>
	 <20090407055717.GA14710@srcf.ucam.org>
	 <1239089123.3582.228.camel@localhost.localdomain>
	 <1239092434.7661.87.camel@rzhang-dt> <20090407082256.GA17012@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oCEmP0r7KmoJdoVjshB3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29835 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbZDGIsH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Apr 2009 04:48:07 -0400
In-Reply-To: <20090407082256.GA17012@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>, "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>


--=-oCEmP0r7KmoJdoVjshB3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

﻿CC Thomas, Len and linux-acpi mail list.

On Tue, 2009-04-07 at 16:22 +0800, Matthew Garrett wrote:
> On Tue, Apr 07, 2009 at 04:20:34PM +0800, Zhang Rui wrote:
> 
> > All subsystems can register a set of callbacks for backlight control in
> > its own way, e.g. ACPI, platform driver, i915.
> > And the backlight manager only exports one single I/F to users, like:
> > ----|
> >     |----brightness
> >     |----actual_brightness
> >     |----max_brightness
> >     |----...
> >     |----mode
> > and it supports multiple modes, e.g.
> > 1. generic ---ACPI
> > 2. platform---platform drivers
> > 3. legacy-----i915
> 
> This seems to be a lot of complexity for an uncommon case. Is there any 
> real need to modify the mode at runtime?

if this is implemented, the video_detect.c can be removed because we
don't need to detect the ACPI video extension when loading platform
drivers.
every driver that has its own ways to control the backlight can register
a set of callbacks and then it's the backlight manager's responsibility
to choose which one to use.

>  What happens if the platform 
> driver gets loaded before i915?
> 
the backlight manager always choose the one with the highest priority if
multiple callbacks are registered. i.e
if (ACPI control methods are available)
	changes to the "generic" mode
else if (platform specific callbacks are available)
	changes to the "platform" mode
else if (i915 callbacks are available)
	changes to the "legacy" mode

the backlight manager always run this logic when a new set of callbacks
is registered/unregistered.

thanks,
rui

--=-oCEmP0r7KmoJdoVjshB3
Content-Disposition: attachment; filename=backlight-manager
Content-Type: application/mbox; name=backlight-manager
Content-Transfer-Encoding: 7bit

>From rui.zhang@intel.com Tue Apr  7 16:20:36 2009
Subject: Re: [RFC] [intel-gfx] :The backlight issue when KMS is used
From: Zhang Rui <rui.zhang@intel.com>
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "sonne@debian.org" <sonne@debian.org>,  "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>
In-Reply-To: <1239089123.3582.228.camel@localhost.localdomain>
References: <1238737778.3582.163.camel@localhost.localdomain>
	 <20090403092408.66809996@hobbes> <20090403162906.GB23243@srcf.ucam.org>
	 <1239075911.3582.206.camel@localhost.localdomain>
	 <20090407055717.GA14710@srcf.ucam.org>
	 <1239089123.3582.228.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1239092434.7661.87.camel@rzhang-dt>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.1 (2.22.1-2.fc9) 
Date: Tue, 07 Apr 2009 16:20:36 +0800
X-Evolution-Format: text/plain
X-Evolution-Account: 1215592382.18116.21@rzhang-dt
X-Evolution-Transport: smtp://rui.zhang@mail.intel.com/;use_ssl=never
X-Evolution-Fcc: mbox:/root/.evolution/mail/local#Sent
Content-Transfer-Encoding: 8bit

On Tue, 2009-04-07 at 15:25 +0800, Zhao, Yakui wrote:
> > > But if we do so, it seems that we have to solve the dependency issue
> > > among acpi_video, i915 and platform driver. 
> > >    For example: I915 driver is loaded firstly and the interface will be
> > > registered. But after the acpi video driver/platform driver is loaded,
> > > how to send the notification event that i915 should unregister its
> > > interface? If the interface is unregistered, we will have to consider
> > > the arbiter order.
> > 
> > The acpi case is uninteresting - acpi_video_backlight_support() doesn't 
> > require the acpi video driver. The platform driver case is more 
> > interesting, but the easiest solution is probably to add a notifier 
> > chain for backlight device add and have i915 unregister when a platform 
> > device registers.
> Yes. We will have to create the communication channel between backlight
> device and i915 driver. And when a backlight I/F is registered, we will
> have to check whether the backlight I/F in 915 should be unregistered. 
> Right? 
> Does this make the problem complex? 
> > 
that's why I proposed to implement a backlight manager in the sysfs
backlight class driver.

All subsystems can register a set of callbacks for backlight control in
its own way, e.g. ACPI, platform driver, i915.
And the backlight manager only exports one single I/F to users, like:
----|
    |----brightness
    |----actual_brightness
    |----max_brightness
    |----...
    |----mode
and it supports multiple modes, e.g.
1. generic ---ACPI
2. platform---platform drivers
3. legacy-----i915

The sysfs backlight manager always chooses the mode with highest
priority (generic > platform > legacy), and call the respective
callbacks when backlight is changed.
For example, the backlight manager switches to the "generic" mode from
"legacy" mode automatically when ACPI video driver is loaded at runtime.

thanks,
rui


--=-oCEmP0r7KmoJdoVjshB3--

