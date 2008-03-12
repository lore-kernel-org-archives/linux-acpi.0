From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 12 Mar 2008 18:13:07 -0300
Message-ID: <20080312211306.GD30864@khazad-dum.debian.net>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz> <200803121952.42666.arekm@maven.pl> <20080312193637.GA27873@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54418 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218AbYCLVNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 17:13:11 -0400
Content-Disposition: inline
In-Reply-To: <20080312193637.GA27873@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 12 Mar 2008, Lukas Hejtmanek wrote:
> On Wed, Mar 12, 2008 at 07:52:41PM +0100, Arkadiusz Miskiewicz wrote:
> > I'm also seeing regression on my thinkpad z60m where with git tree (tested 
> > again with 2 days old git) "thinkvantage" button stopped working (pressing it 
> > was previously seen by some userspace kde which run konsole).
> > 
> > On 2.6.24 presses are seen.
> 
> well, on 2.6.25-rc4, some keys are not reported as input (xev does not see any
> key press), some keys are. Is this desired? Or all the keys (fn+f1-12 + volume
> + backlight + think vantage) should be reported as some input event and thus
> acpid makes no sense any more?

xev has to get events from somewhere.  That somewhere happens to be a buggy
mess right now (X.org evdev device).  Or it is getting it through some other
middleware, like HAL, which can have its own problems.

If you want to test thinkpad-acpi functionality, get HAL and X.org out of
the way.  The easiest way is to do it in single user mode.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
