From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] ACPI / PM: Modify the "low-level resume finished"
 message
Date: Fri, 4 Mar 2011 16:38:07 +0100
Message-ID: <20110304153807.GE1358@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl>
 <201102072319.56040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:41008 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759767Ab1CDPiO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2011 10:38:14 -0500
Content-Disposition: inline
In-Reply-To: <201102072319.56040.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Hi!

> Move the low-level resume completion message to the point where
> control goes back to acpi_suspend_enter() during resume and change
> it so that it's more informative.

Well, doing some printk as soon as reasonably possible was helpful for
debugging in the past. I'd move it sooner, not later.

(If you see that message, it means that normal printk debugging can be
used, not exotic stuff like hashes in NVRAM).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
