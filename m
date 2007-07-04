From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] ACPI: Do not prepare for hibernation in acpi_shutdown
Date: Wed, 4 Jul 2007 23:40:39 +0200
Message-ID: <200707042340.40008.rjw@sisk.pl>
References: <200707012051.48338.rjw@sisk.pl> <200707012053.08663.rjw@sisk.pl> <20070704194905.GH2728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50936 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755833AbXGDVdE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Jul 2007 17:33:04 -0400
In-Reply-To: <20070704194905.GH2728@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, 4 July 2007 21:49, Pavel Machek wrote:
> Hi!
> 
> > Since we are now explicitly calling hibernation_ops->prepare() before
> > hibernation_ops->enter() in hibernation_platform_enter() (defined in
> > kernel/power/disk.c), ACPI should not call acpi_sleep_prepare(ACPI_STATE_S4)
> > from acpi_shutdown().
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/acpi/sleep/poweroff.c |    3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > Index: linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c
> > ===================================================================
> > --- linux-2.6.22-rc6.orig/drivers/acpi/sleep/poweroff.c	2007-07-01 15:08:54.000000000 +0200
> > +++ linux-2.6.22-rc6/drivers/acpi/sleep/poweroff.c	2007-07-01 15:10:07.000000000 +0200
> > @@ -54,9 +54,6 @@ static int acpi_shutdown(struct sys_devi
> >  	case SYSTEM_POWER_OFF:
> >  		/* Prepare to power off the system */
> >  		return acpi_sleep_prepare(ACPI_STATE_S5);
> > -	case SYSTEM_SUSPEND_DISK:
> > -		/* Prepare to suspend the system to disk */
> > -		return acpi_sleep_prepare(ACPI_STATE_S4);
> >  	default:
> >  		return 0;
> 
> Hmm, I do not see why this is unneccessary... acpi wants to be
> notified of poweroff, and hooks in a pretty reasonable
> way. kernel/power does not seem to call acpi_sleep_prepare(). Hmm?

Please look at -mm.

We have

int hibernation_platform_enter(void)
{
	int error;

	if (hibernation_ops) {
		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
		/*
		 * We have cancelled the power transition by running
		 * hibernation_ops->finish() before saving the image, so we
		 * should let the firmware know that we're going to enter the
		 * sleep state after all
		 */
		error = hibernation_ops->prepare();
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		if (!error)
			error = hibernation_ops->enter();
	} else {
		error = -ENOSYS;
	}
	return error;
}

in there, which is exactly that.

The patch is necessary. :-)  Otherwise ->prepare() will be called twice in a row.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
