From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is
	serving this functionality
Date: Mon, 17 Nov 2008 00:07:54 -0200
Message-ID: <20081117020754.GC22260@khazad-dum.debian.net>
References: <200811081637.45099.arvidjaar@mail.ru> <20081115184900.GA10685@srcf.ucam.org> <20081116125114.GB29981@khazad-dum.debian.net> <200811161544.56367.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50235 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754601AbYKQCIA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 21:08:00 -0500
Content-Disposition: inline
In-Reply-To: <200811161544.56367.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sun, 16 Nov 2008, Thomas Renninger wrote:
> I would not add such complexity for a problem which isn't a real problem.

Oh, it is very real.  It needs to be solved, and yes, it can be solved with
what we have and adding blacklists to ACPI video, instead of intelligent
decisions or hints from the platform driver.

> IMO we should either:
>    1) Just do nothing and use video.ko even for Toshibas which only provide
>        3 brightness states.

I would be quite annoyed at it if I were a Toshiba user and I would report
it as a regression.  But I guess we can see if any Toshiba users want to
chime in?

>    2) DMI blacklist for Toshiba in general to use toshiba_laptop for
>        brightness switching.

You won't get away with halfway broken measures like that, you will need to
blacklist *some* toshibas, but not all.  As you say yourself later on, it is
likely that newer ones might switch to ACPI generic, or have more levels in
ACPI generic backlight handling.

> For the brightness level it's something else. A short documentation into the 
> right forum/mailing list and everybody can google the 
> acpi_backlight=vendor/video boot param in a second on his already running 
> machine and is happy.

I thought we were trying to get things right automatically instead of
forcing users to add such parameters, nowadays?  Maybe if this was something
easy to change at runtime, but kernel parameters and Kconfig parameters
*are* supposed to be a last-resort option.

> The question is, are these 3 brightness levels to be considered as broken.

It is a regression, anyway.  It delivers reduced functionality.

> IMO it is something 95% of all toshiba users won't care, the brightness level 

But we care about the 5% that do.  Those are the users that are worth
bothering with, since they're the ones that do bug reports, stay around to
test patches, etc.

> I very much expect that newer Toshibas export more brightness levels via 
> video.ko (does someone have a new one and can double check?) and at some time 
> the Toshiba specific functions may even vanish. Therefore I would prefer to 
> not do an exception here and go for 1(see above).

I don't really care if it is done just by DMI blacklisting on ACPI video,
but I don't expect that to be the better solution for the long term.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
