From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Date: Thu, 9 Nov 2006 22:08:30 -0200
Message-ID: <20061110000829.GA9021@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net> <1162773394.5473.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42149 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1424259AbWKJAIn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Nov 2006 19:08:43 -0500
Content-Disposition: inline
In-Reply-To: <1162773394.5473.18.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>, benh@kernel.crashing.org, paulus@samba.org, Lennart Poettering <mzxreary@0pointer.de>, Andriy Skulysh <askulysh@image.kiev.ua>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>

On Mon, 06 Nov 2006, Richard Purdie wrote:
> Those commits were designed to standardise several behaviours amongst
> several drivers and this specific case was added to the core rather than
> coding it in each of several drivers. We therefore really need to update
> those other drivers too (locomo at the very least).

The following in-tree drivers need changes:
drivers/video/backlight/locomolcd.c
drivers/video/backlight/hp680_bl.c
drivers/video/backlight/corgi_bl.c

I will repost the patch with locomolcd.c and hp680_bl.c included.

The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
devices and likely do not want the "dim and power off backlight on
backlight_device_unregister" behavior:

drivers/video/aty/*
drivers/video/riva/fbdev.c
drivers/video/nvidia/nv_backlight.c
drivers/misc/msi-laptop.c

The ACPI drivers being converted to backlight sysfs are very unlikely to
want the "power off backlight on backlight_device_unregister" behavior, so I
have not hunted after backlight sysfs conversions in the linux-acpi-2.6 git
tree.  Still, linux-acpi is cc'ed.

I have CC'ed the relevant people (please forgive me any ommissions) for the
drivers listed above, so they can chime in if their driver should retain the
"dim and power off backlight on backlight_device_unregister" behaviour.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
