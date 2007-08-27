From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] Hibernation: Enter platform hibernation state in a consisten way (rev. 2)
Date: Mon, 27 Aug 2007 10:24:05 +0200
Message-ID: <20070827082405.GE2060@elf.ucw.cz>
References: <200708270149.52585.rjw@sisk.pl> <200708270151.33307.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47686 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756293AbXH0MIO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2007 08:08:14 -0400
Content-Disposition: inline
In-Reply-To: <200708270151.33307.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Berg <johannes@sipsolutions.net>, Thomas Renninger <trenn@suse.de>

Hi!

> Make hibernation_platform_enter() execute the enter-a-sleep-state sequence
> instead of the mixed shutdown-with-entering-S4 thing.
> 
> Replace the shutting down of devices done by kernel_shutdown_prepare(), before
> entering the ACPI S4 sleep state, with suspending them and the shutting down of
> sysdevs with calling device_power_down(PMSG_SUSPEND) (just like before entering
> S1 or S3, but the target state is now S4).  Also, disable the nonboot CPUs
> before entering the sleep state (S4), which generally always is a good idea.
> 
> This is known to fix the "double disk spin down during hibernation" on some
> machines, eg. HPC nx6325 (ref. http://lkml.org/lkml/2007/8/7/316 and the
> following thread).  It also generally causes the hibernation state (ACPI S4) to
> be entered faster.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c |   55 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 14 deletions(-)
> 

> +	local_irq_disable();
> +	error = device_power_down(PMSG_SUSPEND);
> +	if (!error) {
> +		error = hibernation_ops->enter();
> +		/* We should never get here */

Are you sure it is good idea to enable interrupts/power up devices
when this happens? AFAICT image is already on disk an intact at this
point, safe thing to do is while(1);...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
