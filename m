From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: brightness control on thinkpad t61p
Date: Wed, 26 Dec 2007 14:10:34 -0800
Message-ID: <20071226141034.959746a9.akpm@linux-foundation.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org>
	<20071224170837.GC7907@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58383 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643AbXLZWLS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Dec 2007 17:11:18 -0500
In-Reply-To: <20071224170837.GC7907@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 24 Dec 2007 15:08:37 -0200 Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Sun, 23 Dec 2007, Andrew Morton wrote:
> > When I fire up the latest Linus tree on my thinkpad t61p I get:
> > 
> > thinkpad_acpi: ThinkPad ACPI Extras v0.17
> > thinkpad_acpi: http://ibm-acpi.sf.net/
> > thinkpad_acpi: ThinkPad BIOS 7LET44WW (1.14 ), EC 7KHT22WW-1.06
> > thinkpad_acpi: Lenovo ThinkPad T61p
> > thinkpad_acpi: radio switch found; radios are enabled
> > ACPI: Lid Switch [LID]
> > input: Sleep Button (CM) as /class/input/input6
> > ACPI: Sleep Button (CM) [SLPB]
> > thinkpad_acpi: standard ACPI backlight interface available, not loading native one...
> > 
> > and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> > my `brightness' script no longer works.  That, my friends, is a regression.
> 
> For thinkpad-acpi at least, it is not a regression. 2.6.23/0.16 did NOT
> support your thinkpad (it will pretend to work, but it won't work 100% right
> as it only supports 8 levels of backlight control).

Well it may have been partially working, but it worked.

>  2.6.24-rc4/0.17 added
> support for it (16-level brightness), but also added the automatic detection
> of ACPI generic video support.

Doesn't work.

> You can ask thinkpad-acpi for the backlight interface using the
> "brightness_enable=1" parameter, if you'd rather use it instead of the
> generic ACPI video driver.  I don't know if you can ask video to not enable
> backlight control, though.

I shouldn't have to add some module parameter to get previously-working
stuff to work again.

> > So I go hunting around and find
> > 
> > 	/sys/class/backlight/acpi_video0/
> > and
> > 	/sys/class/backlight/acpi_video1/
> > 
> > Why are there two of them?
> 
> Two nodes in the ACPI tree (AGP and PCI), and the ACPI drivers don't
> differentiate a deactivated node from a working node yet.  There are some
> tentative patches flying around to fix it, AFAIK.
> 
> > Both of these have a `brightness' entry which has contents of 100.  When I set
> > that to 10, the screen's brightness is not reduced.
> 
> One of them should work.  Maybe X.org is doing something?

Dunno.
