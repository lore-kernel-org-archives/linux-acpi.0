From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] backlight: do not power off backlight when
	unregistering (try 2)
Date: Fri, 10 Nov 2006 10:44:40 +0000
Message-ID: <1163155480.5550.0.camel@localhost.localdomain>
References: <20061105225429.GE14295@khazad-dum.debian.net>
	 <1162773394.5473.18.camel@localhost.localdomain>
	 <20061110000829.GA9021@khazad-dum.debian.net>
	 <20061110003237.GB9021@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:35768 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1946390AbWKJKp6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Nov 2006 05:45:58 -0500
In-Reply-To: <20061110003237.GB9021@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: benh@kernel.crashing.org, paulus@samba.org, Lennart Poettering <mzxreary@0pointer.de>, Andriy Skulysh <askulysh@image.kiev.ua>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>

On Thu, 2006-11-09 at 22:32 -0200, Henrique de Moraes Holschuh wrote:
> ACPI drivers like ibm-acpi are moving to the backlight sysfs infrastructure.
> During ibm-acpi testing, I have noticed that backlight_device_unregister()
> sets the display brightness and power to zero.
> 
> This causes the display to be dimmed on ibm-acpi module removal.  It will
> affect all other ACPI drivers that are being converted to use the backlight
> class, as well.  It also affects a number of framebuffer devices that are
> used on desktops and laptops which might also not want such behaviour.
> 
> Since working around this behaviour requires undesireable hacks, Richard
> Purdie decided that we would be better off reverting the changes in the
> sysfs class, and adding the code to dim and power off the backlight device
> to the drivers that want it.  This patch is my attempt to do so.
> 
> Patch against latest linux-2.6.git.  Changes untested, as I lack the
> required hardware.  Still, they are trivial enough that, apart from typos,
> there is little chance of getting them wrong.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Andriy Skulysh <askulysh@image.kiev.ua>
> Cc: Antonino Daplas <adaplas@pol.net>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

