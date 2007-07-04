From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2] ACPI: Do not prepare for hibernation in acpi_shutdown
Date: Wed, 4 Jul 2007 21:49:05 +0200
Message-ID: <20070704194905.GH2728@elf.ucw.cz>
References: <200707012051.48338.rjw@sisk.pl> <200707012053.08663.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60175 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754309AbXGDTtJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2007 15:49:09 -0400
Content-Disposition: inline
In-Reply-To: <200707012053.08663.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi!

> Since we are now explicitly calling hibernation_ops->prepare() before
> hibernation_ops->enter() in hibernation_platform_enter() (defined in
> kernel/power/disk.c), ACPI should not call acpi_sleep_prepare(ACPI_STATE_S4)
> from acpi_shutdown().
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/poweroff.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> Index: linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c
> ===================================================================
> --- linux-2.6.22-rc6.orig/drivers/acpi/sleep/poweroff.c	2007-07-01 15:08:54.000000000 +0200
> +++ linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c	2007-07-01 15:10:07.000000000 +0200
> @@ -54,9 +54,6 @@ static int acpi_shutdown(struct sys_devi
>  	case SYSTEM_POWER_OFF:
>  		/* Prepare to power off the system */
>  		return acpi_sleep_prepare(ACPI_STATE_S5);
> -	case SYSTEM_SUSPEND_DISK:
> -		/* Prepare to suspend the system to disk */
> -		return acpi_sleep_prepare(ACPI_STATE_S4);
>  	default:
>  		return 0;

Hmm, I do not see why this is unneccessary... acpi wants to be
notified of poweroff, and hooks in a pretty reasonable
way. kernel/power does not seem to call acpi_sleep_prepare(). Hmm?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
