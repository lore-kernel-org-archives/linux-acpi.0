From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 16:22:06 -0800
Message-ID: <20070222002206.GD30444@kroah.com>
References: <1172077685.10619.101.camel@d36.suse.de> <20070222002114.GC30444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:54221 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965138AbXBVBG5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 20:06:57 -0500
Content-Disposition: inline
In-Reply-To: <20070222002114.GC30444@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Stable <Stable@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, Pavel Machek <pavel@ucw.cz>

On Wed, Feb 21, 2007 at 04:21:14PM -0800, Greg KH wrote:
> On Wed, Feb 21, 2007 at 06:08:05PM +0100, Thomas Renninger wrote:
> > Hi,
> > 
> > I like to ask for inclusion into stable series for these.
> > 
> > The original patch from Dmitry can be found here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=7689
> > comment #64, #65.
> 
> After Dmitry and you can agree on them, can you send them to us at the
> stable@ address?  Picking up patches from bugzilla isn't that easy at
> times, as there can be some confusion as to the proper patch and
> descriptions and sign-offs.

Oh nevermind, that's what I get for sending email before reading the
whole thread...

But I'll wait until Dmitry agrees that both of these patches are needed.

thanks,

greg k-h
