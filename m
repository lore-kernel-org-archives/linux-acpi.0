From: nicolas.olivero-39ZsbGIQGT5GWvitb5QawA@public.gmane.org
Subject: acpi on medion laptop
Date: Sat, 18 Oct 2003 16:19:22 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <8359593.1066486762312.JavaMail.www@wwinf0103>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
I have some problems to make work acpi on my new laptop.
I have just install mandrake9.2.
In order to have acpi, i compile my own kernel 2.4.22 with the last
patch acpi.
 
extraxt of my .config :
#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_RELAXED_AML is not set
 
After booting on my new kernel, i notice that my fan works less often
than before and as i can't see the temperature i'm anxious for my laptop....
 
The good thing is that now i can see the level of my battery .
 
[root@localhost han]# acpi -V
     Battery 1: charging, 88%, 00:50:20 until charged
No support for device type: thermal
  AC Adapter 1: on-line
 
[root@localhost han]# acpid
acpid: can't open /proc/acpi/event: Device or resource busy
 
[root@localhost han]# modprobe thermal
modprobe: Can't locate module thermal
 
 
But i can't see the temperature of my computer...
How can i make this work fine?
 
Here is my dmesg log
 
Thanks for any help.
 
[root@localhost han]# dmesg | grep ACPI
 BIOS-e820: 000000000dff0000 - 000000000dffffc0 (ACPI data)
 BIOS-e820: 000000000dffffc0 - 000000000e000000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010100) @ 0x0dfffbc0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010100) @ 0x0dfffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010100) @ 0x0dfffb50
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010100) @ 0x0dfffb80
ACPI: DSDT (v001 INSYDE   VT8372 0x00001000 INTL 0x02002025) @ 0x00000000
ACPI: Subsystem revision 20030918
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c02d6e7c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...................................... [ACPI Debug] String: LPT_STA
.[ACPI Debug] String: ECP_STA
.[ACPI Debug] String: FIR_STA
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[ACPI Debug] String: LPT_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: ECP_STA
[ACPI Debug] String: FIR_STA
[ACPI Debug] String: FIR_STA
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
[ACPI Debug] Integer: 0000000000000001
ACPI: AC Adapter [AC] (on-line)
[ACPI Debug] Integer: 000000000000001F
[ACPI Debug] Package: Elements Ptr - c12aa6e8
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - cb574c68
[ACPI Debug] Package: Elements Ptr - cb5743e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - cb574ce8
[ACPI Debug] Package: Elements Ptr - cb5749e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - cb5749e8
[ACPI Debug] Package: Elements Ptr - cb5743e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - c12d49e8
[ACPI Debug] Package: Elements Ptr - cb5749e8
[ACPI Debug] Package: Elements Ptr - cb574ce8
[ACPI Debug] Integer: 0000000000000001


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
