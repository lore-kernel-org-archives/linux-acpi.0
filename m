From: Julian Wollrath <jwollrath@web.de>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Tue, 15 Jul 2014 23:38:24 +0200
Message-ID: <20140715233824.75142860@saldaea>
References: <20140712180636.698e2e4c@saldaea>
	<2446022.T09QX68ONu@vostro.rjw.lan>
	<20140714205629.130abac8@saldaea>
	<1634156.TNvHdb5NuS@vostro.rjw.lan>
	<53C4C4DD.7070103@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:55775 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759650AbaGOVi2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2014 17:38:28 -0400
In-Reply-To: <53C4C4DD.7070103@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Am Tue, 15 Jul 2014 14:06:21 +0800
schrieb Aaron Lu <aaron.lu@intel.com>:

> On 07/15/2014 03:17 AM, Rafael J. Wysocki wrote:
> > On Monday, July 14, 2014 08:56:29 PM Julian Wollrath wrote:
> >> Am Mon, 14 Jul 2014 21:10:47 +0200
> >> schrieb "Rafael J. Wysocki" <rjw@rjwysocki.net>:
> >>
> >>> On Monday, July 14, 2014 09:02:34 PM Rafael J. Wysocki wrote:
> >>>> On Monday, July 14, 2014 08:34:22 PM Julian Wollrath wrote:
> >>>>> Am Mon, 14 Jul 2014 20:21:19 +0200
> >>>>> schrieb "Rafael J. Wysocki" <rjw@rjwysocki.net>:
> >>>>>
> >>>>>> On Saturday, July 12, 2014 06:24:52 PM Julian Wollrath wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>>> changing the brightness on my Thinkpad X230 with Intel
> >>>>>>>> HD4000 graphics, stopped working after commit 886129a8eebe
> >>>>>>>> (ACPI / video: change acpi-video brightness_switch_enabled
> >>>>>>>> default to 0). Changing it back to 1, fixes the problem, if
> >>>>>>>> "acpi_osi=!Windows 2012" is also set. Before that commit
> >>>>>>>> just setting "acpi_osi=!Windows 2012" was enough to get
> >>>>>>>> changing the brightness working.
> >>>>>>>
> >>>>>>> small correction: It setting "acpi_osi=!Windows 2012" does
> >>>>>>> only help when using a kernel with commit 886129a8eebe as
> >>>>>>> HEAD, with v3.16-rc4 setting
> >>>>>>> video.brightness_switch_enabled=1 and acpi_osi=!Windows 2012
> >>>>>>> or just one of them, does not make changing the brightness
> >>>>>>> work again.
> >>>>>>
> >>>>>> And reverting commit 751109aad583 (ACPI / video: Change the
> >>>>>> default for video.use_native_backlight to 1) make that last
> >>>>>> problem go away, right?
> >>>>>>
> >>>>>> We are going to rever commit 886129a8eebe for other reasons, so
> >>>>>> can you please revert it from 3.16-rc5 on your system and
> >>>>>> report back?
> >>>>> Yes, with both 751109aad583 and 886129a8eebe reverted, changing
> >>>>> the brightness works again.
> >>>>
> >>>> What if you revert 886129a8eebe alone?
> >>>
> >>> I mean, what exactly do you need to pass to the kernel command
> >>> line in that case to make brightness switching work?
> >> I need to pass
> >>   acpi_osi="!Windows 2012" video.brightness_switch_enabled=1
> >> video.use_native_backlight=-1
> >>
> >> If I leave one of these parameters out, the brightness switch stops
> >> working.
> > 
> > With 886129a8eebe reverted you should not need
> > video.brightness_switch_enabled=1.
> > 
> > Aaron, what do you think?
> 
> I agree.
> 
> I suppose Julian is not using an standard GUI so he needs the in
> kernel processing of the backlight event.
If you consider just using a window manager and not a full blown DE not
using a standard GUI, than your hunch is right.

> And his laptop has a broken
> ACPI interface in Win8 mode, so he also needs the "!Windows 2012"
> option.
> 
> With a standard GUI environment, his system would have only one
> interface left: the GPU one and everything should work. But of course,
> that may not be his config.
> 
> Thanks,
> Aaron

