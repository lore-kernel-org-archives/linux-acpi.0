From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: does cpu_idle() halt CPU?
Date: Fri, 28 Mar 2003 14:43:32 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D88@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jun Sun [mailto:jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org] 

> [root@localhost root]# cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] 
> latency[000] usage[00000690]   *C2:                  
> promotion[C3] demotion[C1] latency[010] usage[00196669]    
> C3:                  promotion[--] demotion[C2] latency[130] 
> usage[00000000]

Your system either doesn't support C3, or the constant bus master
activity is keeping it out of C3. USB can cause this, but also AC97.

> > - What does the ACPI: Processor line say in your dmesg say?

There should be a line that says, "ACPI: Processor found (x perf states
y throttle)" Is that there? It may be occurring later on in the boot
process.

> > What kind of laptop do you have? Does it support SpeedStep, 
> PowerNow, or
> > the like?
> 
> My laptop is Fujitsu S6110.  CPU supports speedstep.

Getting into the lowest SpeedStep state will help battery life. You may
want to investigate the cpufreq project.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
