From: Diego Torres Milano -IN3 <diego-j4N0vZCVGdapJuVttbx5JA@public.gmane.org>
Subject: ACPI for 2.4 - performance
Date: 01 Apr 2004 19:49:27 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080859767.22887.35.camel@lxcluster02.e200.arg>
Reply-To: diego-j4N0vZCVGdapJuVttbx5JA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What could be the problem here:

[root-y46ZrhlStoY@public.gmane.org CPU0]# uname -a
... 2.4.22-1.2115.nptl ...
[root-y46ZrhlStoY@public.gmane.org CPU0]# cat info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes
[root-y46ZrhlStoY@public.gmane.org CPU0]# cat performance 
state count:             5
active state:            P0
states:
   *P0:                  1400 MHz, 22000 mW, 100 uS
    P1:                  1200 MHz, 18000 mW, 100 uS
    P2:                  1000 MHz, 14000 mW, 100 uS
    P3:                  800 MHz, 10000 mW, 100 uS
    P4:                  600 MHz, 6000 mW, 100 uS
[root-y46ZrhlStoY@public.gmane.org CPU0]# echo -n 4 > performance
[root-y46ZrhlStoY@public.gmane.org CPU0]# cat performance 
state count:             5
active state:            P0
states:
   *P0:                  1400 MHz, 22000 mW, 100 uS
    P1:                  1200 MHz, 18000 mW, 100 uS
    P2:                  1000 MHz, 14000 mW, 100 uS
    P3:                  800 MHz, 10000 mW, 100 uS
    P4:                  600 MHz, 6000 mW, 100 uS

Even though I tried to set performance level to 4 but remains unchanged.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
