From: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Subject: RE: Power button doesn't give events (Asus TUSL2-C)
Date: 10 Jan 2003 21:13:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1042229630.963.8.camel@paragon.slim>
References: <F760B14C9561B941B89469F59BA3A847137F5B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847137F5B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-01-10 at 19:32, Grover, Andrew wrote:

> Does the output from /proc/interrupts list ACPI anywhere?

Output from cat /proc/interrupts:

           CPU0
  0:      43542    IO-APIC-edge  timer
  1:       1202    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:       2186   IO-APIC-level  acpi
 14:      11092    IO-APIC-edge  ide0
 15:          2    IO-APIC-edge  ide1
 16:      31845   IO-APIC-level  nvidia
 18:       5752   IO-APIC-level  EMU10K1
 19:       5836   IO-APIC-level  usb-uhci
 20:   33097143   IO-APIC-level  eth0
 21:          1   IO-APIC-level  ohci1394
 23:          7   IO-APIC-level  usb-uhci, eth1
NMI:          0
LOC:      43492
ERR:          0
MIS:          0

> Does the interrupt count increase by 1 every time you press a power
> button?

The interrupt count from irq 9 doesn't change when a press the power
button. It doesn't seem the change ever. On my other working systems
(which are non APIC btw) the interrupt count for the ACPI irq changes
regularly.

> What does your dmesg say about discovered buttons?

[root@paragon root]# dmesg |grep Button
ACPI: Power Button (FF) [PWRF]

Hope this helps.

Cheers,

Jurgen





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
