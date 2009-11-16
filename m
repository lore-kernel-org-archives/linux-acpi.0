From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Mon, 16 Nov 2009 23:26:06 +0100
Message-ID: <200911162326.06261.rjw@sisk.pl>
References: <200911112324.58076.rjw@sisk.pl> <20091112165958.GA9389@srcf.ucam.org> <200911162226.02569.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60033 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbZKPWYo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Nov 2009 17:24:44 -0500
In-Reply-To: <200911162226.02569.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Monday 16 November 2009, Oliver Neukum wrote:
> Am Donnerstag, 12. November 2009 17:59:58 schrieb Matthew Garrett:
> > On Thu, Nov 12, 2009 at 06:00:02PM +0100, Oliver Neukum wrote:
> > > Exactly, but that isn't the same as needing two attributes exported to
> > > user space. That is an absolute requirement only if we can't tell what a
> > > device's capabilities are.
> > 
> > Right. I don't see any reason for runtime wakeup to be exposed to 
> > userspace - it's an entirely orthogonal concept to system wakeup. The 
> > relevant userspace policy is whether or not runtime pm is enabled.
> 
> That brings me to a possibly useless, wild idea. Do we want to tristate
> this? Is there any use in a "don't care" setting?

I'm not sure what the "don't care" value would be useful for.

Besides, I don't really like tristates. :-)

Thanks,
Rafael
