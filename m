From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Fri, 8 Feb 2008 23:10:15 +0100
Message-ID: <20080208221015.GB1648@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <20080207092035.GB1816@elf.ucw.cz> <47AB60C4.50602@free.fr> <200802072100.32205.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58576 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762043AbYBHWJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 17:09:56 -0500
Content-Disposition: inline
In-Reply-To: <200802072100.32205.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: matthieu castet <castet.matthieu@free.fr>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

> > I wonder if there a way to check that we are realy in real mode ?
> 
> Yes.  In real mode bit 0 of the cr0 register should be 0.

It is not as simple. There's stuff like "unreal" mode... real mode
with 4GB descriptor limits... and similar crazyness.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
