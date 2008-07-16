From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
	is serving this functionality
Date: Wed, 16 Jul 2008 09:57:00 +0800
Message-ID: <1216173420.1617.160.camel@rzhang-dt>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
	 <1215700265-24908-5-git-send-email-trenn@suse.de>
	 <1216114700.1940.12.camel@earth.gruber.myown>
	 <200807151446.31799.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55838 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYGPB6S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 21:58:18 -0400
In-Reply-To: <200807151446.31799.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: nokos@gmx.net, jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, 2008-07-15 at 14:46 +0200, Thomas Renninger wrote:
> On Tuesday 15 July 2008 11:38:20 nokos@gmx.net wrote:
> > Hi there,
> >
> > on the S6410 this prevents brightness control from working correctly.
> > the ACPI BIOS provides non-functional _BCM/_BQC so the video.ko is
> > registering backlight functions but does not work. Unfortunately not
> > loading video.ko isn't a solution since with
> > bc45b1d39a925b56796bebf8a397a0491489d85c the brightness keys are only
> > reported through video.ko.
> Is this an Intel graphics card?
> Then you should also try Matthew's/Hong's IGD extensions.
> It is likely that everything works out with video.ko then.
> If not, with a patch I sent recently you should switch off Windows osi strings 
> with:
> acpi_osi=windows_false   (preferred)
> or (already works)
> acpi_osi="!Windows 2006"
> 
> If it still does not work, then there is a driver missing which was  a 
> proprietary one on XP and which has not been fully re-engeeniered for Linux.
> 
> Using ACPI video events and pass them to the Fujitsu driver to change 
> backlight (is this how it works? Is this done through userspace?), mixes up 
> everything.
No. The platform drivers have nothing to do with ACPI Video driver, they
have platform specific events/control methods.
Maybe you mixed it up with the IGD stuff.
In IGD mode, ACPI video works together with graphics driver,
And in this case, ACPI video exports ACPI video events, graphics driver
gets the events (acpi_notifier_chain) and do the actual work. The ACPI
control method (_BCM) is not used any more so that only the graphics
driver touches the hardware. :)

thanks,
rui


