From: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Subject: battstat_applet patches
Date: 05 Sep 2002 23:08:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031281716.9287.14.camel@p2710>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lyArghpNghmzxmmHaIt9"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Daniel Wagenaar <wagenaar-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-lyArghpNghmzxmmHaIt9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have just finished several changes to the battstat_applet 2.0.13 to
work with the latest ACPI.  The changes also add battery time remaining
in the tooltip for the applet.  These have been tested on my Compaq
Presario 2710 with kernel 2.4.19 and ACPI version 20020821.

The original battstat_applet source can be downloaded from
http://sourceforge.net/projects/battstat/

If anyone is interested here are my patches;

- Best Regards




--=-lyArghpNghmzxmmHaIt9
Content-Disposition: attachment; filename=battstat_applet-2.0.13-patch.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=battstat_applet-2.0.13-patch.diff; charset=ISO-8859-1

--- acpi-linux.c.orig	Wed Sep  4 17:40:08 2002
+++ acpi-linux.c	Thu Sep  5 22:35:51 2002
@@ -21,6 +21,12 @@
 // ACPI battery read-out functions for Linux >=3D 2.4.12
 // October 2001 by Lennart Poettering <lennart-mdGvqq1h2p8n5izryJqWLw@public.gmane.org>
=20
+/* Additional changes September 2002 by Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
+   - changed acpi handling for newer format
+   - added support for battery time remaining
+   - added code to prevent division by zero, returns zero result
+*/
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -91,13 +97,13 @@
 // the ACPI kernel interface in /proc
 gboolean acpi_linux_read(struct apm_info *apminfo)
 {
-  guint32 max_capacity, low_capacity, critical_capacity, remain;
+  guint32 max_capacity, low_capacity, critical_capacity, remain, present_r=
ate;
   gboolean charging, ac_online;
   FILE *f;
=20
   // apminfo.ac_line_status must be one when on ac power
   // apminfo.battery_status must be 0 for high, 1 for low, 2 for critical,=
 3 for charging
-  // apminfo.battery_percentage must contain batter charge percentage
+  // apminfo.battery_percentage must contain battery charge percentage
   // apminfo.battery_flags & 0x8 must be nonzero when charging
  =20
   g_assert(apminfo);
@@ -106,11 +112,11 @@
   low_capacity =3D 0;
   critical_capacity =3D 0;
=20
-  if ((f =3D fopen("/proc/acpi/battery/1/info", "r")))
+  if ((f =3D fopen("/proc/acpi/battery/BAT1/info", "r")))
     {
-      max_capacity =3D al_get_field_int(f, "Design Capacity");
-      low_capacity =3D al_get_field_int(f, "Design Capacity Warning");
-      critical_capacity =3D al_get_field_int(f, "Design Capacity Low");
+      max_capacity =3D al_get_field_int(f, "last full capacity");
+      low_capacity =3D al_get_field_int(f, "design capacity warning");
+      critical_capacity =3D al_get_field_int(f, "design capacity low");
      =20
       fclose(f);
     }
@@ -121,35 +127,45 @@
   charging =3D FALSE;
   remain =3D 0;
=20
-  if ((f =3D fopen("/proc/acpi/battery/1/status", "r")))
+  if ((f =3D fopen("/proc/acpi/battery/BAT1/state", "r")))
     {
       gchar *s;
       gchar tmp[256];
=20
-      if ((s =3D al_get_field(f, "State", tmp, sizeof(tmp))))
+      if ((s =3D al_get_field(f, "charging state", tmp, sizeof(tmp))))
         charging =3D strcmp(s, "charging") =3D=3D 0;
      =20
-      remain =3D al_get_field_int(f, "Remaining Capacity");
+      present_rate =3D al_get_field_int(f, "present rate");
+      remain =3D al_get_field_int(f, "remaining capacity");
=20
       fclose(f);
     }
  =20
   ac_online =3D FALSE;
  =20
-  if ((f =3D fopen("/proc/acpi/ac_adapter/0/status", "r")))
+  if ((f =3D fopen("/proc/acpi/ac_adapter/ACAD/state", "r")))
     {
       gchar *s;
       gchar tmp[256];     =20
=20
-      if ((s =3D al_get_field(f, "Status", tmp, sizeof(tmp))))
+      if ((s =3D al_get_field(f, "state", tmp, sizeof(tmp))))
         ac_online =3D strcmp(s, "on-line") =3D=3D 0;
=20
       fclose(f);
     }
=20
+  if( present_rate > 0 ) {
+     apminfo->battery_time =3D (remain*60)/present_rate;
+  } else {
+     apminfo->battery_time =3D 0;
+  }
   apminfo->ac_line_status =3D ac_online ? 1 : 0;
   apminfo->battery_status =3D remain < low_capacity ? 1 : remain < critica=
l_capacity ? 2 : 0;
-  apminfo->battery_percentage =3D (int) (remain/(float)max_capacity*100);
+  if( max_capacity > 0 ){
+     apminfo->battery_percentage =3D (int) (remain/(float)max_capacity*100=
);
+  } else {
+     apminfo->battery_percentage =3D 0;
+  }
   apminfo->battery_flags =3D charging ? 0x8 : 0;
=20
   return TRUE;
--- battstat_applet.c.orig	Thu Sep  5 22:46:40 2002
+++ battstat_applet.c	Thu Sep  5 22:21:23 2002
@@ -20,6 +20,10 @@
  $Id: battstat_applet.c,v 1.23 2001/11/04 23:41:22 jdthood Exp $
  */
=20
+/* Additional changes September 2002 by Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
+   - added support for time remaining
+*/
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -316,6 +320,8 @@
   static guint last_batt_state=3D1000;
   static guint last_pixmap_index=3D1000;
   static guint last_charging=3D1000;
+  guint batt_remain_Hr;
+  guint batt_remain_Min;
   guint batt_life;
   guint acline_status;
   guint batt_state;
@@ -374,6 +380,8 @@
    batt_state =3D apminfo.battery_status;
    batt_life =3D (guint) apminfo.battery_percentage;
    charging =3D (apminfo.battery_flags & 0x8) ? TRUE : FALSE;
+   batt_remain_Hr =3D (guint) apminfo.battery_time / 60;
+   batt_remain_Min =3D (guint) apminfo.battery_time % 60;
 #else
    acline_status =3D 1;
    batt_state =3D 0;
@@ -415,8 +423,8 @@
    ) {
       /* Warn that battery dropped below red_val */
       if(battery->lowbattnotification) {
-         snprintf(new_label, sizeof(new_label),_("Battery low (%d%%) and A=
C is offline"),
-                  batt_life);
+         snprintf(new_label, sizeof(new_label),_("Battery low (%d%%) [%d:%=
d remain] and AC is offline"),
+                  batt_life,batt_remain_Hr, batt_remain_Min);
          gnome_warning_dialog(new_label);
    =20
          if(battery->beep)
@@ -457,12 +465,12 @@
       if(!battery->showbattery && !battery->showpercent) {
 	 if(acline_status =3D=3D 0) {
 	    snprintf(new_label, sizeof(new_label),
-		     _("System is running on battery power\nBattery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));
+		     _("System is running on battery power.\n Battery: %d%% (%s) [%d:%d =
remain]"),
+		     batt_life, _(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	 } else {
 	    snprintf(new_label, sizeof(new_label),
-		     _("System is running on AC power\nBattery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));
+		     _("System is running on AC power.\n Battery: %d%% (%s) [%d:%d remai=
n]"),
+		     batt_life, _(status[batt_state]), batt_remain_Hr, batt_remain_Min);
 	 }
       } else {
 	 if(acline_status =3D=3D 0) {
@@ -615,16 +623,16 @@
 	       snprintf(new_string, sizeof(new_string),=20
 			/* This string will display as a tooltip over the battery frame
 			 when the computer is using battery power.*/
-			_("System is running on battery power. Battery: %d%% (%s)"),
+			_("System is running on battery power.\n Battery: %d%% (%s) [%d:%d rema=
in]"),
 			batt_life,
-			_(status[batt_state]));
+			_(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	    } else {
 	       snprintf(new_string, sizeof(new_string),=20
 			/* This string will display as a tooltip over the battery frame
 			 when the computer is using AC power.*/
-			_("System is running on AC power. Battery: %d%% (%s)"),
+			_("System is running on AC power. Battery: %d%% (%s) [%d:%d remain]"),
 			batt_life,
-			_(status[batt_state]));
+			_(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	    }
 	 } else {
 	    if(acline_status =3D=3D 0) {
@@ -648,9 +656,9 @@
 		    /* Displayed as a tooltip over the battery meter when there is
 		     a battery present. %d will hold the current charge and %s will
 		     hold the status of the battery, (High, Low, Critical, Charging. */
-		    (_("Battery: %d%% (%s)")),
+		    (_("Battery: %d%% (%s) [%d:%d remain]")),
 		    batt_life,
-		    _(status[batt_state]));
+		    _(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	 } else {
 	    snprintf(new_string, sizeof(new_string),=20
 		     /* Displayed as a tooltip over the battery meter when no
@@ -668,7 +676,8 @@
 			   gettext(new_string),
 			   NULL);
      =20
-      if (DEBUG) printf("Percent: %d, Status: %s\n", batt_life, status[bat=
t_state]);
+      if (DEBUG) printf("Percent: %d [%d:%d remain], Status: %s\n", batt_l=
ife, batt_remain_Hr,
+      batt_remain_Min, status[batt_state]);
    }
=20
    last_charging =3D charging;
@@ -795,6 +804,8 @@
    guint acline_status;
    guint batt_state;
    guint batt_life;
+   guint batt_remain_Hr;
+   guint batt_remain_Min;
    gchar *status[]=3D{
       /* The following four messages will be displayed as tooltips over
        the battery meter. =20
@@ -824,6 +835,8 @@
    acline_status =3D apminfo.ac_line_status ? 1 : 0;
    batt_state =3D apminfo.battery_status;
    batt_life =3D apminfo.battery_percentage;
+   batt_remain_Hr =3D (guint) apminfo.battery_time / 60;
+   batt_remain_Min =3D (guint) apminfo.battery_time % 60;
 #else
    acline_status =3D 1;
    batt_state =3D 0;
@@ -893,15 +906,15 @@
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using battery power and the battery meter
 		      and percent meter is hidden by the user.*/
-		     _("System is running on battery power. Battery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));
+		     _("System is running on battery power.\n Battery: %d%% (%s) [%d:%d =
remain]"),
+		     batt_life, _(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	 } else {
 	    snprintf(new_label, sizeof(new_label),
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using AC power and the battery meter
 		      and percent meter is hidden by the user.*/
-		     _("System is running on AC power. Battery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));     =20
+		     _("System is running on AC power.\n Battery: %d%% (%s) [%d:%d remai=
n]"),
+		     batt_life, _(status[batt_state]),batt_remain_Hr, batt_remain_Min); =
    =20
 	 }
 	 gtk_tooltips_set_tip (battstat->ac_tip,
 			       battstat->eventstatus,
@@ -973,16 +986,16 @@
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using battery power and the battery meter
 		      and percent meter is hidden by the user.*/
-		     _("System is running on battery power\nBattery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));
+		     _("System is running on battery power.\n Battery: %d%% (%s) [%d:%d =
remain]"),
+		     batt_life, _(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	 } else {
 	    /* 1 =3D AC power. I should really test it explicitly here. */
 	    snprintf(new_label, sizeof(new_label),
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using AC power and the battery meter
 		      and percent meter is hidden by the user.*/
-		     _("System is running on AC power\nBattery: %d%% (%s)"),
-		     batt_life, _(status[batt_state]));
+		     _("System is running on AC power.\n Battery: %d%% (%s) [%d:%d remai=
n]"),
+		     batt_life, _(status[batt_state]),batt_remain_Hr, batt_remain_Min);
 	 }
 	 gtk_tooltips_set_tip (battstat->ac_tip,
 			       battstat->eventstatus,
@@ -994,13 +1007,13 @@
 	    snprintf(new_label, sizeof(new_label),
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using battery power.*/
-		     _("System is running on battery power"));
+		     _("System is running on battery power."));
 	 } else {
 	    /* 1 =3D AC power. I should really test it explicitly here. */
 	    snprintf(new_label, sizeof(new_label),
 		     /* This string will display as a tooltip over the status frame
 		      when the computer is using AC power.*/
-		     _("System is running on AC power"));
+		     _("System is running on AC power."));
 	 }
 	 gtk_tooltips_set_tip (battstat->ac_tip,
 			       battstat->eventstatus,

--=-lyArghpNghmzxmmHaIt9--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
