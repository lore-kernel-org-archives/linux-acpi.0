From: Pavel Machek <pavel@suse.cz>
Subject: Re: Generic battery interface
Date: Thu, 3 Aug 2006 18:33:11 +0200
Message-ID: <20060803163311.GA11389@elf.ucw.cz>
References: <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com> <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com> <20060731233536.92b39035.khali@linux-fr.org> <20060731230145.GF3612@elf.ucw.cz> <20060802091841.8585a72a.khali@linux-fr.org> <1154604546.4302.482.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964839AbWHCQdn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1154604546.4302.482.camel@queen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@debian.org>, Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> One should also not rely on the warning/low capacity values.
> I cannot say for sure whether all machines throw an event if these
> limits are reached. We defined our own limits in userspace, this always
> works. I'd go for not using the BIOS limits here at all and take user
> defined capacity warning/low values (in percent) in hal or wherever.

Well, this works okay for normal machines, but... there are strange
machines around.

If you have 10 hours of battery life (zaurus sl-5500) and hardcode
warning to 10% of battery remainin... well you'll warn with 1 hour to
go.

Okay, this probably is not an issue on most notebooks today...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
