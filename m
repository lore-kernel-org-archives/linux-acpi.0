From: SLIVER <sliver-qqXEv8jiLWqhPH1hqNUYSQ@public.gmane.org>
Subject: Problem with Compaq Evo N110
Date: Thu, 22 Aug 2002 15:28:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.2.20020822145413.00aa39f0@mail.olografix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hello.
I have a problem to work ACPI on my laptop because the pc doesn't find the 
battery and other device
You can download my stuffs at http://nirvana.cuore.org/acpi/ (the dump 
obtained with pmtools and other information)
My laptop is Compaq Evo N110 with Slackware Linux 2.4.18 + latest kernel 
patch (pentium Celeron)
you can help me? :D

Thanks for the support :)

Luca Memini
ps: Sorry for the my horrible english :|

----// Session Log
dreams@norad:~$ uname -a
Linux norad 2.4.18 #4 Thu Aug 8 17:37:03 CEST 2002 i686 unknown

dreams@norad:~$ acpi -V
No support for device type: battery
No support for device type: thermal
No support for device type: ac_adapter

dreams@norad:~$ ls /proc/acpi/
alarm  button  debug_layer  debug_level  dsdt  embedded_controller  event 
fadt  info  power_resource  processor  sleep
---// End


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L'artista si riconosce perche' a  differenza della gente
comune  e' riuscito a rimanere bambino.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HomePage avaible: http://www.olografix.org/sliver
Webmaster: http://www.cuore.org, http://www.lasintesi.org
Project: http://disastro.cuore.org/
PGP Public Key available: http://www.olografix.org/sliver



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
