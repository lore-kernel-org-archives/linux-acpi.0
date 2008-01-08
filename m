From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Tue, 8 Jan 2008 10:48:20 -0200
Message-ID: <20080108124820.GB23216@khazad-dum.debian.net>
References: <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org> <20080108003246.GA15587@khazad-dum.debian.net> <20080108004559.GA27177@srcf.ucam.org> <20080108120653.GA23216@khazad-dum.debian.net> <20080108121819.GA1324@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57586 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757720AbYAHPDo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 10:03:44 -0500
Content-Disposition: inline
In-Reply-To: <20080108121819.GA1324@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Richard Purdie <rpurdie@rpsys.net>

On Tue, 08 Jan 2008, Matthew Garrett wrote:
> On Tue, Jan 08, 2008 at 10:06:53AM -0200, Henrique de Moraes Holschuh wrote:
> > Is there a *real* technical reason why we can't just round to the nearest?
> > That will work well with any firmware, and it will not remove functionality
> > from any box, while at the same time plugging the current issues nicely.
> 
> Yes. Software makes the assumption that writing a value larger than the 
> current value will result in the value increasing, which isn't 
> necessarily true if you round it.

I dare say that such an assumption is broken for the backlight class, there
is a reason why we have actual_brightness and brightness separate, and it is
just that one AFAIK.  I am cc'ing the backlight class maintainer to get his
opinion on the matter.

That doesn't mean we shouldn't improve the backlight class to give it
something like _BCL does as an *optional* attribute (but with extra explicit
guarantees, such as the one that it will list values sorted from lowest to
highest, etc), but it does mean that anything assuming that adding one to a
brightness level in the backlight class will INCREASE brightness is just
plain *broken*.  If actual_brightness did not change, then the backlight
brightness level did not change either.

Heck, back to the video.c driver, you shouldn't even assume _BCL gives you a
sorted list after the second element.  I admit it takes an special kind of
weird firmware to screw with _BCL like that, but the ACPI spec doesn't
mandate it, it just says that the OSPM will cycle through the values
returned by _BCL, but nowhere does it define HOW one cycles through those...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
