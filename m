From: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Several problems with sleep states
Date: Fri, 27 Feb 2004 11:16:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077876965.10771.15.camel@homer>
References: <403F0BA9.6060905@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <403F0BA9.6060905-L2FTfq7BK8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicolas Sabouret <Nicolas.Sabouret-L2FTfq7BK8M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> 2. echo -n "mem" > /sys/power/state => the computer enters "suspend on 
> ram" mode (the suspend light gets on, etc...) when I try to wake up the 
> computer, it hangs (some noise indicating that the disks are woken up 
> and then nothing but a blank screen, even starting from console).

be sure to disable usb and sound *before* going to sleep. Your
/proc/interrupts give me the idea that you have sound and usb enabled,
which is not good.

Also, if you have a radeon gfx card, you wont get your console frame
buffer back to life yet. If you use the ATI-Binary drivers, you wont get
x11 back to life. If you use the kernel ati drivers for x11 with no
framebuffer, you should be abled to resume an x11 session.

Regards, P.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
