From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: write thermal trip_points totally broken in 2.6.10-rc3-mm1 - patch
 attached
Date: Wed, 15 Dec 2004 17:12:27 +0100
Message-ID: <41C0626B.9020706@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The:
char *limit_string;
...
limit_string = kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
...
if (!tz || (count > sizeof(limit_string) - 1)) {
                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));

cannot work at all (if you want to write more than 4/8 bytes into the 
file :) ) and I doubt that it makes much sense to allocate memory at 
this place.

I just reverted changes in acpi_thermal_write_trip_points, testet -> works:

I just realize the "/sbin/poweroff" call, I thought this has been thrown 
out and moved to userspace apps via thermal event notification (acpid, ...)?

--- drivers/acpi/thermal.c.orig 2004-12-15 16:51:14.000000000 +0100
+++ drivers/acpi/thermal.c      2004-12-15 16:45:15.000000000 +0100
@@ -64,7 +64,6 @@
  #define ACPI_THERMAL_PATH_POWEROFF     "/sbin/poweroff"

  #define ACPI_THERMAL_MAX_ACTIVE        10
-#define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65

  #define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732>=0) ? 
((long)t-2732+5)/10 : ((long)t-2732-5)/10)
  #define CELSIUS_TO_KELVIN(t)   ((t+273)*10)
@@ -900,33 +899,21 @@
         struct seq_file         *m = (struct seq_file *)file->private_data;
         struct acpi_thermal     *tz = (struct acpi_thermal *)m->private;

-       char                    *limit_string;
+       char                    limit_string[65] = {'\0'};
         int                     num, critical, hot, passive;
-       int                     *active;
+       int                     active[ACPI_THERMAL_MAX_ACTIVE];
         int                     i = 0;

         ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");

-       limit_string = kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
-       if(!limit_string)
-               return_VALUE(-ENOMEM);
-
-       memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
-
-       active = kmalloc(ACPI_THERMAL_MAX_ACTIVE *sizeof(int), GFP_KERNEL);
-       if(!active)
-               return_VALUE(-ENOMEM);
-
         if (!tz || (count > sizeof(limit_string) - 1)) {
                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
-               count = -EINVAL;
-               goto end;
+               return_VALUE(-EINVAL);
         }

         if (copy_from_user(limit_string, buffer, count)) {
                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
-               count = -EFAULT;
-               goto end;
+               return_VALUE(-EFAULT);
         }

         limit_string[count] = '\0';
@@ -937,8 +924,7 @@
                                 &active[5], &active[6], &active[7], 
&active[8], &active[9]);
         if(!(num >=5 && num < (ACPI_THERMAL_MAX_ACTIVE + 3))) {
                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data format\n"));
-               count = -EINVAL;
-               goto end;
+               return_VALUE(-EINVAL);
         }

         tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
@@ -950,9 +936,6 @@
                 tz->trips.active[i].temperature = 
CELSIUS_TO_KELVIN(active[i]);
         }

-end:
-       kfree(active);
-       kfree(limit_string);
         return_VALUE(count);
  }


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
