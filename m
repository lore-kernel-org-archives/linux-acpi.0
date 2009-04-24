From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Fri, 24 Apr 2009 11:13:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241108430.10096@localhost.localdomain>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
 <20090423164642.GF495@gamma.logic.tuwien.ac.at>
 <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
 <1240535458.3651.63.camel@localhost.localdomain>
 <alpine.LFD.2.00.0904232156040.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:8788 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbZDXPNc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 11:13:32 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIM001AW2ACKNOF@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 24 Apr 2009 10:13:25 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.0904232156040.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Norbert Preining <preining@logic.at>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, "Zhang, Rui" <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



On Thu, 23 Apr 2009, Len Brown wrote:

> On Fri, 24 Apr 2009, yakui_zhao wrote:
> 
> > On Fri, 2009-04-24 at 03:50 +0800, Len Brown wrote:
> > 
> > Hi, Len
> >     The issue can be fixed by the patch from Matthew.
> >     In Matthew's patch the acpi video is also selected when the i915 is
> > compiled as builtin-kernel module.
> >     But IMO this is not very good. From the Kconfig file we know that
> > acpi video driver depends on the following configuration:
> >     BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
> > 
> >     If the VIDEO_OUTPUT_CONTROL/BACKLIGHT_CLASS_DEVICE is not selected,
> > then it will still fail in kernel compilation.
> 
> Matthew's patch is in.
> Please send me an additional patch for the additionanl failure case.

Yakui speaks the truth, all hail Yakui:-)

"ACPI/i915: build fix" is dropped, because it fixes

    drivers/built-in.o: In function `intel_opregion_init':
    (.text+0x9d540): undefined reference to `acpi_video_register'

but in defconfig, it causes:

drivers/built-in.o: In function `acpi_video_bus_put_devices':
video.c:(.text+0x411d2): undefined reference to `video_output_unregister'
drivers/built-in.o: In function `acpi_video_bus_add':
video.c:(.text+0x42c4e): undefined reference to `video_output_register'
