From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI lockdep warning on boot, 2.6.25-rc5
Date: Sat, 15 Mar 2008 14:16:11 +0100
Message-ID: <20080315131611.GA4828@ucw.cz>
References: <E1JZOGd-00057d-BU@pomaz-ex.szeredi.hu> <200803122301.17356.rjw@sisk.pl> <200803131614.33386.lenb@kernel.org> <20080314001819.GA32584@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1867 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752445AbYCOTru (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Mar 2008 15:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20080314001819.GA32584@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Miklos Szeredi <miklos@szeredi.hu>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> @@ -421,7 +423,9 @@
>  		else
>  			acpi_safe_halt();
>  
> -		local_irq_enable();
> +		if (irqs_disabled())
> +			local_irq_enable();
> +
>  		return;
>  	}
>  
> @@ -530,7 +534,9 @@
>  		 *       skew otherwise.
>  		 */
>  		sleep_ticks = 0xFFFFFFFF;
> -		local_irq_enable();
> +		if (irqs_disabled())
> +			local_irq_enable();
> +
>  		break;
>  
>  	case ACPI_STATE_C2:

That's pretty ugly. Could the code be modified to have interrupt
consistent at this point?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
