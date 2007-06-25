From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in pm_ops
Date: Mon, 25 Jun 2007 15:04:08 +0200
Message-ID: <20070625130408.GA20203@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org> <200706240203.12970.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34381 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbXFYNEf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jun 2007 09:04:35 -0400
Content-Disposition: inline
In-Reply-To: <200706240203.12970.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>

Hi!

> > Right now the states we have are On, Standby, and Suspend, and the CPU
> > runs only in the On state.  But on some platforms there could be
> > multiple states in which the CPU is able to run, albeit with degraded 
> > performance.
> 
> I wouldn't call those system sleep states.  For example, ACPI defines system
> sleep states as the states in which no instructions are executed by any CPUs
> and I think that's reasonable.

Well, in some cases, we have 200MHz CPU running at 30kHz. ...that's so
slow that it is pretty similar to ACPI sleep state.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
