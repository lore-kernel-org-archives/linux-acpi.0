From: Thomas Renninger <trenn@suse.de>
Subject: Re: Problem with ACPI video
Date: Mon, 8 Sep 2008 02:20:10 +0200
Message-ID: <200809080220.10657.trenn@suse.de>
References: <g9n0h0$ru8$1@ger.gmane.org> <48C03A87.5050109@sapo.pt> <1220576561.24775.266.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbYIHAUq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Sep 2008 20:20:46 -0400
In-Reply-To: <1220576561.24775.266.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Luis Henriques <henrix@sapo.pt>, linux-acpi@vger.kernel.org

On Friday 05 September 2008 03:02:41 am Zhang Rui wrote:
> On Fri, 2008-09-05 at 03:44 +0800, Luis Henriques wrote:
> > Zhang Rui wrote:
> > >> It seems that acpi_video_bus_add function is invoked twice and, the
> > >> second time, it fails (maybe it is supposed to be invoked
> >
> > twice...).
> >
> > > There are two ACPI video bus devices both named "VGA" in the ACPI
> > > namespace, and each of them tries to create an entry "VGA"
> > > under /proc/acpi/video/.
> > > that's why this message is printed out.
> >
> > Sorry about my ignorance on the topic but... does this mean I do
> > actually have 2 devices?  If this is true, then I should actually have
> > "VGA1" and "VGA2" dirs in /proc, right?
>
> No, because the video driver tries to register two "VGA" procfs entry,
> we get two "VGA" dirs in /proc...
I expect Luis wants to know why there are two ACPI graphics devices
in his BIOS tables.
In most BIOSes a device for an integrated and a shared graphics solution is 
implemented in ACPI tables, read more here:
http://en.wikipedia.org/wiki/Graphics_processing_unit
(Integrated graphics solutions, or shared graphics solutions)

The reason is that it seems ACPI cannot easily check whether the graphics card 
is available at all and provide a _STA function to easily let the OS check 
that.

But you always only should have one of above devices available at a time.
The same name can be used in ACPI for different devices (in different scopes), 
which is shown by above graphics cards problem and this shows that the ACPI
proc implementation is broken by design in this respect. Anyway we always came 
away (and still do if not available dummy graphics devices are ignored, this 
is what the new patch does) with it. And sysfs will do better anyway.

The vendor could theoretically remove one implementation when the machine
is sold, but I expect it is easier for them to not do that and thus being able 
to use the same BIOS tables for models with a shared or integrated graphics
solution and let OS check which one to use.

         Thomas
