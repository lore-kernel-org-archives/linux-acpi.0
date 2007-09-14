From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Resend][PATCH -mm] Hibernation: Enter platform hibernation
 state in a consistent way (rev. 4)
Date: Fri, 14 Sep 2007 16:37:17 -0700
Message-ID: <20070914163717.8a0cb637.akpm@linux-foundation.org>
References: <200709121314.09676.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33866 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755946AbXINXhp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Sep 2007 19:37:45 -0400
In-Reply-To: <200709121314.09676.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Stefan Becker <Stefan.Becker@nokia.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 12 Sep 2007 13:14:08 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +	if (!hibernation_ops)
> +		return -ENOSYS;
> +
> +	/*
> +	 * We have cancelled the power transition by running
> +	 * hibernation_ops->finish() before saving the image, so we should let
> +	 * the firmware know that we're going to enter the sleep state after all
> +	 */
> +	error = hibernation_ops->start();
> +	if (error)
> +		return error;
> +
> +	suspend_console();
> +	error = device_suspend(PMSG_SUSPEND);
> +	if (error)
> +		return error;
> +
> +	error = hibernation_ops->prepare();
> +	if (error)
> +		goto Resume_devices;
> +
> +	error = disable_nonboot_cpus();
> +	if (error)
> +		goto Finish;
> +
> +	local_irq_disable();
> +	error = device_power_down(PMSG_SUSPEND);
> +	if (!error) {
> +		hibernation_ops->enter();
> +		/* We should never get here */
> +		while (1);
>  	}
> +	local_irq_enable();
> +

Confused.  afacit there's no way for the caller of this function to know
whether or not suspend_console() was called, so the error recovery doesn't
know whether or not to run resume_console().  How does all that work?
