From: Martin Ginkel <martin.ginkel-jy7zG81Tlw8@public.gmane.org>
Subject: Re: Wrong AC state
Date: Thu, 27 May 2004 00:08:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40B5156F.5020409@epost.de>
References: <40B346FC.9090908@mpi-magdeburg.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40B346FC.9090908-VDBW1ITIq+y+DWMCimbbknqWYbMAw+HU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Martin Ginkel wrote:
> On my laptop (Fujitsu-Siemens Amilo D 8830) this seems to be partially 
> broken.
> The /proc/ac_adapter/AC0/state has a value on-line or off-line from 
> boot-time and doesn't change later on.

OK found a solution while reading the disassembled DSDT:
The Code ist checking the OS-Version:

     Method (_PSR, 0, NotSerialized)
     {
       If (LNot (LEqual (FAKE, 0x00)))
       {
         Return (0x00)
       }
       Else
       {
         If (LOr (LEqual (OSFL (), 0x00), LEqual (OSFL (), 0x04)))
           {
              Store (\_SB.PCI0.SBRG.EC0.XCIN, Local0)
                                     }
          Else
           {
              Store (ACIN, Local0)
           }

              Return (Local0)
           }
      }


OSFL is returning 0x00 for win2000 and 0x04 for windows nt.
I defined as a dirty fix:
./include/acpi/platform/aclinux.h:50:
#define ACPI_OS_NAME               "Microsoft Windows NT"

Now the Power Monitor reacts instantly.

Well: the Bios seems to be designed for Microsoft Windows ;-P


	CU
	Martin


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
