From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 20:30:30 +0100
Message-ID: <200801052030.30862.rjw@sisk.pl>
References: <20080104144238.GA5176@zoy.org> <200801051926.33641.rjw@sisk.pl> <20080105185946.GA24267@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57384 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756331AbYAET2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 14:28:10 -0500
In-Reply-To: <20080105185946.GA24267@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Michel Lespinasse <walken@zoy.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Saturday, 5 of January 2008, Matthew Garrett wrote:
> On Sat, Jan 05, 2008 at 07:26:33PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, 5 of January 2008, Michel Lespinasse wrote:
> > > The patch did not work as you sent it, but doing the same in acpi_pm_open()
> > > (i.e. forcing it to execute the revision<3 code) worked.
> > > I'm now doing a happy dance :)
> > > 
> > > So what now, do you need some kind of signature for the system ?
> > > (I realize that would probably be some kind of DMI string,
> > > but I'm not sure where/how to obtain it)
> > 
> > Well, I think I'd rather want to introduce a boot parameter for that.  Stay
> > tuned.
> 
> Surely this implies that the only behaviour tested (and, so, presumably 
> the only behaviour implemented in Windows) is the 1.0-style flow? If so, 
> we should just default to that regardless of what the spec says.

Yes, but we have quite a lot of systems working with the current code, so
I'd like to give them a chance to use the post-1.0 ordering (just in case).

Thanks,
Rafael
