From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 4/4] swsusp: Fix hibernation code ordering (updated)
Date: Tue, 22 May 2007 01:31:38 +0200
Message-ID: <20070521233138.GL10714@elf.ucw.cz>
References: <200705180019.35548.rjw@sisk.pl> <200705180026.20647.rjw@sisk.pl> <200705191036.58177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44539 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755925AbXEUXbq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 19:31:46 -0400
Content-Disposition: inline
In-Reply-To: <200705191036.58177.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Change the code ordering so that hibernation_ops->prepare() is called after
> device_suspend().  This is needed so that we don't violate the ACPI
> specification, which states that the _PTS and _GTS system-control methods,
> executed from acpi_sleep_prepare(), ought to be called after devices have been
> put in low power states.
> 
> The "Finish" label in hibernation_restore() is moved, because device_suspend()
> resumes devices if the suspending of them fails and the restore code ordering
> should reflect the hibernation code ordering.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
