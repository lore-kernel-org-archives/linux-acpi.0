From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: Fixing broken DSDT - code suggestions for comment please!
Date: Sun, 16 May 2004 10:29:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40A73460.2070407@mesias.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi ACPI list,

I have been trying to get ACPI running on my laptop but have found there 
are problems with the DSDT. I have followed some instructions on getting 
iasl and recompiling the DSDT but find some errors that go beyond the 
scope of the list at:

http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt

The errors are:


dsdt.dsl  2149:                     Store (Local0, Local0)
Error    1013 -                                 ^ Method local variable 
is not initialized (Local0)

This occurs several times in the code, a typical case is:

                 Method (_PS0, 0, NotSerialized)
                 {
                     Store (And (0xF0, TIA4), TIA4)
                     Store (0x01, _PSC)
                     Store (Local0, Local0)
                 }

I'm guessing that is effectively a NOP so I can comment it out.

Later there are two other errors not mentioned in the FAQ:

dsdt.dsl  2390:                     Return (WQS (0x0E, Arg0))
Error    1029 -                               ^ Called method returns no 
value
 

dsdt.dsl  2395:                     Return (WQSB (0x0E, Arg0))
Error    1029 - Called method returns no value ^
 


The offending code is:

                 Method (WENR, 1, NotSerialized)
                 {
                     Return (WQS (0x0E, Arg0))
                 }

                 Method (WETR, 1, NotSerialized)
                 {
                     Return (WQSB (0x0E, Arg0))
                 }

All the calls to those methods seem to discard any return value, eg:

         If (\_SB.OKEC)
         {
             \_SB.PCI0.QSB.WENR (0x01F0)
         }

I couldn't find a reference to WETR



So I thought to not return anything:

                 Method (WENR, 1, NotSerialized)
                 {
/*                    Return (WQS (0x0E, Arg0))*/
                     WQS (0x0E, Arg0)
                 }

                 Method (WETR, 1, NotSerialized)
                 {
/*                    Return (WQSB (0x0E, Arg0))*/
                     WQSB (0x0E, Arg0)
                 }

I am more than a bit wary about trying this for real so would appreciate 
  any comments on the dsdt code above. If the fixes are good then maybe 
they could be incorporated into the FAQ?

Any comments gratefully received,

-Cam


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
