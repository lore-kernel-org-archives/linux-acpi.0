From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Avoid critical temp shutdowns on specific
	ThinkPad T4x(p) and R50p
Date: Wed, 30 Jul 2008 18:46:04 +0200
Message-ID: <200807301846.05121.trenn@suse.de>
References: <200807301556.01815.trenn@suse.de>
	<4890942C.3080007@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4890942C.3080007-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 30 July 2008 18:17:48 Andi Kleen wrote:
> Thomas Renninger wrote:
> > This came in in OpenSUSE 10.3. When we still had overriden thermal
> > polling frequency (what we probably will do again soon). It has been
> > tested that specific ThinkPads do not throw a thermal event when
> > exceeding the passive trip point. Even thermal polling was not enough...
> > As no other solution has been found meanwhile and it seems Windows is
> > also using a virtual passive trip point:
>
> Ok that would be good evidence.
>
> > +	if (dmi_check_system(thermal_psv_dmi_table)) {
> > +		if (tz->trips.passive.flags.valid &&
> > +		    tz->trips.passive.temperature > CELSIUS_TO_KELVIN(85)) {
This makes use of the macro CELSIUS_TO_KELVIN to show the better readable 
Celsius value.
temperature is internally stored in Kelvin*10
(e.g. tz->trips.{passive,active[i],hot,critical}.temperature)
> > +			printk (KERN_INFO "Adjust passive trip point from %lu"
> > +				" to %lu\n",
> > +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
> > +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature - 150));
Here we show the user the real Celsius value calced back.
> > +			tz->trips.passive.temperature -= 150;
>
> The hardcoded temperature numbers make me a little uneasy. Also 85 - 150
> is potentially negative, which is probably not good?
As said, stored in Kelvin*10. If you substract 150 you substract 15 degree 
Celsius or Kelvin.
Not sure whether there is a way to nicer show that.

Therefore the latest added test by Arjan for zero values returned for _CRT 
temperature looks like that:

+               /*
+                * Treat freezing temperatures as invalid as well; some
+                * BIOSes return really low values and cause reboots at 
startup.
+                * Below zero (Celcius) values clearly aren't right for sure..
+                * ... so lets discard those as invalid.
+                */
+               if (ACPI_FAILURE(status) ||
+                               tz->trips.critical.temperature <= 2732) {

A temperature value of zero degree Celsius evaluates to 2732: (0 + 273,2K) * 
10.

      Thomas

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
