From: Pavel Machek <pavel@suse.cz>
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 11:18:48 +0200
Message-ID: <20060730091848.GC3801@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31142 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932110AbWG3JTo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 05:19:44 -0400
Content-Disposition: inline
In-Reply-To: <20060728134307.GD29217@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

Hi!

> > I do not understand this. Any polling (in kernel or in userspace) will
> > wake the CPU, wasting power.
> 
> The kernel, however, has all the gory details at hand, and can decide
> much better about the polling frequency, than the (hopefully) hardware
> agnostic userspace.
> 
> Imagine your Zaurus: You don't need to poll very often when you are on
> the flat part of the LiIon discharge curve, you probably want more
> detailed info near the end.

OTOH some applications just want more frequent polling than
others. Shem's "first update after N msec" solution looks most
flexible here.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
