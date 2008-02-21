From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 12:55:00 -0300
Message-ID: <20080221155500.GB5859@khazad-dum.debian.net>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <1203571913.3764.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55826 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932565AbYBUPzF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 10:55:05 -0500
Content-Disposition: inline
In-Reply-To: <1203571913.3764.19.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, 21 Feb 2008, Sergio Monteiro Basto wrote:
> On Thu, 2008-02-21 at 00:13 -0300, Henrique de Moraes Holschuh wrote:
> > On Wed, 20 Feb 2008, Matthew Garrett wrote:
> > > It doesn't punish them. They're the ones who are going to work with us 
> > > to ensure that Linux works on their hardware, and their needs are going 
> > 
> > And since when we have to work exactly like Windows (whatever version) does
> > in THAT case?
> > 
> > Also, why would one thing (proper replacement for OSI(Linux)) cause any sort
> > of difference over the other (trying to be bug-to-bug compatible with
> > Microsoft crap).
> > 
> 
> I agree with Henrique. Since we have, in fact, more Windows cases than
> Linux cases and for Linux, just announce that  is recommended,
> osi=linux. 

EH? I am *against* osi=Linux.  I am for a proper *replacement* for
OSI=Linux, *and* trying to be Windows-compatible where possible.

> Also it is possible put Linuxs bios in a kind of white-list in kernel
> code ...

Linux-BIOS boxes *really* should not need ACPI for anything other than the
very basic stuff, at all.  Nor should them implement SMM handling, or any
other such crap that always bite us back in the nether regions, with
poisoined teeth.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
