From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] clear GPE earily in resume
Date: Wed, 20 Jun 2007 00:06:32 +0200
Message-ID: <200706200006.35413.rjw@sisk.pl>
References: <1181785011.19274.6.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43919 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbXFSV77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 17:59:59 -0400
In-Reply-To: <1181785011.19274.6.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "robert.moore" <robert.moore@intel.com>

On Thursday, 14 June 2007 03:36, Shaohua Li wrote:
> Wakeup GPE hasn't a handler. If system is waked up by such GPE like a
> USB hotplug, I saw a lot of error reporting the GPE hasn't handler.
> acpi_leave_sleep_state will clear the GPE but it's too late, we should
> doe it before interrupt is re-enabled. 
> 
> Maybe we should just clear wakeup GPE here, but clear all GPEs sounds
> not harmful in my test. Not sure other systems.

I think that the clearing all of the GPEs is the right thing to do here.

> Index: 2.6.22-rc/drivers/acpi/sleep/main.c
> ===================================================================
> --- 2.6.22-rc.orig/drivers/acpi/sleep/main.c	2007-06-11 15:31:03.000000000 +0800
> +++ 2.6.22-rc/drivers/acpi/sleep/main.c	2007-06-14 09:31:54.000000000 +0800
> @@ -104,6 +104,8 @@
>  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
>  		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
>  

I'd add a comment saying why we're clearing the GPEs at this point.

> +	acpi_hw_disable_all_gpes();
> +
>  	local_irq_restore(flags);
>  	printk(KERN_DEBUG "Back to C!\n");
>  
> -

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
