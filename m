From: Pavel Machek <pavel@ucw.cz>
Subject: Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
Date: Wed, 20 Oct 2004 21:15:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041020191531.GC21315@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269994AbUJTTTD@vger.kernel.org>
Content-Disposition: inline
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

I'm seeing bad problem with N620c notebook (and have reports of more
machines behaving like this, for example ASUS L8400C.) If I shutdown
machine with lid closed, opening lid will power the machine up. Ouch.
2.6.7 behaves okay.

Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
strange show on the leds (battery charge led blinks fast?!), then
machine powers up itself. This happens even with lid initially
open. 2.6.7 works as expected.

Any ideas?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
