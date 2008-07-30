From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on specific
	ThinkPad T4x(p) and R50p
Date: Wed, 30 Jul 2008 21:03:38 +0200
Message-ID: <200807302103.39536.trenn@suse.de>
References: <200807301556.01815.trenn@suse.de>
	<20080730175227.GA13850@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080730175227.GA13850-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
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
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 30 July 2008 19:52:27 Henrique de Moraes Holschuh wrote:
> On Wed, 30 Jul 2008, Thomas Renninger wrote:
> > frequency (what we probably will do again soon). It has been tested that
> > specific ThinkPads do not throw a thermal event when exceeding the
> > passive trip point. Even thermal polling was not enough...
>
> Urgh.
>
> > +			DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T41p"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T42p"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad R50p"),
>
> Just match BIOS 1R* with VENDOR IBM.  The T40 is affected as well for sure.
> It uses the same BIOS and EC firmware, it *has* to be.  And it is missing
> on this list.
>
> For IBM ThinkPads, it is *always* better to match on BIOS version than on
> product version.
>
> See here for model-BIOS table:
> http://www.thinkwiki.org/wiki/BIOS_Upgrade_Downloads
>
> and here for DMI info table:
> http://www.thinkwiki.org/wiki/List_of_DMI_IDs
>
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION,"ThinkPad T43p"),
I thought they tested the T43 or T43p and it threw thermal events and did not 
shut down.
I will have a look at the bug again, I have to touch this one anyway.
Or just lower passive to around 80 C for all of them as you suggested below.

Thanks for the comments..., give me some time and I repost.

       Thomas
>
> > +	if (dmi_check_system(thermal_psv_dmi_table)) {
> > +		if (tz->trips.passive.flags.valid &&
> > +		    tz->trips.passive.temperature > CELSIUS_TO_KELVIN(85)) {
> > +			printk (KERN_INFO "Adjust passive trip point from %lu"
> > +				" to %lu\n",
> > +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
> > +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature - 150));
> > +			tz->trips.passive.temperature -= 150;
> > +			acpi_thermal_set_polling(tz, 5);
> > +		}
> > +	}
>
> If this is a safe test that won't misstrigger or cause issues, maybe just
> enable it on anything with BIOS_VENDOR IBM, and PRODUCT_VERSION "ThinkPad
> [TR]*" ?  None of them have CPUs that should go over 85C, AFAIK.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
