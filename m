From: Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>
Subject: Re: acpi spend too much time in system mode
Date: Fri, 27 Sep 2002 13:58:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927125833.GA31505@the.earth.li>
References: <3D944485.1020701@eavr.u-strasbg.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D944485.1020701-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

---- Original Message ----
> From Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
> Date: Friday, 27 Sep 2002, 12:44
>
> I don't know if this problem is specific to my laptop,
> but when I do a cat /proc/acpi/battery/BAT1/info, the
> CPU monitor shows a very high percentage of activity
> in system mode. The consequence is a freezing mouse on
> each battery monitor polling.
> 
> Not a critical problem, but pretty ennoying...

I get a short pause doing this on my FX501, my 'solution' was to modify 
battstat_applet to cache the results of reading the info file and only 
actually read from it very infrequently.

Patch to acpi-linux from 2.0.13 is attached if anyone's interested
(though it's fairly trivial).  It incorporates Troy Schultz's changes to 
that file.

-- 
Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="batt.patch"

--- ../../battstat_applet-2.0.13/src/acpi-linux.c	Sun Nov  4 23:41:22 2001
+++ acpi-linux.c	Sun Sep 22 13:38:28 2002
@@ -21,6 +21,12 @@
 // ACPI battery read-out functions for Linux >= 2.4.12
 // October 2001 by Lennart Poettering <lennart-mdGvqq1h2p8n5izryJqWLw@public.gmane.org>
 
+/* Additional changes September 2002 by Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
+   - changed acpi handling for newer format
+   - added support for battery time remaining
+   - added code to prevent division by zero, returns zero result
+*/
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -87,69 +93,87 @@
     return 0;
 }
 
+int info_read_counter = 0;
+guint32 max_capacity, low_capacity, critical_capacity;
+
 // Fills out a classic apm_info structure with the data gathered from
 // the ACPI kernel interface in /proc
 gboolean acpi_linux_read(struct apm_info *apminfo)
 {
-  guint32 max_capacity, low_capacity, critical_capacity, remain;
+  guint32 remain, present_rate;
   gboolean charging, ac_online;
   FILE *f;
 
   // apminfo.ac_line_status must be one when on ac power
   // apminfo.battery_status must be 0 for high, 1 for low, 2 for critical, 3 for charging
-  // apminfo.battery_percentage must contain batter charge percentage
+  // apminfo.battery_percentage must contain battery charge percentage
   // apminfo.battery_flags & 0x8 must be nonzero when charging
   
   g_assert(apminfo);
 
-  max_capacity = 0;
-  low_capacity = 0;
-  critical_capacity = 0;
-
-  if ((f = fopen("/proc/acpi/battery/1/info", "r")))
-    {
-      max_capacity = al_get_field_int(f, "Design Capacity");
-      low_capacity = al_get_field_int(f, "Design Capacity Warning");
-      critical_capacity = al_get_field_int(f, "Design Capacity Low");
-      
-      fclose(f);
-    }
+  if ((info_read_counter % 256) == 0) {
+    // Reading the info file is slow so do it very infrequently
   
+    max_capacity = 0;
+    low_capacity = 0;
+    critical_capacity = 0;
+
+    if ((f = fopen("/proc/acpi/battery/BAT1/info", "r")))
+      {
+        max_capacity = al_get_field_int(f, "last full capacity");
+        low_capacity = al_get_field_int(f, "design capacity warning");
+        critical_capacity = al_get_field_int(f, "design capacity low");
+      
+        fclose(f);
+      }
+  }
+  info_read_counter++;
+
   if (!max_capacity)
     return FALSE;
   
   charging = FALSE;
   remain = 0;
 
-  if ((f = fopen("/proc/acpi/battery/1/status", "r")))
+  if ((f = fopen("/proc/acpi/battery/BAT1/state", "r")))
     {
       gchar *s;
       gchar tmp[256];
 
-      if ((s = al_get_field(f, "State", tmp, sizeof(tmp))))
+      if ((s = al_get_field(f, "charging state", tmp, sizeof(tmp))))
         charging = strcmp(s, "charging") == 0;
       
-      remain = al_get_field_int(f, "Remaining Capacity");
+      present_rate = al_get_field_int(f, "present rate");
+      remain = al_get_field_int(f, "remaining capacity");
 
       fclose(f);
     }
   
   ac_online = FALSE;
   
-  if ((f = fopen("/proc/acpi/ac_adapter/0/status", "r")))
+  if ((f = fopen("/proc/acpi/ac_adapter/ACAD/state", "r")))
     {
       gchar *s;
       gchar tmp[256];      
 
-      if ((s = al_get_field(f, "Status", tmp, sizeof(tmp))))
+      if ((s = al_get_field(f, "state", tmp, sizeof(tmp))))
         ac_online = strcmp(s, "on-line") == 0;
 
       fclose(f);
     }
 
+  if( present_rate > 0 ) {
+     apminfo->battery_time = (remain*60)/present_rate;
+  } else {
+     apminfo->battery_time = 0;
+  }
   apminfo->ac_line_status = ac_online ? 1 : 0;
   apminfo->battery_status = remain < low_capacity ? 1 : remain < critical_capacity ? 2 : 0;
-  apminfo->battery_percentage = (int) (remain/(float)max_capacity*100);
+  if( max_capacity > 0 ){
+     apminfo->battery_percentage = (int) (remain/(float)max_capacity*100);
+  } else {
+     apminfo->battery_percentage = 0;
+  }
   apminfo->battery_flags = charging ? 0x8 : 0;
 
   return TRUE;

--HcAYCG3uE/tztfnV--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
