From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Wed, 1 Apr 2009 15:15:13 +0200
Message-ID: <200904011515.14605.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <20090329150640.GB8500@srcf.ucam.org> <20090401130039.GD9650@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:11584
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbZDANPW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:15:22 -0400
In-Reply-To: <20090401130039.GD9650@kamineko.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wednesday 01 April 2009 15:00:39 Mattia Dongili wrote:
> On Sun, Mar 29, 2009 at 04:06:40PM +0100, Matthew Garrett wrote:
> > On Sun, Mar 29, 2009 at 01:52:42PM +0200, Matthias Welwarsky wrote:
> > > On Saturday 28 March 2009 05:31:33 you wrote:
> > > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > > >
> > > > Newer Vaios provide a full featured rfkill implementation via their
> > > > platform methods. Add support for enumerating the available devices
> > > > and providing rfkill access to them. Support for the physical kill
> > > > switch is added, with the devices moving into the HARD_BLOCKED state
> > > > when toggled.
> > >
> > > Bug: If you insert the module with hardware kill switch enabled, it
> > > cannot be disabled any more, i.e. despite operating the hardware kill
> > > switch, devices will not become enabled.
> > >
> > > Any hint how I could debug this?
> >
> > Put debug prints through the rfkill_update and rfkill_get functions? I
> > don't see anything especially obvious that would prevent this from
> > working.
>
> Matthias, any progress in debugging this?

Not yet. Not sure I'll have time to work on it for the next few days (upcoming 
easter holidays).

regards,
	matthias

