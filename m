From: Binary Xerroz <xerroz-BC6XjCpM3eF0abU8S3f8Vti2O/JbrIOy@public.gmane.org>
Subject: Re: ACPI: Battery information?
Date: Tue, 08 Jun 2004 14:37:30 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C6319A.7080707@users.xeroprj.org>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070309050505050701020201"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040608113456.GN13782-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070309050505050701020201
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Bruno Ducrot wrote:
<blockquote cite="mid20040608113456.GN13782-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org" type="cite">
  <pre wrap="">On Tue, Jun 08, 2004 at 03:04:53AM -0700, Binary Xerroz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Ive looked over the battery.c file and modified it quite a bit (nothing
too drastic), however even compiled as a module, it &amp;lt;u&amp;gt;WILL
NOT&amp;lt;/u&amp;gt; detect the second battery unless its booted with it at
boot time. Forgive me as i forget to mention this is a laptop, with a
'hot-swappable' battery/cdrom; It works fine if i boot with second
batery in, then i can swap it in/out with cdrom, and with the
modifications i made to battery.c, it displays battery's and their
status correctly; though booting with the second battery isnt that big
of a deal, it would be nice to be able todo so without that limitation.
Any suggestions? (i can also send my modified battery.c if anyone cares
to take a look).&lt;br&gt;
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think it's more a problem with an ACPI event handling then.  Do you
have an acpidump somewhere to look at ?

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp &gt; acpidmp.out
bzip2 acpidmp.out 

Then mail me the acpidmp.out.bz2

Cheers,

  </pre>
</blockquote>
Included is the output of acpidmp, also i included a diff patch for
kernel 2.6.6, patched with patch from acpi.sf.net<br>
&nbsp;&nbsp;&nbsp; About the battery.c, the main reason for my modifications is
because to me ACPI for linux doesnt expect a battery to be removed
(physically) such as on a laptop. the modified code reruns check
routines to make sure the battery is still there, if not its updated as
no present; before it still showed as present, but had critical status
and such, this patch fixes that and updates accordingly. Double check
routines added to make it work on status update instead of two.<br>
Anything else, let me know.<br>
<br>
Xerroz<br>
<pre class="moz-signature" cols="48">-- 
____  ___            _______   
\   \/  /___________ \   _  \  
 \     // __ \_  __ \/  /_\  \ 
 /     \  ___/|  | \/\  \_/   \
/___/\  \___  &gt;__|    \_____  /
      \_/   \/              \/
01011000 01100101 01110010 01110010 01101111
01111010 00001101 00001010 01111000 00111000
00110110 00100000 01000001 01110011 01110011
01100101 01101101 01100010 01101100 01100101
01110010 00100000 01000011 01101111 01100100
01100101 01110010 00001101 00001010 01000001
00100000 01011100 00100111 01010000 01110010
01101111 01100110 01100101 01110011 01110011
01101001 01101111 01101110 01100001 01101100
01011100 00100111 00000000 00000000 00000000
</pre>
</body>
</html>

--------------070309050505050701020201
Content-Type: application/octet-stream;
 name="acpidump.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="acpidump.bz2"

QlpoOTFBWSZTWfIyrokAAAx//0ZADABR5GAgMEBIMBBAEAgACAAEAQAAYkAEAAQEACAAIx6n
qAGgAHponlPUMMjAmmBMhiaMAZRkrLgfg9C1SNMH1eRIet+XwdDuLTmcEVMlZvxdyRThQkPI
yrok
--------------070309050505050701020201
Content-Type: text/x-patch;
 name="battery.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="battery.c.diff"

62c62
< 
---
> int battery_init = 0;
75d74
< 
306d304
< 
324a323
> 		//return_VALUE('1');
334d332
< 
362c360,361
< 
---
> 	acpi_battery_check(battery);
> 	battery_init = 0;
365c364
< 
---
> recheck:
369,370c368,373
< 		p += sprintf(p, "present:                 no\n");
< 		goto end;
---
> 		
> 		if(battery_init==1) {  p += sprintf(p, "present:                 no\n"); goto end; }
> 			acpi_battery_check(battery);
> 			battery_init++;
> 			goto recheck;
> 		
461c464,465
< 
---
> 	acpi_battery_check(battery);
> 	battery_init = 0;
464a469
> recheck:
468,469c473,477
< 		p += sprintf(p, "present:                 no\n");
< 		goto end;
---
> 		if(battery_init==1) {  p += sprintf(p, "present:                 no\n"); goto end; }
> 			acpi_battery_check(battery);
> 			battery_init++;
> 			goto recheck;
> 		
471d478
< 

--------------070309050505050701020201--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
