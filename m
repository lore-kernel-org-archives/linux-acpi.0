From: Philipp Matthias Hahn <pmhahn-u4khhh1J0LzF41mA0N3lWw@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Sat, 21 Sep 2002 19:07:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020921170743.GA13738@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

"Grover, Andrew" wrote:
> The main issues of importance are:
> 
> - DOES IT BOOT?
> - DOES IT ASSIGN INTERRUPTS PROPERLY?

I have an ASUS L8400B Notebook with a slightly patched DSDT, which boots
and assigns innterrupts fine.

But I get the following messages for "echo 1 > sleep":

ACPI-0102 Could not acquire interpreter mutex
ACPI-0140 Could not release interpreter mutex

Any idea where the problem might be ?


Our Fujitsu-Siemens Desktop-PCs boot and assign interrupts, but
acpi-interrupts are generated like crazy:

$ cat /proc/uptime /proc/interrupts 
1052.20 753.82
           CPU0       
  0:     105220    IO-APIC-edge  timer
  1:       1349    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          3    IO-APIC-edge  rtc
  9:   76381891   IO-APIC-level  acpi
 12:       2002    IO-APIC-edge  PS/2 Mouse
 14:      10206    IO-APIC-edge  ide0
 15:         12    IO-APIC-edge  ide1
 17:       8996   IO-APIC-level  Intel ICH2
 19:         92   IO-APIC-level  usb-uhci
 20:       1126   IO-APIC-level  eth0
 23:          0   IO-APIC-level  usb-uhci
NMI:          0 
LOC:     105176 
ERR:          0
MIS:          0


All DSDT/DMI are available from http://pint.pmhahn.de/pmhahn/misc/

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn-u4khhh1J0LzF41mA0N3lWw@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
