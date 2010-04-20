From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Low-Level and Long-Term Battery Control
Date: Tue, 20 Apr 2010 15:37:24 +0200
Message-ID: <20100420133724.GD8670@ucw.cz>
References: <w2r45cc95261004130535y80da503ev5389bb4a97bdd58f@mail.gmail.com>
 <4BCBDCA1.9030500@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:52959 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751574Ab0DTNhh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Apr 2010 09:37:37 -0400
Content-Disposition: inline
In-Reply-To: <4BCBDCA1.9030500@myrealbox.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> >Is there any function in the Linux kernel that control the
> >charging/discharging of the battery to provide better lifespan ?
> >(add some years to its life ?)
> >
> >For Laptops, it is better to extract the battery from the Laptop when
> >the computer will be on power for a long period.
> >I ask if the kernel can do such control without the user intention and
> >in an automatic way.
> >
> >Some BIOS provide to the user to select whether to block the battery
> >charging to 50% to make it stand for more time.
> >And Many people (like me) forget their laptops on power until the
> >battery no more can hold energy after 2minutes of no power.
> >
> 
> On ThinkPads, tp_smapi (not in the kernel.org kernel) can do it.
> I'd like to see this feature standardized in sysfs.

Yep, it does, and it would make sense to make it standardized. (But I
don't think setting it as low as 50% is practical -- nor do I think
anyone sets it this low).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
