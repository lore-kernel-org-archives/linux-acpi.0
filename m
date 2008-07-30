From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on
	specific	ThinkPad T4x(p) and R50p
Date: Wed, 30 Jul 2008 14:52:27 -0300
Message-ID: <20080730175227.GA13850@khazad-dum.debian.net>
References: <200807301556.01815.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200807301556.01815.trenn-l3A5Bk7waGM@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 30 Jul 2008, Thomas Renninger wrote:
> frequency (what we probably will do again soon). It has been tested that
> specific ThinkPads do not throw a thermal event when exceeding the passive
> trip point. Even thermal polling was not enough...

Urgh.

> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41p"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42p"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad R50p"),

Just match BIOS 1R* with VENDOR IBM.  The T40 is affected as well for sure.
It uses the same BIOS and EC firmware, it *has* to be.  And it is missing on
this list.

For IBM ThinkPads, it is *always* better to match on BIOS version than on
product version.

See here for model-BIOS table:
http://www.thinkwiki.org/wiki/BIOS_Upgrade_Downloads

and here for DMI info table:
http://www.thinkwiki.org/wiki/List_of_DMI_IDs

> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43p"),

Two possible BIOS: 1Y and 70 for the T43, and BIOS 1Y for the T43p.  Are you
sure all of these machines have the bug?  Is there a common factor in the
DSDT tables we can check to root out the buggy ones?

> +		.ident = "IBM ThinkPad R40",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad R40"),
> +		},

Two possible BIOSes: 1O and 1P...  and many other ThinkPad BIOSes exist in
the time window from the 1O/1P to the 1Y.  Shouldn't all of them be suspect?

No X models have these issues? (the X models always had a slightly more
advanced BIOS, so it is indeed possible that the bug was never on that
branch of the code).

> +	if (dmi_check_system(thermal_psv_dmi_table)) {
> +		if (tz->trips.passive.flags.valid &&
> +		    tz->trips.passive.temperature > CELSIUS_TO_KELVIN(85)) {
> +			printk (KERN_INFO "Adjust passive trip point from %lu"
> +				" to %lu\n",
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature - 150));
> +			tz->trips.passive.temperature -= 150;
> +			acpi_thermal_set_polling(tz, 5);
> +		}
> +	}

If this is a safe test that won't misstrigger or cause issues, maybe just
enable it on anything with BIOS_VENDOR IBM, and PRODUCT_VERSION "ThinkPad
[TR]*" ?  None of them have CPUs that should go over 85C, AFAIK.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
