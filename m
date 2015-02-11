From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 02:02:06 +0100
Message-ID: <3544719.NIea3H3XJ4@vostro.rjw.lan>
References: <1790277.SYbcblnshn@vostro.rjw.lan> <1721194.3W9qJruT3Q@vostro.rjw.lan> <20150211003318.GA13680@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59732 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750965AbbBKAjC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:39:02 -0500
In-Reply-To: <20150211003318.GA13680@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com, Len Brown <len.brown@intel.com>

On Wednesday, February 11, 2015 12:33:18 AM Matthew Garrett wrote:
> On Wed, Feb 11, 2015 at 01:53:26AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 11, 2015 12:26:02 AM Matthew Garrett wrote:
> > > Hm. It's not clear to me what the bug is describing. If we're not waking 
> > > up more frequently, why aren't we entering PC6?
> > 
> > Good question. :-)
> > 
> > The bug is saying, pretty much, that after a positive _OSI response to "Darwin"
> > we cannot enter PC6 any more on that machine all other things being equal.
> 
> We're using intel_idle, so we should be making idle state determination 
> regardless of what ACPI tells us. So is Darwin mode influencing the 
> state of some MSR that controls whether PC6 can be entered?

I need to confirm that with Len, but I don't recall there being an MSR
controlling the PC6 availability on Haswell.  There is one for PC7, but
not for PC6 IIRC.

> Is the GPU blocking it because of some configuration difference?

That is possible.

> I don't know enough about how the chip decides to enter PC6 to be able to
> tell.

Well, so honestly how do you expect me to respond here?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
