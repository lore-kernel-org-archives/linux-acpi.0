From: alfonso_acosta_mail-mRCrAkd8dF0@public.gmane.org
Subject: acpi problems on inspiron 8200
Date: Tue, 24 Dec 2002 02:47:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E07BCCE.60308@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

hi:

I installed last stable kernel patch:
acpi-20021212-2.4.20.diff.gz

on an inspiron 8200 with bios revision A08.

When I load battery module with modprobe I get the following message:
ACPI: Battery Slot [BAT0] (battery absent)
     ACPI-0189: *** Warning: buffer created with zero length in AML
         -0073: *** Error: Ut_allocate: Attempt to allocate zero bytes
     ACPI-0189: *** Warning: buffer created with zero length in AML
         -0073: *** Error: Ut_allocate: Attempt to allocate zero bytes
     ACPI-0189: *** Warning: buffer created with zero length in AML
         -0073: *** Error: Ut_allocate: Attempt to allocate zero bytes 
                 ACPI-0189: *** Warning: buffer created with zero length 
in AML
         -0073: *** Error: Ut_allocate: Attempt to allocate zero bytes
ACPI: Battery Slot [BAT1] (battery present)

It happens the same thing when executing acpi:
     ACPI-0189: *** Warning: buffer created with zero length in AML
         -0073: *** Error: Ut_allocate: Attempt to allocate zero bytes
     //(repeated 8 times)
     Battery 2: unkown, 0% //which isnt true



If close the laptop while using the X window system (using nvidia closed 
drivers), and I open it again I get the same message printed again and 
again in all consoles (/dev/tty*).


Special keys dont work.


Thanks in advance:

ALfonso Acosta

PS: If there's a way I can give more useful information about the 
problem, please let me know

___________________________________________________
Yahoo! Sorteos
Consulta si tu número ha sido premiado en
Yahoo! Sorteos http://loteria.yahoo.es


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
