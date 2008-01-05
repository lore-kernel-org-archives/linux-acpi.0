From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 20:48:26 +0100
Message-ID: <200801052048.27025.rjw@sisk.pl>
References: <20080104144238.GA5176@zoy.org> <200801052030.30862.rjw@sisk.pl> <20080105193552.GB24267@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57490 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330AbYAETq0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 14:46:26 -0500
In-Reply-To: <20080105193552.GB24267@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Michel Lespinasse <walken@zoy.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Saturday, 5 of January 2008, Matthew Garrett wrote:
> On Sat, Jan 05, 2008 at 08:30:30PM +0100, Rafael J. Wysocki wrote:
> 
> > Yes, but we have quite a lot of systems working with the current code, so
> > I'd like to give them a chance to use the post-1.0 ordering (just in case).

Just to clarify: I'm going to change the default to the pre-2.0 ordering and
add a boot option for switching the post-1.0 ordering.

> If the vast majority of systems have never been vendor-tested with the 
> alternative ordering, then I don't see what it buys us.

1. Possibility to test the alternative ordering without hacking and recompiling
   the kernel.
2. Compatibility with future systems that will use the new odering.

> We've a demonstrable case here of it causing a regression.

Correct, but if the default is changed, I don't see a problem with leaving an
option to do that.

Thanks,
Rafael
