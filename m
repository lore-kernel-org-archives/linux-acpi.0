From: =?ISO-8859-1?Q?VOLTZ_st=E9phane?= <svoltz-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Subject: Wakeup code way too big
Date: Sat, 08 Feb 2003 15:10:18 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E451DDA.7010309@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

       Hello,

        while booting 2.5.59, I got the following message :
ACPI: Wakeup code way too big, will crash on attempt to suspend

        I added some printk to arch/i386/kernel/acpi.c in
acpi_reserve_bootmem() to get wakeup_end and wakeup_start values, and I got:

ACPI: have wakeup address 0xc0001000
ACPI: have wakeup_end     0x00000000
ACPI: have wakeup_start   0xffffffb8
                                    
        Which explains the message, but I'm puzzled by the values of
wakeup_end and wakeup_start. I get the same with gcc 3.2 and gcc 2.96.

Any idea on what's going on ?

Regards,
        Stef




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
