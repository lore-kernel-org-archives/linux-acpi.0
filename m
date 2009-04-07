From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Wed, 8 Apr 2009 01:46:59 +0900
Message-ID: <20090407164659.GA3655@kamineko.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <20090329150640.GB8500@srcf.ucam.org> <20090401130039.GD9650@kamineko.org> <200904011515.14605.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:46740
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbZDGQrD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 12:47:03 -0400
Content-Disposition: inline
In-Reply-To: <200904011515.14605.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wed, Apr 01, 2009 at 03:15:13PM +0200, Matthias Welwarsky wrote:
> On Wednesday 01 April 2009 15:00:39 Mattia Dongili wrote:
> > On Sun, Mar 29, 2009 at 04:06:40PM +0100, Matthew Garrett wrote:
> > > On Sun, Mar 29, 2009 at 01:52:42PM +0200, Matthias Welwarsky wrote:
> > > > On Saturday 28 March 2009 05:31:33 you wrote:
> > > > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > >
> > > > > Newer Vaios provide a full featured rfkill implementation via their
> > > > > platform methods. Add support for enumerating the available devices
> > > > > and providing rfkill access to them. Support for the physical kill
> > > > > switch is added, with the devices moving into the HARD_BLOCKED state
> > > > > when toggled.
> > > >
> > > > Bug: If you insert the module with hardware kill switch enabled, it
> > > > cannot be disabled any more, i.e. despite operating the hardware kill
> > > > switch, devices will not become enabled.
> > > >
> > > > Any hint how I could debug this?
> > >
> > > Put debug prints through the rfkill_update and rfkill_get functions? I
> > > don't see anything especially obvious that would prevent this from
> > > working.
> >
> > Matthias, any progress in debugging this?
> 
> Not yet. Not sure I'll have time to work on it for the next few days (upcoming 
> easter holidays).

I got my hands on a "new style" vaio and reproduced the problem. What
happens is that when loading the driver with the kill switch on and then
turning it on the status reading call to the 0x124 handle returns a soft
blocked state.
Just echoing 1 into the appropriate sysfs rfkill files turns the devices
on.

In short we should make sure that if the device was never turned on
since loading, then the switch being turned off really means "turn it
off!".
I'll prepare a patch tomorrow.
-- 
mattia
:wq!
