From: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>
Subject: APIC not enabled on Opteron
Date: Fri, 22 Aug 2003 16:31:02 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F46A7B6.5060706@aslab.com>
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

Hi,

I'm not postive if my problem is being caused by ACPI, but it seems to 
be involved, so I'm posting my questiong here first.  If this is not an 
ACPI issue just let me know.

I have a single processor Operteron motherboard with the Nvidia nforce 3 
chipset.  I am running a 32-bit Linux kernel (2.4.6-test3) and things 
are perfectly stable.  The problem is that the system is running in 
XT-PIC mode even though I enabled Local APIC support.  Here is the 
contents of /proc/interrupts:

            CPU0
   0:      53477          XT-PIC  timer
   1:        115          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  12:         60          XT-PIC  i8042
  14:      62385          XT-PIC  ide0
  15:          1          XT-PIC  ide1
NMI:          0
LOC:      53266
ERR:          0

This may not look too crowded, but when drivers are loaded for all the 
onboard hardware there is a lot of sharing going on.  I also tried 
enabling the IO-APIC, which works, but I still only get 15 IRQs.

The reason I think ACPI is involved is because of this kernel message:

Using ACPI for processor (LAPIC) configuration information

I have attached the full kernel log.  If anyone can give me a clue, I'd 
appreciate it.

Thanks

Mike



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
