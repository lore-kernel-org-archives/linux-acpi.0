From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 6/9] ACPI: thinkpad-acpi: add sysfs support to fan subdriver
Date: Wed, 25 Apr 2007 09:49:13 -0300
Message-ID: <20070425124913.GA14497@khazad-dum.debian.net>
References: <11774261003184-git-send-email-hmh@hmh.eng.br> <11774261011195-git-send-email-hmh@hmh.eng.br> <200704250158.18297.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57872 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965522AbXDYMtT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 08:49:19 -0400
Content-Disposition: inline
In-Reply-To: <200704250158.18297.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Wed, 25 Apr 2007, Len Brown wrote:
> I'm glad to see the proc->sysfs conversion.
> I'm glad to see compatibility with hwmon.
> I think it will be handy to read fan speed.
> 
> I'm doubtful about the utility of setting fan speed.
> It seems like it is enough rope for users to hang themselves,
> and the need for a "safety net" seems to confirm that.

The safety net was added out of sheer paranoia in the last few days, nobody
*ever* reported any problems with this functionality, and I have never seen
a ThinkPad DSDT that does not support the AUTO mode in HFSP fan control
mode.

I was doing a final review before sending the patches to you, looked at that
code, and though "hey, wait.  There *is* a possible worst case scenario
here.  Nobody ever reported it, but what the heck...".

Fan speed control is a feature thinkpad owners want, it is in use for about
two years now.  Before I started maintaining ibm-acpi / thinkpad-acpi, it
already supported basic fan control, and a lot of people that wanted more
used some unwise tricks to do it (like playing directly with the EC).

What we have now is at least *known safe* for the A31, T2x, T3x, T4x, T6x,
X3x, X4x, X6x, R4x, R5x, R6x, Z6x in most commonly used BIOS/EC firmware
revisions.  All of those models are known *not* to need any safety nets,
either.  And earlier models don't support the codepath we are talking about
anyway, so the driver doesn't enable it.

Besides, unless the user decides to tell it to do something, the driver
changes exactly *nothing* on the EC (no writes at all), so the ThinkPad will
just continue doing whatever its firmware default operating mode and DSDT
told it to.

I won't say fan speed control is 100% safe, it would be foolhardy to do so,
especially if you factor in firmware bugs.  But it is safe enough that
nobody ever reported any problems with it in two years, so it is good enough
for the population that would want to use it.  And the driver is intelligent
enough to not change EC state unless it is actually commanded to do so.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
