From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: New Smart Battery release (incl. updated embedded controller patches)
Date: Sat, 12 Nov 2005 23:14:08 -0500
Message-ID: <4376BD90.5080603@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


I'm pleased to announce that, after quite a long period of inactivity, I've 
finally managed to grab enough spare time from the real world to bring the 
SBS-CM (Smart Battery System/Control Method) project up to date.

Those relying on this project to check their battery status (primarily on Acer 
laptops) can now grab the sbs-cm-20051112 release of SBS-CM from the Sourceforge 
download page:

https://sourceforge.net/project/showfiles.php?group_id=129330

In this new release, I haven't made any changes to the DSDT stuff. However, I've 
included new patches for replacing the spinlock mutexing in the embedded 
controller (EC) driver with semaphore mutexing. In addition to the kernel 2.6.10 
and 2.6.11 patches included in previous releases, I now provide patches for 
2.6.12. 2.6.13 and 2.6.14 kernels. I intend to offer a 2.6.15 patch once this 
kernel version becomes the current version.

Why are these patches still necessary? Yuming Lu has done some great work 
getting EC burst mode working under Linux; I believe all kernels since 2.6.13 
contain the burst mode code by default. Unfortunately, however, burst mode does 
not fix the problems that the spinlock patches were designed to fix.

To be specific: I have fixed my kernel (2.6.13) with Yuming's most recent patch 
that prevents the boot process from stalling when the EC driver is loaded. 
Booting with burst mode enabled (boot parameter ec_burst=1) gets into immediate 
trouble if I have the thermal zone ACPI driver loaded, since my computer thinks 
the cpu is at 250C. This is indicative that the EC is not working properly.

Then, after disabling the thermal zone stuff, my computer boots up OK but still 
shows all the symptoms of lost interrupts. Furthermore, after 10 minutes of 
uptime, I notice that the kacpid task has expended nearly 3 seconds of CPU time. 
This expenditure is wholly due to the EC access, and indicates that for 3 
seconds out of 10 minutes, the EC burst code is not interruptible -- hence the 
lost interrupts.

While I will certainly agree that my own patches are not nearly as elegant as 
the burst mode solution, I must point out that they do not lead to any lost 
interrupts at all -- I don't lose any keypresses, and the kacpid task doesn't 
use up any CPU time.

I would really appreciate it if those involved in maintaining the EC code --- 
both Yuming and perhaps Len Brown --- could get in touch with me and help sort 
out a way to get EC burst mode working without lost interrupts. When that's 
done, I'll feel much more comfortable about focusing on porting my SBS stuff to 
the HAL, which is where it belongs.

Best wishes,

Rich T


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
