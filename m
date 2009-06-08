From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2] PM: Separate suspend to RAM functionality
	from core
Date: Mon, 8 Jun 2009 08:36:03 +0200
Message-ID: <20090608063603.GA1833@ucw.cz>
References: <200906070054.19207.rjw@sisk.pl> <200906070055.55156.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35426 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbZFHPVd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2009 11:21:33 -0400
Content-Disposition: inline
In-Reply-To: <200906070055.55156.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Sun 2009-06-07 00:55:54, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the suspend to RAM and standby code from kernel/power/main.c
> to two separate files, kernel/power/suspend.c containing the basic
> functions and kernel/power/suspend-test.c containing the automatic
> suspend test facility based on the RTC clock alarm.
> 
> There are no changes in functionality related to these modifications.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
