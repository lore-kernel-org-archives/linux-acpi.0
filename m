From: Matteo Sgalaberni <sgala-QJaAV1IlLTQAvxtiuMwx3w@public.gmane.org>
Subject: asus M5636NBP fan always on
Date: Sun, 27 Nov 2005 17:19:22 +0100
Message-ID: <20051127161922.GM24446@sgala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello! I'm running debian sid on my asus M5636NBP.

Kernel 2.6.13.2 patched with Suspend2 2.2-rc7

My fan it's always on.. only if I put the laptop outside with the 
snow...when it' reach 20 celsius the fan stops...

cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           115 C
passive:                 105 C: tc1=2 tc2=10 tsp=100 devices=0xc14706a0
active[0]:               20 C: devices=0xc1477480

I tryed to change this settings echoing new values but no feedback by 
the fan..
I tryed to set /proc/acpi/fan/FN00/state to 1, 2 ,3 ,4 but no feedback...

I have alse loaded the module asus-acpi
asus_acpi              11540  0
(it seems not used...)

# acpi -V
     Battery 1: charged, 100%
     Thermal 1: active[0], 43.0 degrees C
  AC Adapter 1: on-line

My battery now reach max 1 hour of uptime... i think that it's a low time...

Have you some ideas?

Thanks

Matteo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
