From: Preston Lord <webmaster-xSlfl9GhdHA@public.gmane.org>
Subject: toshiba_acpi.o failed
Date: 13 May 2003 01:53:12 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052812391.2390.35.camel@zipur.doublet>
References: <1052804863.1925.4.camel@zipur.doublet>
	 <3EC0AB25.3020300@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EC0AB25.3020300-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
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

OK, I have managed that... now I am stumped.. after disassembling the
DSDT I realize Holy $h!7 ... I havent a clue on what to change in there!

I do have another question. After upgrading to the 2.4.20 kernel I
notice the following in my boot log, mabey I have another simpler
problem?: (I have an Acer TM430 Laptop)

=======================================================================
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
=======================================================================


Please tell me that I am close LOL...

Preston


On Tue, 2003-05-13 at 02:21, sjb wrote:
> Preston Lord wrote:
> 
> > :( tell me it aint so... is there an older version of this util that
> > will allow be to disassemble and reassemble my DSDT?
> 
> Hi,
> 
> you can make your own iasl from the source code at Intel.
> 
> http://www.intel.com/technology/iapc/acpi/downloads.htm
> 
> Worked for me ;-)
> 
> sjb
> 
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
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
