From: Thomas Renninger <trenn@suse.de>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sun, 3 Aug 2008 18:24:05 +0200
Message-ID: <200808031824.06670.trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo> <200808031531.54725.trenn@suse.de> <20080803141231.GA14272@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:45806 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421AbYHCQWh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Aug 2008 12:22:37 -0400
In-Reply-To: <20080803141231.GA14272@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Sunday 03 August 2008 04:12:31 pm Matthew Garrett wrote:
> On Sun, Aug 03, 2008 at 03:31:53PM +0200, Thomas Renninger wrote:
> > This is even worse, because that means that Lenovo and everyone
> > else who has to add Windows hotfixes to their BIOS and potentially
> > have to break their Linux supported OS by that cannot guarantee
> > their customers full Linux support (without providing a separate
> > Linux BIOS).
>
> That's fine. Where we diverge from the Windows behaviour we already have
> a bug.

Yes.
I take above statement back.
This Windows behaviour very much de-escalates the situation.

If Windows sticks to this then there is no urgent need for OSI(notWindows)
or OSI(Linux).

Thanks for pointing this out.

       Thomas
