From: Mark Russell <markarussell-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: ACPI CPU Usage problems ( events process taking near 100% )
Date: Fri, 2 Jan 2004 20:20:42 -0700 (GMT-07:00)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <27441069.1073100042475.JavaMail.root@thecount.psp.pas.earthlink.net>
Reply-To: Mark Russell <markarussell-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have search google and scanned the mailing list archive and have not yet found the solution for this.
 
Here is my case. I have a Toshiba Satellite Pro 6000 laptop. I just freshly loaded Gentoo linux on the machine. It has previously been loaded and run with Libranet without any problems. I am currently using the new 2.6 kernel. 
 
Whenever ACPI support is enabled I end up with a process 'events/0' that takes near 100% of the cpu, as well as the cpu fan going crazy (ie comes on full speed and doesn't stop till I turn the notebook off). I have disabled all ACPI options except the basic support and that makes no difference. I have disabled APIC support (don't know that it makes a diff). I have also disabled cpu frequency scaling just to make sure. If I completely remove ACPI support from the kernel, or turn it off on boot, then that problem goes away, though turning it off causes other issues. So I know the problem revolves around ACPI but I can't figure out how to fix it. 
 
I have also tried using the mm sources which includes the latest version (20031203) of the ACPI stuff, to no avail. I also ran across a thread that indicated I should try to comment out some code in the evrgnini.c file, but that also didn't do anything. 

I have verified that I'm running the latest bios version as well.  I have also searched google to see if there was a dsdt available for my notebook and I haven't found anything.  
 
Anyone know how to fix this? 
 
Mark Russell


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
