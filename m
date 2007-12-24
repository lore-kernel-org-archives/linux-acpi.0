From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Mon, 24 Dec 2007 15:08:37 -0200
Message-ID: <20071224170837.GC7907@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59668 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966AbXLXRIp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Dec 2007 12:08:45 -0500
Content-Disposition: inline
In-Reply-To: <20071223000057.739d5891.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, 23 Dec 2007, Andrew Morton wrote:
> When I fire up the latest Linus tree on my thinkpad t61p I get:
> 
> thinkpad_acpi: ThinkPad ACPI Extras v0.17
> thinkpad_acpi: http://ibm-acpi.sf.net/
> thinkpad_acpi: ThinkPad BIOS 7LET44WW (1.14 ), EC 7KHT22WW-1.06
> thinkpad_acpi: Lenovo ThinkPad T61p
> thinkpad_acpi: radio switch found; radios are enabled
> ACPI: Lid Switch [LID]
> input: Sleep Button (CM) as /class/input/input6
> ACPI: Sleep Button (CM) [SLPB]
> thinkpad_acpi: standard ACPI backlight interface available, not loading native one...
> 
> and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> my `brightness' script no longer works.  That, my friends, is a regression.

For thinkpad-acpi at least, it is not a regression. 2.6.23/0.16 did NOT
support your thinkpad (it will pretend to work, but it won't work 100% right
as it only supports 8 levels of backlight control).  2.6.24-rc4/0.17 added
support for it (16-level brightness), but also added the automatic detection
of ACPI generic video support.

You can ask thinkpad-acpi for the backlight interface using the
"brightness_enable=1" parameter, if you'd rather use it instead of the
generic ACPI video driver.  I don't know if you can ask video to not enable
backlight control, though.

> So I go hunting around and find
> 
> 	/sys/class/backlight/acpi_video0/
> and
> 	/sys/class/backlight/acpi_video1/
> 
> Why are there two of them?

Two nodes in the ACPI tree (AGP and PCI), and the ACPI drivers don't
differentiate a deactivated node from a working node yet.  There are some
tentative patches flying around to fix it, AFAIK.

> Both of these have a `brightness' entry which has contents of 100.  When I set
> that to 10, the screen's brightness is not reduced.

One of them should work.  Maybe X.org is doing something?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
