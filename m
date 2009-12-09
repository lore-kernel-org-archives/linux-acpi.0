From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv2 0/2] Introducing the Ambient Light Sensor (ALS) class
Date: Wed, 09 Dec 2009 09:51:37 +0800
Message-ID: <1260323497.27069.279.camel@rzhang1-desktop>
References: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com>
	 <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
	 <20091207160432.3108e17b@hyperion.delvare>
	 <20091208140005.GA3125@everest.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45032 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbZLIBuQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2009 20:50:16 -0500
In-Reply-To: <20091208140005.GA3125@everest.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "alan@linux.intel.com" <alan@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>

On Tue, 2009-12-08 at 22:00 +0800, Amit Kucheria wrote:
> On Mon, Dec 7, 2009 at 5:04 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon, 7 Dec 2009 16:50:23 +0200, Amit Kucheria wrote:
> >> On Mon, Nov 30, 2009 at 1:45 PM, Amit Kucheria
> >> <amit.kucheria@verdurent.com> wrote:
> >> > Introduce a new class of devices to handle ambient light sensors. Currently
> >> > only one sysfs inteface, 'illuminance' is introduced. More will be added as
> >> > drivers are ported to use this new class.
> >> >
> >> > Amit Kucheria (1):
> >> >  als: add unique device-ids to the als device class
> >> >
> >> > Zhang Rui (1):
> >> >  introduce ALS sysfs class
> >> >
> >> >  Documentation/ABI/testing/sysfs-class-als |    9 ++
> >> >  MAINTAINERS                               |    6 ++
> >> >  drivers/Kconfig                           |    2 +
> >> >  drivers/Makefile                          |    1 +
> >> >  drivers/als/Kconfig                       |   10 +++
> >> >  drivers/als/Makefile                      |    5 +
> >> >  drivers/als/als_sys.c                     |  116 +++++++++++++++++++++++++++++
> >> >  include/linux/als_sys.h                   |   35 +++++++++
> >> >  8 files changed, 184 insertions(+), 0 deletions(-)
> >> >  create mode 100644 Documentation/ABI/testing/sysfs-class-als
> >> >  create mode 100644 drivers/als/Kconfig
> >> >  create mode 100644 drivers/als/Makefile
> >> >  create mode 100644 drivers/als/als_sys.c
> >> >  create mode 100644 include/linux/als_sys.h
> >> >
> >>
> >> (Bump)
> >>
> >> Is there any blocker to adding this for 2.6.33?
> >
> > As far as I am concerned, it's ready to go. And I would love to see it
> > in 2.6.33.
> >
> >> Which maintainer will pick up the ALS framework?
> >
> > As Rui volunteered to be the maintainer of this new subsystem, it would
> > seem fair that he takes care of the initial push as well.
> 
> Rui,
> 
> Not sure about the LKML netiquette here, but I could track this patchset to
> get it merged. Let me know.

that would be great.

thanks,
rui

