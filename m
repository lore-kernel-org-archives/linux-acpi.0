From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/2] ACPI PM: Add possibility to change suspend
	sequence
Date: Mon, 12 May 2008 09:23:01 +0200
Message-ID: <20080512072301.GC24094@elf.ucw.cz>
References: <200805062342.42789.rjw@sisk.pl> <200805071421.19788.rjw@sisk.pl> <200805091920.27756.rjw@sisk.pl> <200805091923.36763.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52094 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbYELHWe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 May 2008 03:22:34 -0400
Content-Disposition: inline
In-Reply-To: <200805091923.36763.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>

Hi!

> Index: linux-2.6/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/kernel-parameters.txt
> +++ linux-2.6/Documentation/kernel-parameters.txt
> @@ -157,6 +157,11 @@ and is between 256 and 4096 characters. 
>  			default: The hardware signature is checked during
>  			         resume from S4.
>  
> +	acpi_old_suspend_ordering [HW,ACPI] ACPI suspend ordering
> +			Enforce the ACPI 1.0 ordering of the _PTS control
> +			method wrt putting devices into low power states
> +			default: ACPI 2.0 ordering of _PTS
> +
>  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
>  			Format: { level | edge | high | low }
>

Hmm, I have a wild idea...

acpi_sleep=old_ordering

...and reuse the same variable we already use for
s3_bios/s3_mode. Then, we'd be able to blacklist the systems needing
old_ordering from s2ram...

I guess this whitelist should better be done in kernel, but short-term
ability to whitelist from userland could not hurt...?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
