From: "Karasyov, Konstantin A" <konstantin.a.karasyov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: asus M5636NBP fan always on
Date: Mon, 28 Nov 2005 17:50:35 +0300
Message-ID: <E124AAE027DA384D8B919F93E4D8C708C22833@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Could you please attach the output files from dmesg, acpidump commands?

Regards.
Konstantin.

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matteo Sgalaberni
>Sent: Sunday, November 27, 2005 7:19 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] asus M5636NBP fan always on
>
>Hello! I'm running debian sid on my asus M5636NBP.
>
>Kernel 2.6.13.2 patched with Suspend2 2.2-rc7
>
>My fan it's always on.. only if I put the laptop outside with the
>snow...when it' reach 20 celsius the fan stops...
>
>cat /proc/acpi/thermal_zone/THRM/trip_points
>critical (S5):           115 C
>passive:                 105 C: tc1=3D2 tc2=3D10 tsp=3D100 =
devices=3D0xc14706a0
>active[0]:               20 C: devices=3D0xc1477480
>
>I tryed to change this settings echoing new values but no feedback by
>the fan..
>I tryed to set /proc/acpi/fan/FN00/state to 1, 2 ,3 ,4 but no
feedback...
>
>I have alse loaded the module asus-acpi
>asus_acpi              11540  0
>(it seems not used...)
>
># acpi -V
>     Battery 1: charged, 100%
>     Thermal 1: active[0], 43.0 degrees C
>  AC Adapter 1: on-line
>
>My battery now reach max 1 hour of uptime... i think that it's a low
>time...
>
>Have you some ideas?
>
>Thanks
>
>Matteo
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log
>files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
