From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Toshiba Satellite 1905S303
Date: Sun, 23 Nov 2003 02:13:57 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FC03405.9040807@techisa.srv.br>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

    Continuing my ongoing saga with this notebook...

    I'm now running kernel 2.4.23.0-1mdk with it.

    Not much has changed, but there was a little improvement: cpufreq 
(p4-clockmod) works:
Nov 23 01:59:26 docmobile kernel: cpufreq: P4/Xeon(TM) CPU On-Demand 
Clock Modulation available

but speedstep-ich doesn't:
Nov 23 01:58:48 docmobile kernel: cpufreq: Intel(R) SpeedStep(TM) for 
this chipset not (yet) available.

and my /proc/acpi/processor/CPU0/info:
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        yes
throttling control:      no
performance management:  no
limit interface:         no


Anyway, the worst problem I have now is the system hanging whenever I 
try to switch the video-out (Fn-F5), which didn't happen with an older 
kernel (2.4.21 from Mandrake 9.1). It appears to generate a kernel 
oops/panic, but I cannot get to it, since this notebook doesn't have a 
serial port, and the one usb serial console patch I found was for kernel 
2.6.

I did try a few different kernel 2.6 revisions (from test7-test9) but 
the behavior is the same. I also tried at least half a dozen 2.4.22 
kernels, with the same result.

Any suggestions on solving this problem are welcome... for now the only 
thing I think would help would be to try 2.6 with an usb serial console 
patch to try and get the kernel panic/oops.

Len, you mentioned earlier that I could implement a thermal_zone through 
AML, do you have any pointers or code examples?

-- 

-- Erico Mendonca
Techisa do Brasil





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
