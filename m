From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: more verbose thermal zone shutdown message
Date: Sun, 15 Apr 2007 19:11:07 +0000
Message-ID: <20070415191107.GD10097@ucw.cz>
References: <200704051615.07960.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3842 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753536AbXDOT5h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Apr 2007 15:57:37 -0400
Content-Disposition: inline
In-Reply-To: <200704051615.07960.dkukawka@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <dkukawka@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> while debug some strange termal shutdowns I wrote this patch to get more 
> information in /var/log/messages about the reason for the shutdown. I 
> think this would be useful in general.
> 
> Danny
> 
> From: Danny Kukawka <dkukawka@suse.de>
> Subject: ACPI: more verbose thermal zone shutdown message
> 
> add more information to acpi thermal zone shutdown message for easier
> debugging
> 
> Signed-off-by: Danny Kukawka <dkukawka@suse.de>

Yes, please.

(I actually had similar patch in my tree forever).

>  	if (tz->temperature >= tz->trips.critical.temperature) {
> -		printk(KERN_WARNING PREFIX "Critical trip point\n");
> +		printk(KERN_WARNING PREFIX 
> +		       "Critical trip point (%ld C) reached on thermal zone [%s]\n",
> +		       KELVIN_TO_CELSIUS(tz->trips.critical.temperature),
> +		       acpi_device_bid(tz->device)); 
>  		tz->trips.critical.flags.enabled = 1;
>  	} else if (tz->trips.critical.flags.enabled)
>  		tz->trips.critical.flags.enabled = 0;
>  
>  	printk(KERN_EMERG
> -	       "Critical temperature reached (%ld C), shutting down.\n",
> -	       KELVIN_TO_CELSIUS(tz->temperature));
> +	       "Critical temperature reached (%ld C on [%s] with trip point set to: %ld C), shutting down.\n",
> +	       KELVIN_TO_CELSIUS(tz->temperature),
> +	       acpi_device_bid(tz->device),
> +	       KELVIN_TO_CELSIUS(tz->trips.critical.temperature));
> +

Why two printks with same info, and why is one of them WARNING and
second EMERG?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
