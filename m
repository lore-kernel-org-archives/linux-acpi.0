From: "Walter Francis" <wally@theblackmoor.net>
Subject: Re: PROBLEM:  ACPI Thermal Zone for CPU0 does not update after   
     hibernation
Date: Mon, 9 Apr 2007 21:47:38 -0400 (EDT)
Message-ID: <33389.192.168.0.107.1176169658.squirrel@panacea.theblackmoor.net>
References: <11584.192.146.101.26.1175890435.squirrel@panacea.theblackmoor.net>
    <20070409174700.2e0a14d8.akpm@linux-foundation.org>
Reply-To: wally@theblackmoor.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 64-191-130-94.service.qx.net ([64.191.130.94]:33238 "EHLO
	panacea.theblackmoor.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932478AbXDJC2a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2007 22:28:30 -0400
In-Reply-To: <20070409174700.2e0a14d8.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jung-Ik  Lee <jilee@google.com>, linux-acpi@vger.kernel.org

> On Fri, 6 Apr 2007 16:13:55 -0400 (EDT)
> "Walter Francis" <wally@theblackmoor.net> wrote:

>> After hibernating, the CPU0 thermal zone never updates.  It will stay at 59C
>> forever for example.

> Yeah, John spotted a bug in there the other day.
>
> Does this fix it?
>
> --- a/drivers/acpi/thermal.c~acpi-thermal-fix-mod_timer-interval
> +++ a/drivers/acpi/thermal.c
> @@ -758,7 +758,8 @@ static void acpi_thermal_check(void *dat
>  			del_timer(&(tz->timer));
>  	} else {
>  		if (timer_pending(&(tz->timer)))
> -			mod_timer(&(tz->timer), (HZ * sleep_time) / 1000);
> +			mod_timer(&(tz->timer),
> +					jiffies + (HZ * sleep_time) / 1000);
>  		else {
>  			tz->timer.data = (unsigned long)tz;
>  			tz->timer.function = acpi_thermal_run;

No joy, didn't help.

Didn't apply clean to 21-pre6 (still latest I see on kernel.org), but here's
the section that seemed right.

        /*
         * Schedule Next Poll
         * ------------------
         */
        if (!sleep_time) {
                if (timer_pending(&(tz->timer)))
                        del_timer(&(tz->timer));
        } else {
                if (timer_pending(&(tz->timer)))
                        mod_timer(&(tz->timer),jiffies + (HZ * sleep_time) /
1000);
                else {
                        tz->timer.data = (unsigned long)tz;
                        tz->timer.function = acpi_thermal_run;
                        tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
                        add_timer(&(tz->timer));

Also, I think this is new with the line replaced..  Not sure exactly what's
causing it, but when I restart the cpuspeed daemon:

Starting cpuspeed: Error: Not an integer:
/proc/acpi/thermal_zone/TZS1/temperature

# cat /proc/acpi/thermal_zone/TZS1/temperature
temperature:             41 C

Looks normal to me?

Thanks!

-- 
Walter Francis

khayts.us
theblackmoor.net
unlimitedphoto.com

