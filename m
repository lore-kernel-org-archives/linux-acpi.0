From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/4] swsusp: Remove code duplication between disk.c and user.c
Date: Tue, 22 May 2007 01:30:07 +0200
Message-ID: <20070521233007.GK10714@elf.ucw.cz>
References: <200705180019.35548.rjw@sisk.pl> <200705180022.27910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48791 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759453AbXEUXaR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 19:30:17 -0400
Content-Disposition: inline
In-Reply-To: <200705180022.27910.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently, much of the code in kernel/power/disk.c is duplicated in
> kernel/power/user.c , mainly for historical reasons.  By eliminating this code
> duplication we can reduce the size of user.c quite substantially and remove the
> maintenance difficulty resulting from it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
