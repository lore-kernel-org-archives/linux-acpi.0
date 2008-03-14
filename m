From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Fri, 14 Mar 2008 08:30:12 +0100
Message-ID: <20080314073012.GF17940@kernel.dk>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz> <200803121952.42666.arekm@maven.pl> <20080313231738.GH30864@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:25053 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbYCNHaO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 03:30:14 -0400
Content-Disposition: inline
In-Reply-To: <20080313231738.GH30864@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, Lukas Hejtmanek <xhejtman@ics.muni.cz>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 13 2008, Henrique de Moraes Holschuh wrote:
> On Wed, 12 Mar 2008, Arkadiusz Miskiewicz wrote:
> > > On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Holschuh wrote:
> > > > You shouldn't need to do anything other than teach userspace to respond
> > > > to them, as they generate the proper KEY_* events.  If you are giving the
> > > > AML _OSI(Linux), at least...
> > 
> > I'm also seeing regression on my thinkpad z60m where with git tree (tested 
> > again with 2 days old git) "thinkvantage" button stopped working (pressing it 
> > was previously seen by some userspace kde which run konsole).
> > 
> > On 2.6.24 presses are seen.
> 
> There were no changes to thinkpad-acpi that should have caused this.  So I
> need more data to find out what is happening.  Might be a problem elsewhere
> in ACPI, or some bug in thinkpad-acpi.
> 
> You DO have /proc/acpi/event, correct?  Please send me the debug output of
> thinkpad-acpi when it is loaded with "debug=0xffff" as a parameter (and for
> extra bonus, please compile it with the verbose debug Kconfig option).

Updated to current kernel (saw it had a bunch of acpi fixes), and it now
works correctly! xev sees the events and the mixer sees mute/unmute and
volume up+down events.

So I think we can lay this one to rest, thankfully.

-- 
Jens Axboe

