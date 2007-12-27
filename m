From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Thu, 27 Dec 2007 11:15:48 -0200
Message-ID: <20071227131548.GC25535@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224170837.GC7907@khazad-dum.debian.net> <20071226141034.959746a9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48635 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbXL0NPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 08:15:53 -0500
Content-Disposition: inline
In-Reply-To: <20071226141034.959746a9.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 26 Dec 2007, Andrew Morton wrote:
> > For thinkpad-acpi at least, it is not a regression. 2.6.23/0.16 did NOT
> > support your thinkpad (it will pretend to work, but it won't work 100% right
> > as it only supports 8 levels of backlight control).
> 
> Well it may have been partially working, but it worked.

See below...

> >  2.6.24-rc4/0.17 added
> > support for it (16-level brightness), but also added the automatic detection
> > of ACPI generic video support.
> 
> Doesn't work.

Needs fixing, then.  THAT is the way to go in the future, including for
thinkpads.

> > You can ask thinkpad-acpi for the backlight interface using the
> > "brightness_enable=1" parameter, if you'd rather use it instead of the
> > generic ACPI video driver.  I don't know if you can ask video to not enable
> > backlight control, though.
> 
> I shouldn't have to add some module parameter to get previously-working
> stuff to work again.

It was not working properly, and it was unsupported.  Things that work
half-way by accident are NOT considered to be supported in my book.

While I don't mind at all to leave it enabled when there are other drivers
also taking care of brightness, I am afraid it will cause an even worse
mess, since ACPI video will attempt to control the backlight level as
well.  So, I have disabled the thinkpad-specific interface when the presence
of the generic interface (driven by ACPI video) is detected.

> > > Both of these have a `brightness' entry which has contents of 100.
> > > When I set that to 10, the screen's brightness is not reduced.
> > 
> > One of them should work.  Maybe X.org is doing something?
> 
> Dunno.

Really up-to-date X.org can completely disable the BIOS backlight handling
by changing some registers in the GPUs, at least for Radeons (and probably
Intel GPUs).  I believe there are ways to control it through xbacklight
options, but I don't have that X.org yet, so I can't tell what to try.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
