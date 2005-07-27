From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: AE_NO_MEMORY <--- What it means, is there a fix?
Date: Wed, 27 Jul 2005 18:15:30 -0500
Message-ID: <200507271815.30711.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a laptop which came with 2 memory modules 256MB each. These modules run 
at 400Mhz. Today, I bought a 1GB at 533Mhz memory module. I know that this 
module is supported by my system, and the system runs fine and is a little 
faster. But, two problems came up. The first one is minor problem, and it has 
to do with the Fn button. In Linux I was able to change the brightness of the 
monitor with the Fn button and the up and down arrow keys, but know I can not 
anymore. Of course, in Windows I do not have these problem. 

The second problem is a serious one.  dmesg gives a lot of messages about the 
"AE_NO_MEMORY". Here is the message:

Does anybody know what it means? Is it because I have only one memory module 
and not two? The company sells systems with 1 memory module

Thank you,
Vasilis


ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD01._ADR] 
(Node dfea9700), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD01._ADR] 
(Node dfea9700), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD02._ADR] 
(Node dfea9660), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD02._ADR] 
(Node dfea9660), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD03._ADR] 
(Node dfea95c0), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD03._ADR] 
(Node dfea95c0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD04._ADR] 
(Node dfea9520), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD04._ADR] 
(Node dfea9520), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD05._ADR] 
(Node dfea9480), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.GFX0.DD05._ADR] 
(Node dfea9480), AE_NO_MEMORY
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.HPET._STA] 
(Node dfea7f80), AE_NO_MEMORY
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: Device [P_D1] status [00000008]: functional but not present; setting 
present
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.HPET._STA] 
(Node dfea7f80), AE_NO_MEMORY
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.LPC0.HPET._STA] 
(Node dfea7f80), AE_NO_MEMORY
pnp: PnP ACPI: found 8 devices
.......
input: PS/2 Generic Mouse on synaptics-pt/serio0
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
.......
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
ReiserFS: hda8: using ordered data mode
.....
ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0F] 
(Node dfea56c0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0F] 
(Node dfea56c0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY
    ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC0_._Q0E] 
(Node dfea56a0), AE_NO_MEMORY




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
