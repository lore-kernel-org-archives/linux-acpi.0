From: Preston Lord <webmaster-xSlfl9GhdHA@public.gmane.org>
Subject: Re: toshiba_acpi.o failed
Date: 13 May 2003 02:10:39 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052813439.2390.40.camel@zipur.doublet>
References: <1052804863.1925.4.camel@zipur.doublet>
	 <3EC0AB25.3020300@ottaky.com> <1052812391.2390.35.camel@zipur.doublet>
	 <3EC0B400.3040807@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EC0B400.3040807-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I read that article and cant get it figured out... I will keep working
at it. I have a feeling I am missing something simple. What does the
following supposed to tell me? How do I correct the "No Such Device?"
errors? LOL, I love linux, but $h!7 he he..

Loading ACPI modules (ac fan processor insmod:
/lib/modules/2.4.20-4GB/kernel/drivers/acpi/toshiba_acpi.o: init_module:
No such device


insmod: Hint: insmod errors can be caused by incorrect module
parameters, including invalid IO or IRQ parameters.

      You may find more information in syslog or the output from dmesg


insmod: /lib/modules/2.4.20-4GB/kernel/drivers/acpi/toshiba_acpi.o:
insmod /lib/modules/2.4.20-4GB/kernel/drivers/acpi/toshiba_acpi.o failed


insmod: /lib/modules/2.4.20-4GB/kernel/drivers/acpi/toshiba_acpi.o:
insmod toshiba_acpi failed


battery thermal button ) 
done

Starting acpid <notice>
done







On Tue, 2003-05-13 at 02:59, sjb wrote:
> Preston Lord wrote:
> 
> > OK, I have managed that... now I am stumped.. after disassembling the
> > DSDT I realize Holy $h!7 ... I havent a clue on what to change in there!
> 
> Frankly, neither did I .. but thanks to the efforts and perseverence of 
> a couple of list members I have a fixed (but untested) dsdt for my U1.
> 
> There's a useful page here BTW
> 
> http://www.cpqlinux.com/acpi-howto.html
> 
> that may help you fix the more obvious errors.
> 
> sjb
-- 
Preston Lord
Programmer/Developer/Network Specialist
Double "T" Computer Services
SK, CA Ph.1.306.773.2054
==============================
http://www.t2.net (Hosting)
http://www.dinamicweb.com (iHTML Driven Dropsites)
http://www.ebboard.ca (iHTML Discussion Forum Software)





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
