From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Resend 2x] thermal: Prevent polling from happening during
 system suspend
Date: Fri, 17 Feb 2012 20:29:14 +0100
Message-ID: <20120217192914.GH2707@elf.ucw.cz>
References: <201111061421.38580.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201111061421.38580.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun 2011-11-06 14:21:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The thermal driver should use a freezable workqueue to schedule
> polling to prevent thermal_zone_device_update() from being run
> during system suspend, when the devices it relies on may be inactive.
> Make it use the system freezable workqueue for this purpose.

Umm. hibernation can take long time and (with latest compression
patches) can be CPU intensive.

Is it good idea to disable thermal management?

Should we kick fans to full speed before starting hibernation?
								Pavel

> @@ -678,10 +678,10 @@ static void thermal_zone_device_set_poll
>  		return;
>  
>  	if (delay > 1000)
> -		schedule_delayed_work(&(tz->poll_queue),
> +		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
>  				      round_jiffies(msecs_to_jiffies(delay)));
>  	else
> -		schedule_delayed_work(&(tz->poll_queue),
> +		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
>  				      msecs_to_jiffies(delay));
>  }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
