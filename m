From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] thermal active cooling step
Date: Wed, 23 Jun 2004 17:36:38 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F07A5573B@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Corrected.

--- linux-2.6.7/drivers/acpi/thermal.c.orig     2004-06-23 17:00:50.986368384 +0800
+++ linux-2.6.7/drivers/acpi/thermal.c  2004-06-23 17:03:25.687850184 +0800
@@ -610,17 +610,18 @@ acpi_thermal_active (
                 * associated with this active threshold.
                 */
                if (tz->temperature >= active->temperature) {
-                       if (active->temperature > maxtemp)
+                       if (active->temperature > maxtemp) {
                                tz->state.active_index = i, maxtemp = active->temperature;
-                       if (!active->flags.enabled) {
-                               for (j = 0; j < active->devices.count; j++) {
-                                       result = acpi_bus_set_power(active->devices.handles[j], ACPI
_STATE_D0);
-                                       if (result) {
-                                               ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to turn cool
ing device [%p] 'on'\n", active->devices.handles[j]));
-                                               continue;
+                               if (!active->flags.enabled) {
+                                       for (j = 0; j < active->devices.count; j++) {
+                                               result = acpi_bus_set_power(active->devices.handles[
j], ACPI_STATE_D0);
+                                               if (result) {
+                                                       ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to t
urn cooling device [%p] 'on'\n", active->devices.handles[j]));
+                                                       continue;
+                                               }
+                                               active->flags.enabled = 1;
+                                               ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p]
 now 'on'\n", active->devices.handles[j]));
                                        }
-                                       active->flags.enabled = 1;
-                                       ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'on
'\n", active->devices.handles[j]));
                                }
                        }
                } 


-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
Sent: 2004年6月23日 17:26
To: Wang, Zhenyu Z
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] [PATCH] thermal active cooling step

Hi!

> Fine. Resend patch below.
> 
> -zhen
> 
> 
> --- linux-2.6.7/drivers/acpi/thermal.c.orig     2004-06-23 09:16:13.360411712 +0800
> +++ linux-2.6.7/drivers/acpi/thermal.c  2004-06-23 09:17:51.985418432 +0800
> @@ -610,7 +610,7 @@ acpi_thermal_active (
>                  * associated with this active threshold.
>                  */
>                 if (tz->temperature >= active->temperature) {
> -                       if (active->temperature > maxtemp)
> +                       if (active->temperature > maxtemp){

Put space between ) and {

>                                 tz->state.active_index = i, maxtemp = active->temperature;
>                         if (!active->flags.enabled) {
>                                 for (j = 0; j < active->devices.count; j++) {
> @@ -623,6 +623,7 @@ acpi_thermal_active (
>                                         ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'on'\n", active->devices.handles[j]));
>                                 }
>                         }

This whole block needs to be moved one tab to the right...

> +                       }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
