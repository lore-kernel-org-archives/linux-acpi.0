From: Pavel Machek <pavel@ucw.cz>
Subject: Machine no longer enters C3 on 2.6.11-rc1-bk
Date: Thu, 20 Jan 2005 11:40:33 +0100
Message-ID: <20050120104033.GA25889@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262109AbVATKmY@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

bus master activity: is changing all the time, mostly 555555555 and
aaaaaaa, and cpu refuses to enter C3 for obvious reasons. I compiled
out USB and sound... Does anybody else see the same problem?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
