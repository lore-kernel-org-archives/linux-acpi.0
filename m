From: Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Subject: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron 8200)
Date: Wed, 18 Feb 2004 13:20:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402181320.29381.mailinglists@glomann.de>
Reply-To: mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
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

Hello,

I am running a Dell Inspiron 8200 laptop with a gentoo linux.
Since my first experiments with kernel 2.6 I always experience a high noise 
frequency noise coming back right corner (psu?) of my laptop. 
This happens with every 2.6 kernel i have tried so far. Currently it is 2.6.2.

This is definitely related to the ACPI system in the 2.6 kernels !  If i boot 
a kernel with the "acpi=off" option, then the noise is gone. 

And there is also a very strange thing. This sound occurs only in kernel 2.6.  
A 2.4 kernel patched with ACPI does NOT produce that sound.

I haven't found any related information here in this mailing list (archive) 
but in the kernel mailing list, there you can find some posts describing 
exactly the same behavior.  Someone suggested to use "apm=ide-treshold=100" 
as kernel option. But that didn't help, nor unloading thermal.o. 
(google for "high pitch noise" , there you will that thread)

And there's two more things:

# The noise is somewhat linked to the CPU clock. I have a mobile P4 processor   
with 2 performance profiles : 2000 and 1200 Mhz. The noise becomes quieter 
when changing to 1200 Mhz but it still is there. just not that loud as with 
the default 2000 Mhz. 

# The noise disappears when my hdd is under heavy load.

I really like to get rid off that annoying sound. I can't bear it though it is 
only faint. For now, I use kernel 2.4 but I really want to switch to 2.6 and 
have acpi enabled of course.


Please help me !



Thanks a lot !


regards

Thomas Glomann
Regensburg, Germany


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
