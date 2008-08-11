From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on specific
	ThinkPad T4x(p) and R50p
Date: Mon, 11 Aug 2008 13:55:19 +0100
Message-ID: <20080811125519.GA26308@srcf.ucam.org>
References: <200807301556.01815.trenn@suse.de>
	<200808011318.02875.trenn@suse.de>
	<48A022BD.2040908@linux.intel.com>
	<200808111433.25275.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200808111433.25275.trenn-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 11, 2008 at 02:33:22PM +0200, Thomas Renninger wrote:
> ---------------
> include/linux/thermal.h
> struct thermal_zone_device_ops {
> ..
> 	int (*get_temp) (struct thermal_zone_device *, char *);
> ..
> }

You're missing the cleanup patches for the thermal layer that I posted 
at the same time.

> So Matthew's patch more looks like a suggestion/proof of concept patch.
> Another bug I saw by looking over this one:
> +			tz->ops->get_crit_temp(tz, &crit_temp);
> +			tz->force_passive_temp = crit_temp-5000;
> It must get checked whether a critical trip point exists at all.

Yes, the return value for get_crit_temp should be checked. I think 5 
degrees is safe enough, though - I haven't been able to cause a system 
to respond too quickly at that point. The polling frequency is increased 
if the temperature gets within 5 degrees of the new passive trip point.

> This might also have to do with the fact that his first attempts have been 
> rejected...

?

> If Matthew already has something newer it would be great if we could somehow 
> coordinate work. Otherwise I will start over on this one. Probably beginning 
> with a cleanup patch to use long for get_temp and get_trip_temp functions 
> instead of using char* in struct thermal_zone_device_ops {...}.
> Zhang: Would that be ok or have I overseen something?

Like I said, that's already done.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
