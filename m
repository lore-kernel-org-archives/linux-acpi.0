From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on specific
	ThinkPad T4x(p) and R50p
Date: Mon, 11 Aug 2008 14:33:22 +0200
Message-ID: <200808111433.25275.trenn@suse.de>
References: <200807301556.01815.trenn@suse.de>
	<200808011318.02875.trenn@suse.de>
	<48A022BD.2040908@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A022BD.2040908-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 11 August 2008 13:30:05 Andi Kleen wrote:
> Do we have a final patch for this yet? I assume it needs at least more
> entries in the DMI list as Henrique pointed out?

On longterm I like to try to fix this in a more generic way:

Use Matthew's basic idea/patch of introducing a passive trip point 5 degree 
below the critical trip point and set a polling frequency.
And also (this is what covers the ThinkPads) lower the trip point if the 
passive trip point is too close to the critical one (and also set a polling 
frequency).

I expect 5 degree below critical tp is not enough, IMO it's better to use e.g. 
8-10 degree (you never want to work that close at the critical temperture) 
and do not use that high polling freq instead.

However, the patch from Matthew, Zhang pointed me to, is rather broken.
Beside a typo that prevents compilation, pointer types are mixed up (char vs 
unsigned long):
---------------
include/linux/thermal.h
struct thermal_zone_device_ops {
..
	int (*get_temp) (struct thermal_zone_device *, char *);
..
}
static void thermal_update(struct work_struct *work)
{
...
	unsigned long temp;
		tz->ops->get_temp(tz, &temp);
...
}
---------------
So Matthew's patch more looks like a suggestion/proof of concept patch.
Another bug I saw by looking over this one:
+			tz->ops->get_crit_temp(tz, &crit_temp);
+			tz->force_passive_temp = crit_temp-5000;
It must get checked whether a critical trip point exists at all.

This might also have to do with the fact that his first attempts have been 
rejected...

Anyway, I like to pick this up and improve as suggested above, what makes me 
wonder about the thermal_sys.c driver are the char* based device_ops to get 
temperatures.
All (with exception to the critical temp, which is even more weird) 
temperature handling functions return char*. This looks convenient for sysfs 
processing, but it's use should be rather rare (especially if more code gets 
added)?
Instead of char->long temperature conversions every time one gets a temp from 
the thermal_sys driver, shouldn't these functions better return long and you 
have one long->char conversion for sysfs?

If Matthew already has something newer it would be great if we could somehow 
coordinate work. Otherwise I will start over on this one. Probably beginning 
with a cleanup patch to use long for get_temp and get_trip_temp functions 
instead of using char* in struct thermal_zone_device_ops {...}.
Zhang: Would that be ok or have I overseen something?


Is this a bug in current drivers/thermal/Kconfig code:
config THERMAL_HWMON
        bool "Hardware monitoring support"
        depends on HWMON=y || HWMON=THERMAL
Should the last line be:
        depends on HWMON
?

      Thomas

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
