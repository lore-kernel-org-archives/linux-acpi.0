From: Pere =?ISO-8859-1?Q?Casta=F1er_Sard=E0?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: Throttling cpu? ACPI patch 09/18 kernel 2.4.19
Date: 20 Nov 2002 15:30:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037802627.470.20.camel@debian.Debian-beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpidevel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I'm so newbie to acpi but I don't find any information to do this.
I have a kernel 2.4.19 +acpi20020918+swsuspbeta15 installed, my laptop
is a clevo 5600N and the acpi works partially.

I need to know how can interprete the information in /proc/acpi.
For example:
--------------------------------------------
-debian:/proc/acpi/processor/CPU0# cat performance 
state count:             2
active state:            P0
states:
   *P0:                  1600 MHz, 20000 mW, 250 uS
    P1:                  1200 MHz, 10000 mW, 250 uS
---------------------------------------------
This can be changed by cpufreq.
---------------------------------------------
-debian:/proc/acpi/processor/CPU0# cat power       
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
C1:     promotion[C2] demotion[--] latency[000] usage[00000010]   
*C2:    promotion[C3] demotion[C1] latency[001] usage[00964461]  
C3:     promotion[--] demotion[C2] latency[085] usage[00000016] 
debian:/proc/acpi/processor/CPU0# 
---------------------------------------------
how can activate state C3?
Where there are info about this?

Thanks for your attention.
-- 
Pere Castañer Sardà
Computer Management Technical Engineering Student on UOC
Member of AEIGi (http://www.aeigi.org)
Linux Registered User #232073 
Debian/GNU User (http://www.debian.org)



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
