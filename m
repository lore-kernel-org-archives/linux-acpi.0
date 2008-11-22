From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Sat, 22 Nov 2008 13:56:07 +0100
Message-ID: <200811221356.08294.rjw@sisk.pl>
References: <200810142254.07024.rjw@sisk.pl> <200810152320.06167.rjw@sisk.pl> <200811221111.50952.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36901 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbYKVM4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 07:56:54 -0500
In-Reply-To: <200811221111.50952.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John Brown <john.brown3@hp.com>

On Saturday, 22 of November 2008, Carlos Corbacho wrote:
> On Wednesday 15 October 2008 22:20:05 Rafael J. Wysocki wrote:
> > > > IOW, we aren't doing anything wrong and the BIOS is buggy.
> > >
> > > So how does Windows cope with this?
> >
> > I don't know. :-(
> >
> > One possible explanation is that the device causing the trouble is not put
> > into D3 at all during suspend, but I'm speculating here.
> 
> Do we know which device it is that causes the trouble on this HP box?

Not really, but most probably is one of the USB controllers.  Hopefully, we'll
find out.

Thanks,
Rafael
