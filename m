From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 10:06:53 -0200
Message-ID: <20080108120653.GA23216@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59036 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbYAHMG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 07:06:58 -0500
Content-Disposition: inline
In-Reply-To: <20080108004559.GA27177@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, 08 Jan 2008, Matthew Garrett wrote:
> On Mon, Jan 07, 2008 at 10:32:46PM -0200, Henrique de Moraes Holschuh wrote:
> 
> > Should we?  Why?  We lose information doing that.  Instead of a nice linear
> > 0-100% brightness scale, you are now back to an 8 or 16-level non-linear
> > brightness scale.
> 
> The spec makes no guarantees about what that 0-100 range means - it may 
> be brightness, power consumption or bonghits. It's really not guaranteed 
> to be meaningful, and the backlight class doesn't provide that guarantee 
> either.

True.  But it is still a step backwards for firmware that do better.

And, frankly, the backlight class is so spartan, I don't consider missing
features in it anything but a "time to fix it" issue.  It is just like the
LED class, it is too spartan to actually do all we need it to in some cases.

Is there a *real* technical reason why we can't just round to the nearest?
That will work well with any firmware, and it will not remove functionality
from any box, while at the same time plugging the current issues nicely.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
