From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Mon, 7 Jan 2008 22:32:46 -0200
Message-ID: <20080108003246.GA15587@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net> <20080107013623.GA6667@khazad-dum.debian.net> <20080107194833.GA22506@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52573 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850AbYAHAcv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jan 2008 19:32:51 -0500
Content-Disposition: inline
In-Reply-To: <20080107194833.GA22506@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 07 Jan 2008, Matthew Garrett wrote:
> On Sun, Jan 06, 2008 at 11:36:23PM -0200, Henrique de Moraes Holschuh wrote:
> > Bah, I spoke too soon.  Latest round of BIOSes seems to have broken this,
> > either that or I completely misunderstood the older AML code.
> > 
> > Rounding to the nearest supplied _BCL value before we call _BCM apparently
> > will be needed on thinkpads as well.
> 
> We should just stop exposing the 0-100 range, and instead map it into a 
> contiguous (smaller) range. I've posted a patch to do that.

Should we?  Why?  We lose information doing that.  Instead of a nice linear
0-100% brightness scale, you are now back to an 8 or 16-level non-linear
brightness scale.

0 to 100% is hardware agnostic.  You know where the middle backlight level
is.  You know where the one quarter, and three quarter levels are.  You
don't know anything about the brightness level anymore, after you compress
it to an array index.

It is a step backwards IMHO.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
