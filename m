From: "Jose E. Marchesi" <jemarch-XoAB7pn3pwgdnm+yROfE0A@public.gmane.org>
Subject: some fan questions
Date: Tue, 3 Sep 2002 11:06:16 GMT
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209031106.LAA18605@es.gnu.org>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I have some questions about ACPI and the fan control. I run a GNU 
System (Debian Woody) over a Linux kernel 2.4.18.

In /proc/acpi/thermal_zone/THRM/trip_points:

critical (S5):           100 C
passive:                 92 C: tc1=2 tc2=5 tsp=300 devices=0xcffe0d68 
active[0]:               100 C: devices=0xc143c6c8 

I think 100 C is too hot for my system! How can i change these 
values? Can i add new trippoints? 

By the way, when i do:

  echo -n 0 > /proc/acpi/fan/FAN/state

the state change to 'on', but the machine fan doesnt start.

I have an HP OmniBook XE3.

Thanks in advance!

--
Jose E. Marchesi <jemarch-mXXj517/zsQ@public.gmane.org>
GNU Spain        http://es.gnu.org
GNUs Not Unix!   http://www.gnu.org
--
"And if cynics ridicule freedom, ridicule community... if 'hard nosed
realists' say that profit is the only ideal...just ignore them, and
use copyleft all the same." -- RMS
---




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
