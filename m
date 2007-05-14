From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch 2.6.21-git] pci_choose_state() works, does ACPI magic
Date: Mon, 14 May 2007 11:39:16 +0200
Message-ID: <20070514093916.GA12074@elf.ucw.cz>
References: <200705091222.29561.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45688 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758601AbXENJjP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 05:39:15 -0400
Content-Disposition: inline
In-Reply-To: <200705091222.29561.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

Hi!

> Provide new ACPI method tracking the target system state, for use
> during suspend() and other PM calls.  It returns ACPI_STATE_S0
> except during true suspend paths.
> 
> Use that to finally implement the platform_pci_choose_state() hook
> on ACPI platforms.  It calls "_S3D" and similar methods, and uses
> the result appropriately.
> 
> Fix pci_choose_state() to finally behave sanely too.
> 
> Minor whitespace fixes.
> 
> Lightly tested -- STR only, with only USB affected by the new code.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> ---
>  drivers/acpi/sleep/main.c |   29 +++++++++++-
>  drivers/pci/pci-acpi.c    |  107 +++++++++++++++++++++++++++++++++-------------
>  drivers/pci/pci.c         |   51 ++++++++++++---------
>  include/acpi/acpixf.h     |    2 
>  4 files changed, 135 insertions(+), 54 deletions(-)
> 
> --- g26.orig/drivers/acpi/sleep/main.c	2007-05-09 08:57:37.000000000 -0700
> +++ g26/drivers/acpi/sleep/main.c	2007-05-09 08:58:33.000000000 -0700
> @@ -35,6 +35,20 @@ static u32 acpi_suspend_states[] = {
>  
>  static int init_8259A_after_S1;
>  
> +static u8 acpi_target_sleep_state = ACPI_STATE_S0;
> +
> +/**
> + *	acpi_get_target_sleep_state - return target ACPI S-state
> + *
> + *	When used during suspend processing, this returns the target state
> + *	such as ACPI_STATE_S3.  Otherwise it returns ACPI_STATE_S0.
> + */
> +int acpi_get_target_sleep_state(void)
> +{
> +	return acpi_target_sleep_state;
> +}
> +/* EXPORT_SYMBOL(acpi_get_target_sleep_state); ... if you need it */
> +
>  /**
>   *	acpi_pm_prepare - Do preliminary suspend work.
>   *	@pm_state:		suspend state we're entering.

This is quite an ugly hack, right? Is it really neccessary to use
global variable for this?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
