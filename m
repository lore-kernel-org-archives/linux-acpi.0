From: Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Subject: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 09:18:44 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Has anyone else tried using ACPI with the C1VN or similiar laptops?  I've
recently recompiled my kernel, removing APM and enabling ACPI.  Most
things seem to work fine (battery status and events).  However, when I
start esd or asd to mix audio streams my processor utilization immediately
jumps to ~50% and stays there.  The utilization drops to 15-30% if I set
longrun to maximum rather than variable.  I've verified the utilization
with both "top" and "gkrellm".  However, while top shows that my CPU is
not completely idle, it does not list what is using the CPU.  I've tried
sorting by CPU utilization, but there are still large gaps. As shown by
the following:

CPU states:   0.8% user,  25.7% system,   0.0% nice,  73.5% idle
Mem:    110876K total,   107672K used,     3204K free,     9944K buffers
Swap:   996020K total,        0K used,   996020K free,    48224K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  700 jcollins  15   0   960  960   748 R     1.1  0.8   0:16 top
  591 root      10 -10 39296  30M  2052 S <   0.7 27.8   2:14 XFree86
    1 root       8   0   488  488   424 S     0.0  0.4   0:01 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00
ksoftirqd_CPU0
    4 root       9   0     0    0     0 SW    0.0  0.0   0:00 kswapd

I'm able to run either ESD or ASD with a non-ACPI kernel without these
symptoms and likewise, running the ACPI kernel without ESD or ASD results
in normal CPU utilization.

I've tried both the vanilla ACPI support provided with the 2.4.18 kernel
and the latest patches provided by the ACPI project for the 2.4.18 kernel,
both exhibit the same behaviour.

Any ideas on how to use both ACPI and either ASD or ESD without this high
CPU utilization cropping up?

-- 
Jamin W. Collins


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
