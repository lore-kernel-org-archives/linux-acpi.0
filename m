From: Alexander Nyberg <alexn-auIyqT/O9BSzQB+pC5nmwQ@public.gmane.org>
Subject: ACPI-1138: *** Error: Method execution failed
Date: Fri, 07 Jan 2005 15:36:17 +0100
Message-ID: <1105108577.697.12.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi!

These "Method execution failed" messages haven't turned up before and I just noticed them,
I don't think I ever saw them in 2.6.9. Running 2.6-bk now.

I'm clueless on acpi so if you need any debugging info please tell.


checking TSC synchronization across 2 CPUs: passed.
time.c: Using HPET based timekeeping.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
CPU1:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041210
    ACPI-1138: *** Error: Method execution failed [\MCTH] (Node ffff81003ffd2a30), AE_AML_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\OSFL] (Node ffff81003ffd2a88), AE_AML_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\GPRW] (Node ffff81003ffd29d8), AE_AML_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2K._PRW] (Node ffff81003ffd0f00), AE_AML_BUFFER_LIMIT
    ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2K._PRW] (Node ffff81003ffd0f00), AE_AML_BUFFER_LIMIT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
