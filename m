From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sun, 13 Jul 2008 11:15:24 +0200
Message-ID: <20080713091524.GA29907@elte.hu>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl> <48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:42915 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbYGMJQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jul 2008 05:16:08 -0400
Content-Disposition: inline
In-Reply-To: <200807130133.12324.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > Bingo.  It's a HAL quirk.
> > 
> > Testing from the console (not X):
> > 
> > With 4b4f7280:
> > # echo mem >/sys/power/state -- works fine
> > 
> > # echo 3 >/proc/sys/kernel/acpi_video_flags
> > # echo mem >/sys/power state -- fails to resume
> > 
> > Without 4b4f7280:
> > # echo mem >/sys/power/state -- works fine
> > 
> > # echo 3 >/proc/sys/kernel/acpi_video_flags
> > # echo mem >/sys/power state -- works fine
> > 
> > So HAL contains an apparently unnecessary quirk for my laptop, and 
> > 4b4f7280 breaks that quirk.  Of course, it's entirely possible that 
> > 4b4f7280 is 100% correct, but that the quirk only worked by accident and 
> > 4b4f7280 broke the call into video BIOS.
> 
> We've had reports from users of Intel graphics and the i915 driver 
> that previously working quirks started to break their systems with 
> 2.6.26-rc, but instead the plain "echo mem > /sys/power/state" started 
> to work for them. Your system may be one of these, but I wonder what 
> the effect of commit 4b4f7280 is.
> 
> The first possibility is that the quirks actually didn't work on your 
> system with 2.6.26-rc before commit 4b4f7280 at all for some obscure 
> reason and that commit made them work again which in turn resulted in 
> the breakage.
> 
> The second possibility is that commit 4b4f7280 actually broke those 
> quirks.
> 
> I'm not sure if it's worth the effort to check which of the above 
> really happened.  After all, you can suspend and resume the box 
> without any quirks now. ;-)

which is the ideal situation :-)

we still need to find the HAL quirk and disable it, right?

	Ingo
