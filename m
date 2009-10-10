From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sat, 10 Oct 2009 23:25:21 +0200
Message-ID: <20091010212521.GD14051@elf.ucw.cz>
References: <4AC8F02B.6080209@suse.de>
 <200910042246.23712.rjw@sisk.pl>
 <4AC91578.2020807@suse.de>
 <ca2dc2820910041455h18ece909rc2280a40f1899c0a@mail.gmail.com>
 <4AC923F4.9050100@suse.de>
 <ca2dc2820910041653o29d4b253n69270d231e56e447@mail.gmail.com>
 <4AC93B45.8090707@suse.de>
 <ca2dc2820910061005k2beae176lece9792bb15cda90@mail.gmail.com>
 <20091010120448.GB1811@ucw.cz>
 <ca2dc2820910101353g65e4591ds82bf9fff8378abd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40010 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761652AbZJJV0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Oct 2009 17:26:04 -0400
Content-Disposition: inline
In-Reply-To: <ca2dc2820910101353g65e4591ds82bf9fff8378abd4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> >> In "broken" batteries (is it broken finally? or is it expected
> >> behaviour?) like mine the old problem will be corrected, as it was
> >> only present in the charged state.
> >
> > I believe you better work around this in userspace... or agree that
> >>100% charge is possible.
> 
> I agree that >100% charge is possible while charging (because that
> would mean the battery is over the last charged level); however, what
> does it mean when charged?

Well, maybe the battery only updates full_charge_capacity during
powerdown or when the moon is full or something? (IOW you may be
breaking already working machines).

> In any case, my laptop's battery is not charging over 100% its
> original capacity anyway, just reporting a wrong value.

True. But I do not think  you are fixing it properly. Maybe ask for
fixed BIOS?

Or perhaps add quirk based on DMI or something?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
