From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Wed, 23 May 2007 10:57:47 +0200
Message-ID: <200705231057.48320.rjw@sisk.pl>
References: <20070519165738.GK11115@waste.org> <20070523001943.GA3743@khazad-dum.debian.net> <20070523014825.GX11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60335 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756488AbXEWIwa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 04:52:30 -0400
In-Reply-To: <20070523014825.GX11115@waste.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Wednesday, 23 May 2007 03:48, Matt Mackall wrote:
> On Tue, May 22, 2007 at 09:19:43PM -0300, Henrique de Moraes Holschuh wrote:
> > On Tue, 22 May 2007, Matt Mackall wrote:
> > > On Mon, May 21, 2007 at 08:03:49PM -0300, Henrique de Moraes Holschuh wrote:
> > > > On Mon, 21 May 2007, Matt Mackall wrote:
> > > > > BIOS Information
> > > > >         Vendor: IBM
> > > > >         Version: 1RETDHWW (3.13 )
> > > > >         Release Date: 10/29/2004
> > > > > 
> > > > > No sign of any EC version in the output.
> > > > 
> > > > This is a buggy, ancient version of the BIOS, which probably means you have
> > > > an old and slightly buggy EC firmware.  I recommend you to upgrade to BIOS
> > > > 3.21 and EC 3.04.  See http://thinkwiki.org/wiki/BIOS_Upgrade for more
> > > > details.
> > > 
> > > Really, I'd much prefer my kernel not regress instead. Updating
> > > firmware is just introducing more potential instability and ignoring
> > > the problem.
> > 
> > We can't very much know if the kernel is really buggy, then.
> 
> Whether the 'bug' is in the firmware or the kernel, it is the kernel
> that has regressed. Suspend worked fine for 2+ years before this.
> 
> Breaking working systems, either software or hardware, is a bad idea.
> I shouldn't have to upgrade my BIOS to work with a new kernel any more
> than I should have to upgrade my browser.

While I agree with that, it would really be helpful if you tested the latest -rc
kernel and saw if the bug was present in there.

If the bug is not present in the latest -rc, it'll be possible to identify the
patch that causes it to appear in -mm and find the reason of the breakage.

Greetings,
Rafael
