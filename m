From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
 generate events on changes
Date: Tue, 14 Jul 2009 12:54:09 -0300
Message-ID: <20090714155409.GA31991@khazad-dum.debian.net>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
 <20090714103006.GA19866@khazad-dum.debian.net>
 <20090714132152.GA22521@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46363 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800AbZGNPyP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jul 2009 11:54:15 -0400
Content-Disposition: inline
In-Reply-To: <20090714132152.GA22521@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Tue, 14 Jul 2009, Matthew Garrett wrote:
> On Tue, Jul 14, 2009 at 07:30:07AM -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 13 Jul 2009, Matthew Garrett wrote:
> > > Certain hardware will send us events when the backlight brightness
> > > changes. Add a function to update the value in the core, and
> > > additionally send a uevent so that userspace can pop up appropriate
> > > UI. The uevents are flagged depending on whether the update originated
> > > in the kernel or from userspace, making it easier to only display UI
> > > at the appropriate time.
> > 
> > Any reasons to not do it using poll() support (since sysfs has it)?  Or at
> > least, do both poll and uevents?
> 
> More code? It doesn't really seem necessary.

Well, we all know just how marvelously engineered and high-bandwidth the
uevent+udev+everything else channel is, don't we?

Adding the poll() notification is not expensive, one line to do it, plus a
few more to find out the exact sysfs node that needs to receive the
notification (hideous API, that).

> > Other than that, I like the idea a lot.  thinkpad-acpi will use this event
> > support.
> 
> Good, that's one of the use-cases I wanted to deal with - but the hotkey 
> mask stuff is complicated enough that I hadn't got round to touching 
> that yet. The combination of this and the ALSA mixer code should get us 
> full notification.

Leave it to me.  Even if it arrives a bit later than the main patch, it
won't cause problems for the merging of the main work anyway, and as you
said, it *IS* hairy code to do it right and it plugs right in the middle of
the more confusing parts of thinkpad-acpi.  I will do it in a way that makes
the whole thing also usable for the mixer notifications.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
