From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Mon, 24 Dec 2007 15:14:05 -0200
Message-ID: <20071224171405.GD7907@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36131 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272AbXLXROL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Dec 2007 12:14:11 -0500
Content-Disposition: inline
In-Reply-To: <20071224073406.GA1018@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 24 Dec 2007, Matthew Garrett wrote:
> On Sun, Dec 23, 2007 at 12:00:57AM -0800, Andrew Morton wrote:
> 
> > and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> > my `brightness' script no longer works.  That, my friends, is a regression.
> 
> The thinkpad_acpi brightness interface simply doesn't work correctly on 
> recent Thinkpads. The ACPI interface does, but the currently exported ui 

Yes, it does since 2.6.24-rc4.  And since MUCH earlier in the out-of-tree
develompent versions.

What usually causes weird breakage is to have more than one of (Ubuntu
hackage in HAL calling back into thinkpad-acpi, X.org, ACPI video) trying to
respond to brightness up/down.  And you *do* *have* to use the latest Lenovo
BIOSes, too. 

Also, apparently now X.org knows how to tell the BIOS to not react to
backlight changes, so you have to configure it properly (I don't know much
about it), too.

Matthew, btw, Dmitri approved the _NOTIFY keycodes, which need to be part of
the solution re. backlight control in thinkpads.  Are you intending to push
a patch implementing them?  As I said before, I am okay with that solution,
as long as Dmitri accepted it, and I will use _NOTIFY keycodes in
thinkpad-acpi when they become available.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
