From: Dennis Campbell <denniscampbell-S0/GAf8tV78@public.gmane.org>
Subject: Re: acpi4asus compile problems
Date: Thu, 27 May 2004 16:06:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405271606.19168.denniscampbell@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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

>> Hi all,
>> I have a problem compiling acpi4asus-0.28.
>> I have a suse 9.1 system. 
>> when trying to compile I get an error that the header file modsetver.h      
>> doesn"t 
>> exist. SuSE has removed this file from the kernel source. Maybe you know a 
>> workaround.
 
> Hi,
> Please supply the exact make output, as well as kernel package version.
> Best regards,
 
> -- 
> Karol "sziwan" Kozimor
> sziwan-617MVNTZQqg@public.gmane.org

Here is my make output:
make -C driver
make[1]: Entering directory `/home/dc/Desktop/ACPI/acpi4asus-0.28/driver'
make[2]: Entering directory `/home/dc/Desktop/ACPI/acpi4asus-0.28/driver'
gcc -DLINUX -D__KERNEL__ -DMODULE -I/usr/src/linux/include `./get_include.sh 
/usr/src/linux/drivers/acpi /usr/src/linux/include/acpi` -Wall 
-Wstrict-prototypes -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-O2 -fomit-frame-pointer -DMODVERSIONS -include 
/usr/src/linux/include/linux/modsetver.h -DKBUILD_BASENAME=asus_core 
-DKBUILD_MODNAME=asus_acpi -M *.c > .depend
make[2]: Leaving directory `/home/dc/Desktop/ACPI/acpi4asus-0.28/driver'
gcc -DLINUX -D__KERNEL__ -DMODULE -I/usr/src/linux/include `./get_include.sh 
/usr/src/linux/drivers/acpi /usr/src/linux/include/acpi` -Wall 
-Wstrict-prototypes -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-O2 -fomit-frame-pointer -DMODVERSIONS -include 
/usr/src/linux/include/linux/modsetver.h -DKBUILD_BASENAME=asus_core 
-DKBUILD_MODNAME=asus_acpi   -c -o asus_core.o asus_core.c
make[1]: Leaving directory `/home/dc/Desktop/ACPI/acpi4asus-0.28/driver'
<command line>:138984845:48592: /usr/src/linux/include/linux/modsetver.h: No 
such file or directory
make[2]: *** [dep] Error 1
<command line>:138984845:48592: /usr/src/linux/include/linux/modsetver.h: No 
such file or directory
make[1]: *** [asus_core.o] Error 1
make: *** [build] Error 2

My kernel package version is:
Linux 2.6.4-54.5

I hope you can help
Thanx 
Dennis




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
