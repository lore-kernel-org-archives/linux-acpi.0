From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: C3 support w/o ARB_DIS (P4-M on i845)
Date: Wed, 12 May 2004 12:25:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040512102527.GA8050@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I've just noticed that FADT shows:
P_LVL2_LAT:       90
P_LVL3_LAT:       300

for my P4-M processor, whereas /proc/acpi/processor/*/power shows:
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00294320]
   *C2:                  promotion[--] demotion[C1] latency[090] usage[02552774]
    C3:                  <not supported>

and /proc/acpi/processor/*/info shows:
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes

So, it seems there is some C3 support, but it is not used due to lack of
bus-mastering control (PM2_CNT_BLK is 0). However, the flags section in the
FADT indicates that WBINVD is supported. The comment in processor.c says
the possibility of using C3 in the absence of ARB_DIS must be investigated.
What is the current status? Any obvious caveats for implementation?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
