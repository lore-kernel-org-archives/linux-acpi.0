From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Tue, 17 Apr 2007 12:53:02 -0700
Message-ID: <200704171253.02748.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <200704071308.07571.david-b@pacbell.net> <20070413155949.GA9157@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:34222 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161115AbXDQTxH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 15:53:07 -0400
In-Reply-To: <20070413155949.GA9157@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Friday 13 April 2007 8:59 am, Pavel Machek wrote:
> Hi!
> 
> > > Are you _sure_ you have a 1-to-1 relationship here?  No multiple devices
> > > pointing to the same acpi node?  Or the other way around?  If so, you
> > > are going to have to change the name to be something more unique.
> > 
> > I've wondered that too.  The short answer:  APCI only supports 1-1
> > here.  It will emit warnings if it tries to bind more than one ACPI

(Clarifying:  the ACPI *code* works that way.  I have no idea whether
ACPI itself makes such restrictions.  And I suspect that ACPI practice
will in some cases couple multiple ACPI devices to one PCI device...)


> ...
> > Assuming they all adopt that same "parallel tree" model, that seems
> > like a good idea.  The tools will likely need to understand how ACPI
> > and OF differ, but there's no point in reserving more names than we
> > really need.  Though it may be that "parallel trees" should go away.
> 
> If mapping is indeed 1-to-1 in acpi... it would be nice to just merge
> the trees.

Could you elaborate a bit ... what do you mean by "merge"?

One way to merge the trees would be to relocate

	/sys/devices/pci* --> ... this *HAS* a PNP node
	/sys/devices/pnp*/X --> /sys/devices/acpi_system*/.../X

Not having the PCI root be its PNPACPI node seems more buglike
to me than anything else.  And for other nodes, it seems like
maybe there should be a "firmware" subdirectory holding the
ACPI state (hid, path, etc) ... creating a minor chicken/egg
problem that ACPI would need to sort out.  Likely one can just
assume PCI and PNP busses exist, so creating nodes on those
buses based on ACPI tables would not be a problem.  And for
ACPI-internal devices, like SLPB and power buttons, the ACPI
bus would suffice.  But are there other busses?

- Dave
