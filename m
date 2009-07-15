From: Pavel Machek <pavel@ucw.cz>
Subject: [regression] Re: 2.6.31-rc2: thinkpad boots with backlight low
Date: Wed, 15 Jul 2009 15:13:52 +0200
Message-ID: <20090715131351.GA2367@elf.ucw.cz>
References: <20090714092513.GB2010@elf.ucw.cz> <20090714104712.GB19866@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36466 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZGONN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 09:13:57 -0400
Content-Disposition: inline
In-Reply-To: <20090714104712.GB19866@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue 2009-07-14 07:47:12, Henrique de Moraes Holschuh wrote:
> On Tue, 14 Jul 2009, Pavel Machek wrote:
> > Subject pretty much said it all. Normally, backlight level is kept from
> > previous boot. ... which is unfortunately not the case with
> > 2.6.31-rc2. Thinkpad x60.
> 
> What is controlling the backlight? ACPI video or thinkpad-acpi ?

sh-3.2$ grep -i VIDEO .config
CONFIG_ACPI_VIDEO=y

...so I think it is ACPI video.

sh-3.2$ grep -i THINK .config
CONFIG_THINKPAD_ACPI=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_BAY=y
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
sh-3.2$ 

...and yes, I think it only happens on reboot.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
