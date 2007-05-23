From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Tue, 22 May 2007 21:19:43 -0300
Message-ID: <20070523001943.GA3743@khazad-dum.debian.net>
References: <20070519165738.GK11115@waste.org> <20070519204504.GA24704@khazad-dum.debian.net> <20070519223843.GN11115@waste.org> <20070520035259.GA13224@khazad-dum.debian.net> <20070521222339.GF11115@waste.org> <20070521230349.GA645@khazad-dum.debian.net> <20070522224515.GW11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43027 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965941AbXEWATy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 20:19:54 -0400
Content-Disposition: inline
In-Reply-To: <20070522224515.GW11115@waste.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Tue, 22 May 2007, Matt Mackall wrote:
> On Mon, May 21, 2007 at 08:03:49PM -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 21 May 2007, Matt Mackall wrote:
> > > BIOS Information
> > >         Vendor: IBM
> > >         Version: 1RETDHWW (3.13 )
> > >         Release Date: 10/29/2004
> > > 
> > > No sign of any EC version in the output.
> > 
> > This is a buggy, ancient version of the BIOS, which probably means you have
> > an old and slightly buggy EC firmware.  I recommend you to upgrade to BIOS
> > 3.21 and EC 3.04.  See http://thinkwiki.org/wiki/BIOS_Upgrade for more
> > details.
> 
> Really, I'd much prefer my kernel not regress instead. Updating
> firmware is just introducing more potential instability and ignoring
> the problem.

We can't very much know if the kernel is really buggy, then.  I'd say we
need a report from someone with another thinkpad that uses the 1R BIOS that
has an up-to-date BIOS, to know for sure.  Since that includes the T41 and
T42, chances are others would have spoken up about it already if it affected
the more recent versions of the 1R BIOS.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
