From: =?iso-8859-1?q?Praveen=20C?= <cpravn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: acpi on r40e
Date: Thu, 18 Mar 2004 15:27:43 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040318152743.81889.qmail@web14525.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,
I posted to this list about acpi problems on r40e. The processor module
was causing the system to hang and I found that cpu power management
was the cause of the trouble. So in drivers/acpi/processor.c, in
function acpi_processor_add(), I disabled power managment by setting
the power flag to zero as follows:

    /*
      Install the idle handler if processor power management is
supported.
      Note that the default idle handler (default_idle) will be used on

      platforms that only support C1.
     */
    pr->flags.power = 0; //Disable cpu power management for r40e
    if ((pr->id == 0) && (pr->flags.power)) {
        pm_idle_save = pm_idle;
        pm_idle = acpi_processor_idle;
    }

With this change the processor module does not hang. But the system is
always in C1 and it becomes hot (~50C) even when there is no load. Here
is

cat /proc/acpi/processor/cpu/*

processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000]
usage[00000000]
    C2:                  promotion[C3] demotion[C1] latency[003]
usage[00000000]
    C3:                  promotion[--] demotion[C2] latency[250]
usage[00000000]
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

I hope someone can find a solution for this.
Thanks
praveen

=====
http://www.cpraveen.tk/

________________________________________________________________________
Yahoo! India Insurance Special: Be informed on the best policies, services, tools and more. 
Go to: http://in.insurance.yahoo.com/licspecial/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
