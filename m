From: Emilio Mejia Fernandez de Velasco <emejia-EkmVulN54Sk@public.gmane.org>
Subject: Return package for WAK
Date: Mon, 19 Apr 2004 11:54:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404191154.54952.emejia@ieee.org>
Reply-To: emejia-EkmVulN54Sk@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uH6gAulf4xBbDCX"
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


--Boundary-00=_uH6gAulf4xBbDCX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I opened a thread this weekend, but I still haven't solved the problems to 
install acpi in my laptop.
I got a warning when compiling my dsdt, and it is a well known bug of non 
returned value for the function WAK.
In order to skip the warning message, I added a return value with a package 
containing two zeros, but this is not supposed to fix the real bug.
So I don't know which value it should really return, and what is more 
important, I don't know if this can be the cause of the unstability of the 
system.
As I explained in last thread, after some minutes working the laptop freezes, 
and it doesn't respond to the keyboard nor trying to log in remotely with 
ssh, so it makes me reboot with the power button.
I have compiled the kernel with debug messages option, but nothing relevant is 
reported in /var/log/messages, only a periodic set of messages related to the 
thermal zone, but they happen periodically before breaking down, I can't tell 
the moment when it freezes.
Here is the result of dmesg | grep ACPI:
 
BIOS-e820: 0000000016ff0000 - 0000000016fffc00 (ACPI data)
BIOS-e820: 0000000016fffc00 - 0000000017000000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7030
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x16ffba62
ACPI: FADT (v001 VT8603 TWISTER  0x06040000 PTL  0x000f4240) @ 0x16fffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x16fffbd8
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000b) @ 0x00000000
ACPI: Looking for DSDT in initrd ... found customized DSDT with 15240 bytes!
ACPI: Subsystem revision 20040326
ACPI: Using customized DSDT
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
ACPI Namespace successfully loaded at root c03b9ffc
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PFAN] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "ACAD_PSR"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x0F, "ACAD_PSR Return"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] String: Length 0x22, "__________________________________"
ACPI: AC Adapter [ACAD] (on-line)
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x10, "BAT0_BIF_RETURN:"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] Package: Size 0x0D Elements Ptr - d6fecf48
[ACPI Debug] String: Length 0x22, "__________________________________"
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
ACPI: Thermal Zone [THRM] (73 C)
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x000000000000004A
[ACPI Debug] Integer: 0x0000000000000032
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x000000000000004A
[ACPI Debug] Integer: 0x0000000000000044
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"

These four last lines are the ones repeated periodically in 
the /var/log/messages file.

Attached is the dsdt.asl file obtained with acpidump, which doesn't include 
the correction in the WAK function even though I modified it adding a 
returned package with two zeros. Anyway, the dsl file decodified with iasl 
does recognize the changes.
Can anybody please give me any clue about why can the laptop hang?
Can the dsdt table be the problem?
I start with this line in the menu file for grub:
kernel		/boot/vmlinuz-2.6.4 root=/dev/hda2 ro acpi=force noapic 
acpi_os_name="Microsoft Windows XP"
I have also tried with nolapic instead of noapic, but it still freezes

Thank you

Emilio Mejia

--Boundary-00=_uH6gAulf4xBbDCX
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="dsdt.asl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dsdt.asl"

/*
RSD PTR: Checksum=8, OEMID=PTLTD, RsdtAddress=0x16ffba62
 */
/*
RSDT: Length=44, Revision=1, Checksum=187,
	OEMID=PTLTD, OEM Table ID=  RSDT, OEM Revision=0x6040000,
	Creator ID= LTP, Creator Revision=0x0
 */
/*
	Entries={ 0x16fffb64, 0x16fffbd8 }
 */
/*
	DSDT=0x16ffba8e
	INT_MODEL=PIC
	SCI_INT=9
	SMI_CMD=0x802f, ACPI_ENABLE=0xf0, ACPI_DISABLE=0xf1, S4BIOS_REQ=0xf2
	PM1a_EVT_BLK=0x8000-0x8003
	PM1a_CNT_BLK=0x8004-0x8005
	PM2_TMR_BLK=0x8008-0x800b
	PM2_GPE0_BLK=0x8020-0x8023
	P_LVL2_LAT=20ms, P_LVL3_LAT=60ms
	FLUSH_SIZE=0, FLUSH_STRIDE=0
	DUTY_OFFSET=0, DUTY_WIDTH=4
	DAY_ALRM=125, MON_ALRM=126, CENTURY=50
	Flags={WBINVD,PROC_C1,SLP_BUTTON,RTC_S4}
 */
/*
DSDT: Length=16598, Revision=1, Checksum=235,
	OEMID=VIA, OEM Table ID=PTL_ACPI, OEM Revision=0x6040000,
	Creator ID=MSFT, Creator Revision=0x100000b
 */
DefinitionBlock ("acpi_dsdt.aml","DSDT",0x1,"VIA","PTL_ACPI",0x6040000
)

{
Scope(\_PR_) {
    Processor(CPU0, 1, 0x8010, 0x6) {
    }
}
Name(\_S0_, Package(0x2) {
    0x0,
    0x0,
})
Name(\_S1_, Package(0x2) {
    0x4,
    0x4,
})
Name(\_S4_, Package(0x2) {
    0x2,
    0x2,
})
Name(\_S5_, Package(0x2) {
    0x2,
    0x2,
})
Name(UBH1, Buffer(0x5) {0x0, 0x0, 0x0, 0x0, 0x0 })
CreateByteField(UBH1, 0x0, HA04)
CreateByteField(UBH1, 0x1, HA20)
CreateByteField(UBH1, 0x2, HA21)
CreateByteField(UBH1, 0x3, HA22)
CreateByteField(UBH1, 0x4, HA23)
Name(UBH2, Buffer(0x5) {0x0, 0x0, 0x0, 0x0, 0x0 })
CreateByteField(UBH2, 0x0, HB04)
CreateByteField(UBH2, 0x1, HB20)
CreateByteField(UBH2, 0x2, HB21)
CreateByteField(UBH2, 0x3, HB22)
CreateByteField(UBH2, 0x4, HB23)
Method(\_PTS, 1) {
    If(LNot(LEqual(Arg0, 0x5))) {
        BEEP(0x1)
    }
    Store(Zero, \_SB_.PCI0.PM__.GO18)
    If(LEqual(Arg0, 0x1)) {
        \_SB_.VIAX(0x88)
    }
    If(LEqual(Arg0, 0x3)) {
        \_SB_.VIAX(0x80)
        Store(\_SB_.PCI0.USB0.UA04, HA04)
        Store(\_SB_.PCI0.USB0.UA20, HA20)
        Store(\_SB_.PCI0.USB0.UA21, HA21)
        Store(\_SB_.PCI0.USB0.UA22, HA22)
        Store(\_SB_.PCI0.USB0.UA23, HA23)
        Store(\_SB_.PCI0.USB1.UB04, HB04)
        Store(\_SB_.PCI0.USB1.UB20, HB20)
        Store(\_SB_.PCI0.USB1.UB21, HB21)
        Store(\_SB_.PCI0.USB1.UB22, HB22)
        Store(\_SB_.PCI0.USB1.UB23, HB23)
    }
    If(LEqual(Arg0, 0x4)) {
        \_SB_.PCI0.PIB_.PMWT(0xb8, 0x0)
        \_SB_.VIAX(0x81)
    }
    If(LEqual(Arg0, 0x5)) {
        Store(Zero, \_SB_.PCI0.PM__.THON)
    }
}
Method(\_WAK, 1) {
    Store(One, \_SB_.PCI0.PM__.GO18)
    If(LEqual(Arg0, 0x1)) {
        \_SB_.VIAX(0x89)
    }
    If(LEqual(Arg0, 0x3)) {
        \_SB_.VIAX(0x82)
        Store(One, \_SB_.BAT0.FSTA)
        Store(One, \_SB_.BAT0.FBIF)
        Store(HA04, \_SB_.PCI0.USB0.UA04)
        Store(HA20, \_SB_.PCI0.USB0.UA20)
        Store(HA21, \_SB_.PCI0.USB0.UA21)
        Store(HA22, \_SB_.PCI0.USB0.UA22)
        Store(HA23, \_SB_.PCI0.USB0.UA23)
        Store(HB04, \_SB_.PCI0.USB1.UB04)
        Store(HB20, \_SB_.PCI0.USB1.UB20)
        Store(HB21, \_SB_.PCI0.USB1.UB21)
        Store(HB22, \_SB_.PCI0.USB1.UB22)
        Store(HB23, \_SB_.PCI0.USB1.UB23)
        Notify(\_SB_.PWRB, 0x2)
    }
    If(LEqual(Arg0, 0x4)) {
        \_SB_.VIAX(0x83)
        Store(One, \_SB_.BAT0.FSTA)
        Store(One, \_SB_.BAT0.FBIF)
        Notify(\_SB_.PWRB, 0x2)
    }
    BEEP(0x1)
}
Scope(_TZ_) {
    PowerResource(PFAN, 0, 0) {
        Method(_ON_) {
            Store(Zero, \_SB_.PCI0.PM__.GO17)
            Store(One, \_SB_.PCI0.PM__.GO16)
        }
        Method(_OFF) {
            Store(Zero, \_SB_.PCI0.PM__.GO17)
            Store(Zero, \_SB_.PCI0.PM__.GO16)
        }
        Method(_STA) {
            XOr(\_SB_.PCI0.PM__.GO17, One, Local7)
            Return(Local7)
        }
    }
    Device(FAN_) {
        Name(_HID, 0x0b0cd041)
        Name(_PSC, 0x0)
        Method(_PS0) {
            Store(One, \_SB_.PCI0.PM__.GO16)
            Store(0x0, \_SB_.PCI0.PM__.GO17)
            Store(Zero, _PSC)
        }
        Method(_PS1) {
            Store(Zero, \_SB_.PCI0.PM__.GO16)
            Store(0x1, _PSC)
        }
        Method(_PS3) {
            Store(One, \_SB_.PCI0.PM__.GO17)
            Store(0x3, _PSC)
        }
        Name(_PR0, Package(0x1) {
            PFAN,
        })
    }
    ThermalZone(THRM) {
        Name(CRTV, 0x52)
        Name(COLM, 0x0)
        Name(F_ON, 0x0)
        Name(T_ON, 0x0)
        Name(Z000, 0x0)
        Name(Z001, 0x0)
        Name(AC0H, 0x3c)
        Name(PSVV, 0x48)
        Method(_AC0, 0, Serialized) {
            Add(AC0H, 0x0111, Local0)
            Multiply(Local0, 0xa, Local0)
            Return(Local0)
        }
        Name(_AL0, Package(0x1) {
            FAN_,
        })
        Method(_PSV) {
            Add(PSVV, 0x0111, Local0)
            Multiply(Local0, 0xa, Local0)
            Return(Local0)
        }
        Name(_PSL, Package(0x1) {
            \_PR_.CPU0,
        })
        Method(_CRT) {
            Add(CRTV, 0x0111, Local0)
            Multiply(Local0, 0xa, Local0)
            Return(Local0)
        }
        Method(_SCP, 1) {
            Store(Arg0, COLM)
            If(LEqual(Arg0, 0x0)) {
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x0)) {
                    Store(0x37, Z000)
                    Store(0x3c, F_ON)
                    Store(0x47, Z001)
                    Store(0x4b, T_ON)
                }
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x1)) {
                    Store(0x37, Z000)
                    Store(0x3c, F_ON)
                    Store(0x44, Z001)
                    Store(0x48, T_ON)
                }
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x2)) {
                    Store(0x2d, Z000)
                    Store(0x32, F_ON)
                    Store(0x40, Z001)
                    Store(0x44, T_ON)
                }
                Store(F_ON, AC0H)
                Store(T_ON, PSVV)
            }
            Else {
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x0)) {
                    Store(0x37, Z000)
                    Store(0x3c, F_ON)
                    Store(0x47, Z001)
                    Store(0x4b, T_ON)
                }
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x1)) {
                    Store(0x37, Z000)
                    Store(0x3c, F_ON)
                    Store(0x44, Z001)
                    Store(0x48, T_ON)
                }
                If(LEqual(\_SB_.PCI0.PIB_.RTC_.CPUT, 0x2)) {
                    Store(0x2d, Z000)
                    Store(0x32, F_ON)
                    Store(0x40, Z001)
                    Store(0x44, T_ON)
                }
                Store(T_ON, AC0H)
                Store(F_ON, PSVV)
            }
            Notify(\_TZ_.THRM, 0x81)
            Notify(\_TZ_.THRM, 0x80)
        }
        Method(_TMP) {
            SHOW("THRM_TMP")
            Store(\_SB_.PCI0.PIB_.PMRD(0xe7), Local0)
            Multiply(Local0, 0xa, Local0)
            Add(Local0, 0x0aaa, Local0)
            If(LEqual(Local0, 0x0aaa)) {
                Return(0x0b72)
            }
            Else {
                Return(Local0)
            }
            SHOW("THRM_TMP Return")
            SHOW(Local0)
            Return(Local0)
        }
        Name(_TC1, 0x4)
        Name(_TC2, 0x3)
        Name(_TSP, 0x0258)
        Name(MODE, 0x0)
        Name(FANX, 0x0)
        Name(TRLX, 0x0)
    }
}
Scope(\_SI_) {
    Method(_SST, 1) {
        If(LEqual(Arg0, 0x1)) {
            Store("SI_Working", Debug)
        }
        If(LEqual(Arg0, 0x0)) {
            Store(Zero, \_SB_.PCI0.PM__.GPI1)
            Store(One, \_SB_.PCI0.PM__.GPS1)
            Store(Zero, \_SB_.PCI0.PM__.THON)
            And(\_SB_.PCI0.PIB_.PMRD(0xad), 0xfe, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xad, Local5)
            And(\_SB_.PCI0.PIB_.PMRD(0xaf), 0xfc, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xaf, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xa8, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xa9, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xaa, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xab, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xac, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xad, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xae, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xaf, 0x0)
            \_SB_.VIAX(0x8a)
            Store("S5 Shutdown", Debug)
        }
        If(LEqual(Arg0, 0x2)) {
            Store("SI_Waking", Debug)
        }
        If(LEqual(Arg0, 0x4)) {
            Store(Zero, \_SB_.PCI0.PM__.GPI1)
            Store(One, \_SB_.PCI0.PM__.GPS1)
            Store(Zero, \_SB_.PCI0.PM__.THON)
            And(\_SB_.PCI0.PIB_.PMRD(0xad), 0xfe, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xad, Local5)
            And(\_SB_.PCI0.PIB_.PMRD(0xaf), 0xfc, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xaf, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xa8, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xa9, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xaa, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xab, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xac, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xad, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xae, 0x0)
            \_SB_.PCI0.PIB_.PMWT(0xaf, 0x0)
            \_SB_.VIAX(0x8a)
            Store("Sleeping with context saved to non volatile storage", Debug)
        }
        If(LEqual(Arg0, 0x3)) {
            Store("Sleeping. Used to indicate system state S1, S2 or S3", Debug)
        }
    }
}
Scope(_GPE) {
    Mutex(GLCK, 0)
    Method(_L00) {
        Acquire(\_GPE.GLCK, 0xffff)
        \_SB_.VIAX(0x84)
        Release(\_GPE.GLCK)
    }
    Method(_L01) {
        Acquire(\_GPE.GLCK, 0xffff)
        Store(\_SB_.PCI0.PIB_.PMRD(0xab), Local0)
        Store(\_SB_.PCI0.PIB_.PMRD(0xad), Local4)
        Store(Local4, Debug)
        If(And(Local4, 0x1, Local3)) {
            If(LEqual(\_TZ_.THRM.COLM, 0x0)) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xe7), Local4)
                Store(Local4, Debug)
                Store(\_SB_.PCI0.PIB_.PMRD(0xe4), Local5)
                Store(Local5, Debug)
                If(LNot(LLess(Local4, Local5))) {
                    If(LEqual(Local5, \_TZ_.THRM.F_ON)) {
                        HION()
                        \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z000)
                        \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.T_ON)
                    }
                    Else {
                        If(LEqual(Local5, \_TZ_.THRM.T_ON)) {
                            Store(\_TZ_.THRM.Z001, \_TZ_.THRM.PSVV)
                            \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z001)
                            \_SB_.PCI0.PIB_.PMWT(0xe4, 0x52)
                            Notify(\_TZ_.THRM, 0x81)
                            Notify(\_TZ_.THRM, 0x80)
                        }
                        Else {
                            Notify(\_TZ_.THRM, 0x81)
                        }
                    }
                }
                Else {
                    Store(\_SB_.PCI0.PIB_.PMRD(0xe5), Local5)
                    Store(Local5, Debug)
                    If(LNot(LGreater(Local4, Local5))) {
                        If(LEqual(Local5, \_TZ_.THRM.Z000)) {
                            \_TZ_.PFAN._OFF()
                            \_SB_.PCI0.PIB_.PMWT(0xe5, 0x0)
                            \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.F_ON)
                        }
                        Else {
                            If(LEqual(Local5, \_TZ_.THRM.Z001)) {
                                HION()
                                Store(\_TZ_.THRM.T_ON, \_TZ_.THRM.PSVV)
                                \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z000)
                                \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.T_ON)
                                Notify(\_TZ_.THRM, 0x81)
                                Notify(\_TZ_.THRM, 0x80)
                            }
                        }
                    }
                }
            }
            Else {
                Store(\_SB_.PCI0.PIB_.PMRD(0xe7), Local4)
                Store(Local4, Debug)
                Store(\_SB_.PCI0.PIB_.PMRD(0xe4), Local5)
                Store(Local5, Debug)
                If(LNot(LLess(Local4, Local5))) {
                    If(LEqual(Local5, \_TZ_.THRM.F_ON)) {
                        \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z000)
                        \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.T_ON)
                        Store(\_TZ_.THRM.Z000, \_TZ_.THRM.PSVV)
                        Notify(\_TZ_.THRM, 0x81)
                        Notify(\_TZ_.THRM, 0x80)
                    }
                    Else {
                        If(LEqual(Local5, \_TZ_.THRM.T_ON)) {
                            \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z001)
                            \_SB_.PCI0.PIB_.PMWT(0xe4, 0x52)
                            HION()
                            Notify(\_TZ_.THRM, 0x80)
                        }
                        Else {
                            Notify(\_TZ_.THRM, 0x81)
                        }
                    }
                }
                Else {
                    Store(\_SB_.PCI0.PIB_.PMRD(0xe5), Local5)
                    Store(Local5, Debug)
                    If(LNot(LGreater(Local4, Local5))) {
                        If(LEqual(Local5, \_TZ_.THRM.Z000)) {
                            \_SB_.PCI0.PIB_.PMWT(0xe5, 0x0)
                            \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.F_ON)
                            \_TZ_.PFAN._OFF()
                            Store(\_TZ_.THRM.F_ON, \_TZ_.THRM.PSVV)
                            Notify(\_TZ_.THRM, 0x81)
                            Notify(\_TZ_.THRM, 0x80)
                        }
                        Else {
                            If(LEqual(Local5, \_TZ_.THRM.Z001)) {
                                \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z000)
                                \_SB_.PCI0.PIB_.PMWT(0xe4, \_TZ_.THRM.T_ON)
                                \_TZ_.PFAN._OFF()
                            }
                            Else {
                                \_SB_.PCI0.PIB_.PMWT(0xe5, \_TZ_.THRM.Z001)
                                \_SB_.PCI0.PIB_.PMWT(0xe4, 0x52)
                                \_TZ_.PFAN._ON_()
                            }
                        }
                    }
                }
            }
            And(\_SB_.PCI0.PIB_.PMRD(0xad), 0xfe, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xad, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
            And(\_SB_.PCI0.PIB_.PMRD(0xae), 0xfe, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xae, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
            And(\_SB_.PCI0.PIB_.PMRD(0xaf), 0xfc, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xaf, Local5)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
        }
        If(And(Local0, 0x1, Local3)) {
            \_SB_.ACAD._PSR()
            If(LEqual(\_SB_.ACAD.ACFG, 0x1)) {
                \_TZ_.THRM._SCP(Zero)
            }
            Else {
                \_TZ_.THRM._SCP(One)
            }
            Notify(\_SB_.ACAD, 0x80)
            And(\_SB_.PCI0.PIB_.PMRD(0xab), 0xfe, Local2)
            \_SB_.PCI0.PIB_.PMWT(0xab, Local2)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
        }
        If(And(Local0, 0x2, Local3)) {
            Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local1)
            Store(\_SB_.PCI0.PIB_.PMRD(0xf1), Local4)
            If(LNot(LEqual(And(Local1, 0x1, Local3), And(Local4, 0x1, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                If(LEqual(And(Local1, 0x1, ), 0x1)) {
                    Store(0x1f, \_SB_.BAT0.BSTA)
                }
                Else {
                    Store(0xf, \_SB_.BAT0.BSTA)
                }
                Store(One, \_SB_.BAT0.FBIF)
                Notify(\_SB_.BAT0, 0x81)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x2, Local3), And(Local4, 0x2, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x4, Local3), And(Local4, 0x4, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x81)
            }
            If(LNot(LEqual(And(Local1, 0x8, Local3), And(Local4, 0x8, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x10, Local3), And(Local4, 0x10, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x20, Local3), And(Local4, 0x20, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x40, Local3), And(Local4, 0x40, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            If(LNot(LEqual(And(Local1, 0x80, Local3), And(Local4, 0x80, Local5)))) {
                Store(\_SB_.PCI0.PIB_.PMRD(0xa1), Local6)
                \_SB_.PCI0.PIB_.PMWT(0xf1, Local6)
                Notify(\_SB_.BAT0, 0x80)
            }
            And(\_SB_.PCI0.PIB_.PMRD(0xab), 0xfd, Local2)
            \_SB_.PCI0.PIB_.PMWT(0xab, Local2)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
        }
        Release(\_GPE.GLCK)
    }
    Method(_L05) {
        Notify(\_SB_.PCI0.CRD0, 0x2)
        Notify(\_SB_.PCI0.CRD1, 0x2)
        Notify(\_SB_.PCI0.MPCI, 0x2)
        Notify(\_SB_.PCI0.MPC2, 0x2)
        Notify(\_SB_.PCI0, 0x2)
        Notify(\_SB_.PWRB, 0x2)
    }
    Method(_L08) {
        Acquire(\_GPE.GLCK, 0xffff)
        Store(\_SB_.PCI0.PIB_.PMRD(0xac), Local0)
        Store(Local0, Debug)
        If(And(Local0, 0x10, Local3)) {
            Store("*** GPIOA EVENT ***", Debug)
            Store(\_SB_.PCI0.PIB_.PMRD(0xa8), Local1)
            If(And(Local1, 0x1, Local2)) {
                Store("*** GPIOA Bit0 EVENT ***", Debug)
                Store(\_SB_.PCI0.PIB_.PMRD(0xb7), Local3)
                If(And(Local3, 0x1, Local6)) {
                    Store("*** Lid Open ***", Debug)
                    And(Local3, 0xfe, Local3)
                    \_SB_.PCI0.PIB_.PMWT(0xb7, Local3)
                    Store(0x1, \_SB_.LID_.LIDF)
                }
                Else {
                    Store("*** Lid Close ***", Debug)
                    Or(Local3, 0x1, Local3)
                    \_SB_.PCI0.PIB_.PMWT(0xb7, Local3)
                    Store(0x0, \_SB_.LID_.LIDF)
                }
                And(Local1, 0xfe, Local1)
                \_SB_.PCI0.PIB_.PMWT(0xa8, Local1)
                Notify(\_SB_.LID_, 0x80)
                If(\_SB_.LID_.LIDF) {
                    Notify(\_SB_.PWRB, 0x2)
                }
            }
            And(Local0, 0xef, Local0)
            \_SB_.PCI0.PIB_.PMWT(0xac, Local0)
            \_SB_.PCI0.PIB_.PMWT(0xf0, 0x0)
        }
        Release(\_GPE.GLCK)
    }
    Method(_L09) {
        Notify(\_SB_.PCI0.USB0, 0x2)
    }
}
OperationRegion(VGAM, SystemMemory, 0x000c0002, 0x1)
Field(VGAM, ByteAcc, NoLock, Preserve) {
    VGA1,	8
}
Scope(\_SB_) {
    Mutex(VSMX, 0)
    Method(VIAX, 1, Serialized) {
        Store("--------- VIA SOFTWARE SMI PMIO 2Fh ------------", Debug)
        Acquire(VSMX, 0xffff)
        Store(Arg0, \_SB_.PCI0.PM__.BCMD)
        Release(VSMX)
    }
    Device(PCI0) {
        Name(_HID, 0x030ad041)
        Name(_ADR, 0x0)
        Name(_BBN, 0x0)
        OperationRegion(NB00, PCI_Config, 0x0, 0x0100)
        Field(NB00, ByteAcc, NoLock, Preserve) {
            Offset(0x5f),
            EADD,	8
        }
        Method(_STA) {
            Return(0xf)
        }
        Name(CRES, Buffer(0x88) {0x88, 0xd, 0x0, 0x2, 0xc, 0x0, 0x0, 0x0, 0x0, 0x0, 0xff, 0x0, 0x0, 0x0, 0x0, 0x1, 0x47, 0x1, 0xf8, 0xc, 0xf8, 0xc, 0x1, 0x8, 0x88, 0xd, 0x0, 0x1, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0xf7, 0xc, 0x0, 0x0, 0xf8, 0xc, 0x88, 0xd, 0x0, 0x1, 0xc, 0x3, 0x0, 0x0, 0x0, 0xd, 0xff, 0xff, 0x0, 0x0, 0x0, 0xf3, 0x87, 0x17, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xa, 0x0, 0xff, 0xbf, 0xc, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc0, 0x2, 0x0, 0x87, 0x17, 0x0, 0x0, 0xc, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc0, 0xc, 0x0, 0xff, 0xff, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x80, 0x1, 0x0, 0x87, 0x17, 0x0, 0x0, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, 0xff, 0xff, 0xf7, 0xff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xf0, 0xff, 0x79, 0x0 })
        Method(_CRS) {
            CreateDWordField(CRES, 0x46, VMAX)
            CreateDWordField(CRES, 0x4e, VLEN)
            ShiftLeft(VGA1, 0x9, Local0)
            Add(Local0, 0x000bffff, VMAX)
            Add(Local0, 0x00020000, VLEN)
            CreateDWordField(CRES, 0x76, TCMM)
            CreateDWordField(CRES, 0x82, TOMM)
            Multiply(\_SB_.PCI0.EADD, 0x01000000, Local0)
            Store(Local0, TCMM)
            Subtract(0xfff80000, TCMM, TOMM)
            Return(CRES)
        }
        Name(_PRT, Package(0xa) {
            Package(0x4) {
                0x0001ffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKC,
                0x0,
            },
            Package(0x4) {
                0x0007ffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x0007ffff,
                0x1,
                \_SB_.PCI0.PIB_.LNKB,
                0x0,
            },
            Package(0x4) {
                0x0007ffff,
                0x2,
                \_SB_.PCI0.PIB_.LNKC,
                0x0,
            },
            Package(0x4) {
                0x0007ffff,
                0x3,
                \_SB_.PCI0.PIB_.LNKD,
                0x0,
            },
            Package(0x4) {
                0x0005ffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x0006ffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x000cffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x000cffff,
                0x1,
                \_SB_.PCI0.PIB_.LNKB,
                0x0,
            },
            Package(0x4) {
                0x000dffff,
                0x0,
                \_SB_.PCI0.PIB_.LNKA,
                0x0,
            },
        })
        Device(PIB_) {
            Name(_ADR, 0x00070000)
            OperationRegion(IRQR, PCI_Config, 0x0, 0x88)
            Field(IRQR, ByteAcc, NoLock, Preserve) {
                Offset(0x48),
                ,	2,
                EUSB,	1,
                Offset(0x50),
                FDDA,	2,
                LPDA,	2,
                Offset(0x51),
                FDIQ,	4,
                LPIQ,	4,
                SAIQ,	4,
                SBIQ,	4,
                Offset(0x55),
                ,	4,
                PIRA,	4,
                PIRB,	4,
                PIRC,	4,
                ,	4,
                PIRD,	4,
                USBA,	2,
                A97A,	2,
                Offset(0x81),
                PDC1,	8,
                PDC2,	8,
                PDC3,	8,
                PDC4,	8,
                EP3C,	1,
                EN3C,	1,
                EACF,	1,
                EMCF,	1,
                ESB1,	1
            }
            Device(LNKA) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x1)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Store(Zero, \_SB_.PCI0.PIB_.PIRA)
                }
                Method(_STA) {
                    If(LEqual(\_SB_.PCI0.PIB_.PIRA, 0x0)) {
                        Return(0x9)
                    }
                    Else {
                        Return(0xb)
                    }
                }
                Method(_CRS) {
                    Name(BUFA, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                    CreateByteField(BUFA, 0x1, IRA1)
                    CreateByteField(BUFA, 0x2, IRA2)
                    Store(\_SB_.PCI0.PIB_.PIRA, Local0)
                    If(LGreater(Local0, 0x0)) {
                        If(LGreater(Local0, 0x7)) {
                            Subtract(Local0, 0x8, Local0)
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRA2)
                        }
                        Else {
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRA1)
                        }
                    }
                    Return(BUFA)
                }
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x1, IRA1)
                    CreateByteField(Arg0, 0x2, IRA2)
                    If(LGreater(IRA2, Zero)) {
                        FindSetLeftBit(IRA2, Local0)
                        Decrement(Local0)
                        Add(Local0, 0x8, Local0)
                    }
                    Else {
                        FindSetLeftBit(IRA1, Local0)
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.PIRA)
                }
            }
            Device(LNKB) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x2)
                Name(_PRS, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Store(Zero, \_SB_.PCI0.PIB_.PIRB)
                }
                Method(_STA) {
                    If(LEqual(\_SB_.PCI0.PIB_.PIRB, 0x0)) {
                        Return(0x9)
                    }
                    Else {
                        Return(0xb)
                    }
                }
                Method(_CRS) {
                    Name(BUFB, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                    CreateByteField(BUFB, 0x1, IRB1)
                    CreateByteField(BUFB, 0x2, IRB2)
                    Store(\_SB_.PCI0.PIB_.PIRB, Local0)
                    If(LGreater(Local0, 0x0)) {
                        If(LGreater(Local0, 0x7)) {
                            Subtract(Local0, 0x8, Local0)
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRB2)
                        }
                        Else {
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRB1)
                        }
                    }
                    Return(BUFB)
                }
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x1, IRB1)
                    CreateByteField(Arg0, 0x2, IRB2)
                    If(LGreater(IRB2, Zero)) {
                        FindSetLeftBit(IRB2, Local0)
                        Decrement(Local0)
                        Add(Local0, 0x8, Local0)
                    }
                    Else {
                        FindSetLeftBit(IRB1, Local0)
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.PIRB)
                }
            }
            Device(LNKC) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x3)
                Name(_PRS, Buffer(0x6) {0x23, 0x20, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Store(Zero, \_SB_.PCI0.PIB_.PIRC)
                }
                Method(_STA) {
                    If(LEqual(\_SB_.PCI0.PIB_.PIRC, 0x0)) {
                        Return(0x9)
                    }
                    Else {
                        Return(0xb)
                    }
                }
                Method(_CRS) {
                    Name(BUFC, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                    CreateByteField(BUFC, 0x1, IRC1)
                    CreateByteField(BUFC, 0x2, IRC2)
                    Store(\_SB_.PCI0.PIB_.PIRC, Local0)
                    If(LGreater(Local0, 0x0)) {
                        If(LGreater(Local0, 0x7)) {
                            Subtract(Local0, 0x8, Local0)
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRC2)
                        }
                        Else {
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, IRC1)
                        }
                    }
                    Return(BUFC)
                }
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x1, IRC1)
                    CreateByteField(Arg0, 0x2, IRC2)
                    If(LGreater(IRC2, Zero)) {
                        FindSetLeftBit(IRC2, Local0)
                        Decrement(Local0)
                        Add(Local0, 0x8, Local0)
                    }
                    Else {
                        FindSetLeftBit(IRC1, Local0)
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.PIRC)
                }
            }
            Device(LNKD) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x4)
                Name(_PRS, Buffer(0x6) {0x23, 0x20, 0x0, 0x18, 0x79, 0x0 })
                Method(_DIS) {
                    Store(Zero, \_SB_.PCI0.PIB_.PIRD)
                }
                Method(_STA) {
                    If(LEqual(\_SB_.PCI0.PIB_.PIRD, 0x0)) {
                        Return(0x9)
                    }
                    Else {
                        Return(0xb)
                    }
                }
                Method(_CRS) {
                    Name(BUFD, Buffer(0x6) {0x23, 0x0, 0x0, 0x18, 0x79, 0x0 })
                    CreateByteField(BUFD, 0x1, IRD1)
                    CreateByteField(BUFD, 0x2, IRD2)
                    Store(\_SB_.PCI0.PIB_.PIRD, Local0)
                    If(LGreater(Local0, 0x0)) {
                        If(LGreater(Local0, 0x7)) {
                            Subtract(Local0, 0x8, Local2)
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local2, Local3)
                            Store(Local3, IRD2)
                        }
                        Else {
                            Store(0x1, Local1)
                            ShiftLeft(Local1, Local0, Local2)
                            Store(Local2, IRD1)
                        }
                    }
                    Return(BUFD)
                }
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x1, IRD1)
                    CreateByteField(Arg0, 0x2, IRD2)
                    If(LGreater(IRD2, Zero)) {
                        FindSetLeftBit(IRD2, Local0)
                        Decrement(Local0)
                        Add(Local0, 0x8, Local0)
                    }
                    Else {
                        FindSetLeftBit(IRD1, Local0)
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.PIRD)
                }
            }
            Device(DMA1) {
                Name(_HID, 0x0002d041)
                Name(_CRS, Buffer(0x1d) {0x2a, 0x10, 0x4, 0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x10, 0x47, 0x1, 0x81, 0x0, 0x81, 0x0, 0x1, 0xf, 0x47, 0x1, 0xc0, 0x0, 0xc0, 0x0, 0x1, 0x20, 0x79, 0x0 })
                Method(_STA) {
                    Return(0xf)
                }
            }
            Device(RTC_) {
                Name(_HID, 0x000bd041)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_CRS, Buffer(0xd) {0x47, 0x0, 0x70, 0x0, 0x70, 0x0, 0x1, 0x6, 0x22, 0x0, 0x1, 0x79, 0x0 })
                OperationRegion(XCMS, SystemIO, 0x72, 0x2)
                Field(XCMS, ByteAcc, NoLock, Preserve) {
                    INDX,	8,
                    DATA,	8
                }
                IndexField(INDX, DATA, ByteAcc, NoLock, Preserve) {
                    Offset(0x95),
                    ,	6,
                    CPUT,	2,
                    ,	6,
                    PS2M,	2
                }
            }
            Device(PIC_) {
                Name(_HID, 0xd041)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_CRS, Buffer(0x15) {0x47, 0x1, 0x20, 0x0, 0x20, 0x0, 0x1, 0x2, 0x47, 0x1, 0xa0, 0x0, 0xa0, 0x0, 0x1, 0x2, 0x22, 0x4, 0x0, 0x79, 0x0 })
            }
            Device(COPR) {
                Name(_HID, 0x040cd041)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_CRS, Buffer(0xd) {0x47, 0x1, 0xf0, 0x0, 0xf0, 0x0, 0x1, 0x10, 0x22, 0x0, 0x20, 0x79, 0x0 })
            }
            Device(TMR_) {
                Name(_HID, 0x0001d041)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_CRS, Buffer(0xd) {0x47, 0x1, 0x40, 0x0, 0x40, 0x0, 0x1, 0x4, 0x22, 0x1, 0x0, 0x79, 0x0 })
            }
            Device(SPKR) {
                Method(_STA) {
                    Return(0xf)
                }
                Name(_HID, 0x0008d041)
                Name(_CRS, Buffer(0xa) {0x47, 0x1, 0x61, 0x0, 0x61, 0x0, 0x1, 0x1, 0x79, 0x0 })
            }
            Device(MEM_) {
                Name(_HID, 0x010cd041)
                Method(_STA) {
                    Return(0xf)
                }
                Method(_CRS) {
                    Name(SMEM, Buffer(0x1a) {0x86, 0x9, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xa, 0x0, 0x86, 0x9, 0x0, 0x0, 0x0, 0x0, 0xe, 0x0, 0x0, 0x0, 0x2, 0x0, 0x79, 0x0 })
                    Return(SMEM)
                }
            }
            Device(SYSR) {
                Name(_HID, 0x020cd041)
                Method(_STA) {
                    Return(0xf)
                }
                Name(_CRS, Buffer(0x12) {0x47, 0x1, 0xd0, 0x4, 0xd0, 0x4, 0x1, 0x2, 0x47, 0x1, 0x80, 0x0, 0x80, 0x0, 0x1, 0x1, 0x79, 0x0 })
            }
            OperationRegion(VSIO, SystemIO, 0x03f0, 0x2)
            Field(VSIO, ByteAcc, NoLock, Preserve) {
                INDX,	8,
                DATA,	8
            }
            IndexField(INDX, DATA, ByteAcc, NoLock, Preserve) {
                Offset(0xe2),
                CRE2,	8,
                CRE3,	8,
                Offset(0xe6),
                CRE6,	8,
                CRE7,	8,
                CRE8,	8,
                Offset(0xee),
                CREE,	8
            }
            Method(ENCG) {
                Store(0x1, \_SB_.PCI0.PIB_.EN3C)
            }
            Method(EXCG) {
                Store(0x0, \_SB_.PCI0.PIB_.EN3C)
            }
            Device(FDC0) {
                Name(_HID, 0x0007d041)
                Name(RSRC, Buffer(0x18) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x6, 0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x1, 0x22, 0x0, 0x0, 0x2a, 0x0, 0x0, 0x79, 0x0 })
                Method(_STA) {
                    If(LNot(\_SB_.PCI0.PIB_.EP3C)) {
                        Return(0x0)
                    }
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0x10, Local0)
                    If(Local0) {
                        Store(CRE3, Local1)
                        EXCG()
                        If(LEqual(Local1, 0x0)) {
                            Return(0xd)
                        }
                        Return(0xf)
                    }
                    EXCG()
                    Return(0xd)
                }
                Method(_DIS) {
                    ENCG()
                    Store(Zero, CRE3)
                    EXCG()
                }
                Method(_CRS) {
                    If(LEqual(And(_STA(), 0x4, ), Zero)) {
                        Return(RSRC)
                    }
                    Name(BUF0, Buffer(0x18) {0x47, 0x1, 0xf0, 0x3, 0xf0, 0x3, 0x1, 0x6, 0x47, 0x1, 0xf7, 0x3, 0xf7, 0x3, 0x1, 0x1, 0x22, 0x40, 0x0, 0x2a, 0x4, 0x0, 0x79, 0x0 })
                    CreateByteField(BUF0, 0x2, IOLO)
                    CreateByteField(BUF0, 0x3, IOHI)
                    CreateByteField(BUF0, 0x4, IORL)
                    CreateByteField(BUF0, 0x5, IORH)
                    CreateByteField(BUF0, 0xa, DALO)
                    CreateByteField(BUF0, 0xb, DAHI)
                    CreateByteField(BUF0, 0xc, DRLO)
                    CreateByteField(BUF0, 0xd, DRHI)
                    CreateByteField(BUF0, 0x11, IRQL)
                    CreateByteField(BUF0, 0x14, DMAV)
                    Store(DATA, Local0)
                    And(Local0, 0x20, Local0)
                    If(LEqual(Local0, 0x0)) {
                        Store(0x70, IOLO)
                        Store(0x3, IOHI)
                        Store(IOLO, IORL)
                        Store(IOHI, IORH)
                        Store(0x77, DALO)
                        Store(0x3, DAHI)
                        Store(DALO, DRLO)
                        Store(DAHI, DRHI)
                    }
                    Store(\_SB_.PCI0.PIB_.FDIQ, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, IRQL)
                    Store(\_SB_.PCI0.PIB_.FDDA, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, DMAV)
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x1b) {0x31, 0x4, 0x47, 0x1, 0xf0, 0x3, 0xf0, 0x3, 0x1, 0x6, 0x47, 0x1, 0xf7, 0x3, 0xf7, 0x3, 0x1, 0x1, 0x22, 0x40, 0x0, 0x2a, 0x4, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateWordField(Arg0, 0x11, IRQL)
                    CreateByteField(Arg0, 0x14, DMAV)
                    ENCG()
                    Store(CRE2, Local1)
                    And(Local1, 0xef, Local1)
                    Store(Local1, CRE2)
                    If(LEqual(IOLO, 0xf0)) {
                        Store(0xf0, Local0)
                    }
                    Else {
                        Store(0x70, Local0)
                    }
                    ShiftRight(Local0, 0x2, Local0)
                    And(Local0, 0xfc, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE3)
                    FindSetRightBit(IRQL, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.FDIQ)
                    FindSetRightBit(DMAV, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.FDDA)
                    Store(CRE2, Local1)
                    Or(Local1, 0x10, Local1)
                    Store(Local1, CRE2)
                    EXCG()
                }
            }
            Device(UAR1) {
                Name(_HID, 0x0105d041)
                Name(_UID, 0x1)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x8, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_STA) {
                    If(LNot(\_SB_.PCI0.PIB_.EP3C)) {
                        Return(0x0)
                    }
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0x4, Local0)
                    If(Local0) {
                        Store(CRE7, Local1)
                        EXCG()
                        If(LEqual(Local1, 0x0)) {
                            Return(0xd)
                        }
                        Return(0xf)
                    }
                    EXCG()
                    Return(0x0)
                }
                Method(_DIS) {
                }
                Method(_CRS) {
                    And(_STA(), 0x4, Local0)
                    If(LEqual(Local0, Zero)) {
                        Return(RSRC)
                    }
                    Name(BUF0, Buffer(0xd) {0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x79, 0x0 })
                    CreateByteField(BUF0, 0x2, IOLO)
                    CreateByteField(BUF0, 0x3, IOHI)
                    CreateByteField(BUF0, 0x4, IORL)
                    CreateByteField(BUF0, 0x5, IORH)
                    CreateByteField(BUF0, 0x9, IRQL)
                    ENCG()
                    Store(CRE7, Local0)
                    Store(Local0, Local1)
                    And(Local1, 0xc0, Local1)
                    ShiftRight(Local1, 0x6, Local1)
                    And(Local0, 0x3f, Local0)
                    ShiftLeft(Local0, 0x2, Local0)
                    Store(Local0, IOLO)
                    Store(Local1, IOHI)
                    Store(IOLO, IORL)
                    Store(IOHI, IORH)
                    EXCG()
                    Store(\_SB_.PCI0.PIB_.SAIQ, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, IRQL)
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x37) {0x31, 0x4, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateByteField(Arg0, 0x9, IRQL)
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0xfb, Local0)
                    Store(Local0, CRE2)
                    Store(IOLO, Local0)
                    ShiftRight(Local0, 0x2, Local0)
                    And(Local0, 0xfe, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE7)
                    FindSetRightBit(IRQL, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.SAIQ)
                    Store(CRE2, Local0)
                    Or(Local0, 0x4, Local0)
                    Store(Local0, CRE2)
                    EXCG()
                }
            }
            Device(UAR2) {
                Name(_HID, 0x0105d041)
                Name(_UID, 0x2)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x8, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_STA) {
                    If(LNot(\_SB_.PCI0.PIB_.EP3C)) {
                        Return(0x0)
                    }
                    ENCG()
                    Store(CREE, Local0)
                    And(Local0, 0x38, Local0)
                    If(LEqual(Local0, 0x0)) {
                        Store(CRE2, Local0)
                        And(Local0, 0x8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            EXCG()
                            Return(0x0)
                        }
                        Store(CRE8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            EXCG()
                            Return(0xd)
                        }
                        EXCG()
                        Return(0xf)
                    }
                    EXCG()
                    Return(0x0)
                }
                Method(_DIS) {
                }
                Method(_CRS) {
                    And(_STA(), 0x4, Local0)
                    If(LEqual(Local0, Zero)) {
                        Return(RSRC)
                    }
                    Name(BUF0, Buffer(0xd) {0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x79, 0x0 })
                    CreateByteField(BUF0, 0x2, IOLO)
                    CreateByteField(BUF0, 0x3, IOHI)
                    CreateByteField(BUF0, 0x4, IORL)
                    CreateByteField(BUF0, 0x5, IORH)
                    CreateByteField(BUF0, 0x9, IRQL)
                    ENCG()
                    Store(CRE8, Local0)
                    Store(Local0, Local1)
                    And(Local1, 0xc0, Local1)
                    ShiftRight(Local1, 0x6, Local1)
                    And(Local0, 0x3f, Local0)
                    ShiftLeft(Local0, 0x2, Local0)
                    Store(Local0, IOLO)
                    Store(Local1, IOHI)
                    Store(IOLO, IORL)
                    Store(IOHI, IORH)
                    EXCG()
                    Store(\_SB_.PCI0.PIB_.SBIQ, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, IRQL)
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x37) {0x31, 0x4, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateByteField(Arg0, 0x9, IRQL)
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0xf7, Local0)
                    Store(Local0, CRE2)
                    Store(IOLO, Local0)
                    ShiftRight(Local0, 0x2, Local0)
                    And(Local0, 0xfe, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE8)
                    FindSetRightBit(IRQL, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.SBIQ)
                    Store(CRE2, Local0)
                    Or(Local0, 0x8, Local0)
                    Store(Local0, CRE2)
                    EXCG()
                }
            }
            Device(IRDA) {
                Name(_HID, 0x1005d041)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x8, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_STA) {
                    If(LNot(\_SB_.PCI0.PIB_.EP3C)) {
                        Return(0x0)
                    }
                    ENCG()
                    Store(CREE, Local0)
                    And(Local0, 0x38, Local0)
                    If(LEqual(Local0, 0x8)) {
                        Store(CRE2, Local0)
                        And(Local0, 0x8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            EXCG()
                            Return(0x0)
                        }
                        Store(CRE8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            EXCG()
                            Return(0xd)
                        }
                        EXCG()
                        Return(0xf)
                    }
                    EXCG()
                    Return(0x0)
                }
                Method(_DIS) {
                    ENCG()
                    Store(Zero, CRE8)
                    EXCG()
                    Store(Zero, \_SB_.PCI0.PIB_.SBIQ)
                }
                Method(_CRS) {
                    And(_STA(), 0x4, Local0)
                    If(LEqual(Local0, Zero)) {
                        Return(RSRC)
                    }
                    Name(BUF0, Buffer(0xd) {0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x79, 0x0 })
                    CreateByteField(BUF0, 0x2, IOLO)
                    CreateByteField(BUF0, 0x3, IOHI)
                    CreateByteField(BUF0, 0x4, IORL)
                    CreateByteField(BUF0, 0x5, IORH)
                    CreateByteField(BUF0, 0x9, IRQL)
                    ENCG()
                    Store(CRE8, Local0)
                    Store(Local0, Local1)
                    And(Local1, 0xc0, Local1)
                    ShiftRight(Local1, 0x6, Local1)
                    And(Local0, 0x3f, Local0)
                    ShiftLeft(Local0, 0x2, Local0)
                    Store(Local0, IOLO)
                    Store(Local1, IOHI)
                    Store(IOLO, IORL)
                    Store(IOHI, IORH)
                    EXCG()
                    Store(\_SB_.PCI0.PIB_.SBIQ, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, IRQL)
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x37) {0x31, 0x4, 0x47, 0x1, 0xf8, 0x3, 0xf8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xf8, 0x2, 0xf8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x3, 0xe8, 0x3, 0x8, 0x8, 0x22, 0x10, 0x0, 0x31, 0x4, 0x47, 0x1, 0xe8, 0x2, 0xe8, 0x2, 0x8, 0x8, 0x22, 0x8, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateByteField(Arg0, 0x9, IRQL)
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0xf7, Local0)
                    Store(Local0, CRE2)
                    Store(IOLO, Local0)
                    ShiftRight(Local0, 0x2, Local0)
                    And(Local0, 0xfe, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE8)
                    FindSetRightBit(IRQL, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.SBIQ)
                    Store(CRE2, Local0)
                    Or(Local0, 0x8, Local0)
                    Store(Local0, CRE2)
                    EXCG()
                }
            }
            Device(LPT_) {
                Name(PIOM, Buffer(0x1) {0x0 })
                CreateByteField(PIOM, 0x0, LPTM)
                Name(_HID, 0x0004d041)
                Method(_STA) {
                    If(\_SB_.PCI0.PIB_.EP3C) {
                        ENCG()
                        Store(CRE2, Local0)
                        And(Local0, 0x3, Local0)
                        If(LEqual(Local0, 0x1)) {
                            EXCG()
                            Return(0x0)
                        }
                        If(LEqual(Local0, 0x3)) {
                            EXCG()
                            Return(0x0)
                        }
                        Else {
                            If(LNot(LEqual(Local0, 0x3))) {
                                Store(Local0, LPTM)
                            }
                            Store(CRE6, Local0)
                            EXCG()
                            If(LEqual(Local0, 0x0)) {
                                Return(0xd)
                            }
                            Else {
                                Return(0xf)
                            }
                        }
                    }
                    Else {
                        Return(0x0)
                    }
                }
                Method(_DIS) {
                    ENCG()
                    Store(Zero, CRE6)
                    EXCG()
                    Store(Zero, \_SB_.PCI0.PIB_.LPIQ)
                }
                Method(_CRS) {
                    Name(BUF0, Buffer(0xd) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x22, 0x0, 0x0, 0x79, 0x0 })
                    If(LEqual(_STA(), 0xf)) {
                        CreateByteField(BUF0, 0x2, IOLO)
                        CreateByteField(BUF0, 0x3, IOHI)
                        CreateByteField(BUF0, 0x4, IORL)
                        CreateByteField(BUF0, 0x5, IORH)
                        CreateByteField(BUF0, 0x7, RGLN)
                        CreateByteField(BUF0, 0x9, IRQL)
                        ENCG()
                        Store(CRE6, Local0)
                        Store(Local0, Local1)
                        And(Local1, 0xc0, Local1)
                        ShiftRight(Local1, 0x6, Local1)
                        And(Local0, 0x3f, Local0)
                        ShiftLeft(Local0, 0x2, Local0)
                        Store(Local0, IOLO)
                        Store(Local1, IOHI)
                        Store(IOLO, IORL)
                        Store(IOHI, IORH)
                        Store(CRE6, Local0)
                        If(LNot(LEqual(LPTM, 0x2))) {
                            If(LEqual(Local0, 0xef)) {
                                Store(0x4, RGLN)
                            }
                            Else {
                                Store(0x8, RGLN)
                            }
                        }
                        Else {
                            Store(0x8, RGLN)
                        }
                        EXCG()
                        Store(\_SB_.PCI0.PIB_.LPIQ, Local0)
                        Store(0x1, Local1)
                        ShiftLeft(Local1, Local0, IRQL)
                    }
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x4b) {0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3, 0x1, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3, 0x1, 0x8, 0x22, 0x20, 0x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x1, 0x8, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x1, 0x8, 0x22, 0x20, 0x0, 0x30, 0x47, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x1, 0x4, 0x22, 0x80, 0x0, 0x30, 0x47, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x1, 0x4, 0x22, 0x20, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateByteField(Arg0, 0x9, IRQL)
                    ENCG()
                    Store(CRE2, Local0)
                    Or(Local0, 0x3, Local0)
                    Store(Local0, CRE2)
                    Store(IOLO, Local0)
                    ShiftRight(Local0, 0x2, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE6)
                    FindSetRightBit(IRQL, Local0)
                    If(Local0) {
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.LPIQ)
                    Store(CRE2, Local0)
                    And(Local0, 0xfc, Local0)
                    Store(LPTM, Local1)
                    Or(Local0, Local1, Local1)
                    Store(Local1, CRE2)
                    EXCG()
                }
            }
            Device(ECP_) {
                Name(_HID, 0x0104d041)
                Method(_STA) {
                    If(LNot(\_SB_.PCI0.PIB_.EP3C)) {
                        Return(0x0)
                    }
                    ENCG()
                    Store(CRE2, Local0)
                    And(Local0, 0x3, Local0)
                    If(LEqual(Local0, 0x1)) {
                        Store(CRE6, Local1)
                        EXCG()
                        If(LNot(LEqual(Local1, 0x0))) {
                            Return(0xf)
                        }
                        Return(0xd)
                    }
                    EXCG()
                    Return(0x0)
                }
                Method(_DIS) {
                    ENCG()
                    Store(Zero, CRE6)
                    EXCG()
                    Store(Zero, \_SB_.PCI0.PIB_.LPDA)
                    Store(Zero, \_SB_.PCI0.PIB_.LPIQ)
                }
                Method(_CRS) {
                    Name(BUF0, Buffer(0x18) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x4, 0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x4, 0x22, 0x0, 0x0, 0x2a, 0x0, 0x0, 0x79, 0x0 })
                    CreateByteField(BUF0, 0x2, IOLO)
                    CreateByteField(BUF0, 0x3, IOHI)
                    CreateByteField(BUF0, 0x4, IORL)
                    CreateByteField(BUF0, 0x5, IORH)
                    CreateByteField(BUF0, 0xa, DALO)
                    CreateByteField(BUF0, 0xb, DAHI)
                    CreateByteField(BUF0, 0xc, DRLO)
                    CreateByteField(BUF0, 0xd, DRHI)
                    CreateByteField(BUF0, 0x11, IRQL)
                    CreateByteField(BUF0, 0x14, DMAC)
                    ENCG()
                    Store(CRE6, Local0)
                    Store(Local0, Local1)
                    And(Local1, 0xc0, Local1)
                    ShiftRight(Local1, 0x6, Local1)
                    And(Local0, 0x3f, Local0)
                    ShiftLeft(Local0, 0x2, Local0)
                    Store(Local0, IOLO)
                    Store(Local1, IOHI)
                    Add(Local1, 0x4, Local1)
                    Store(IOLO, IORL)
                    Store(IOHI, IORH)
                    Store(IOLO, DALO)
                    Store(Local1, DAHI)
                    Store(DALO, DRLO)
                    Store(DAHI, DRHI)
                    EXCG()
                    Store(\_SB_.PCI0.PIB_.LPIQ, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, IRQL)
                    Store(\_SB_.PCI0.PIB_.LPDA, Local0)
                    Store(0x1, Local1)
                    ShiftLeft(Local1, Local0, DMAC)
                    Return(BUF0)
                }
                Name(_PRS, Buffer(0x4b) {0x31, 0x0, 0x47, 0x1, 0x78, 0x3, 0x78, 0x3, 0x1, 0x4, 0x47, 0x1, 0x78, 0x7, 0x78, 0x7, 0x1, 0x4, 0x22, 0xa0, 0x0, 0x2a, 0xa, 0x0, 0x31, 0x5, 0x47, 0x1, 0x78, 0x2, 0x78, 0x2, 0x1, 0x4, 0x47, 0x1, 0x78, 0x6, 0x78, 0x6, 0x1, 0x4, 0x22, 0xa0, 0x0, 0x2a, 0xa, 0x0, 0x31, 0xa, 0x47, 0x1, 0xbc, 0x3, 0xbc, 0x3, 0x1, 0x4, 0x47, 0x1, 0xbc, 0x7, 0xbc, 0x7, 0x1, 0x4, 0x22, 0xa0, 0x0, 0x2a, 0xa, 0x0, 0x38, 0x79, 0x0 })
                Method(_SRS, 1) {
                    CreateByteField(Arg0, 0x2, IOLO)
                    CreateByteField(Arg0, 0x3, IOHI)
                    CreateByteField(Arg0, 0x11, IRQL)
                    CreateByteField(Arg0, 0x14, DMAC)
                    ENCG()
                    Store(CRE2, Local0)
                    Or(Local0, 0x3, Local0)
                    Store(Local0, CRE2)
                    Store(IOLO, Local0)
                    ShiftRight(Local0, 0x2, Local0)
                    Store(IOHI, Local1)
                    ShiftLeft(Local1, 0x6, Local1)
                    Or(Local0, Local1, Local0)
                    Store(Local0, CRE6)
                    FindSetRightBit(IRQL, Local0)
                    If(Local0) {
                        Decrement(Local0)
                    }
                    Store(Local0, \_SB_.PCI0.PIB_.LPIQ)
                    FindSetRightBit(DMAC, Local0)
                    Decrement(Local0)
                    Store(Local0, \_SB_.PCI0.PIB_.LPDA)
                    Store(CRE2, Local0)
                    And(Local0, 0xfc, Local0)
                    Or(Local0, 0x1, Local0)
                    Store(Local0, CRE2)
                    EXCG()
                }
            }
            Device(PS2M) {
                Name(_HID, 0x130fd041)
                Name(_CRS, Buffer(0x5) {0x22, 0x0, 0x10, 0x79, 0x0 })
                Method(_STA) {
                    If(LEqual(\_SB_.PCI0.PIB_.RTC_.PS2M, 0x0)) {
                        Return(0x0)
                    }
                    Else {
                        Return(0xf)
                    }
                }
            }
            Device(PS2K) {
                Name(_HID, 0x0303d041)
                Name(_CRS, Buffer(0x15) {0x47, 0x1, 0x60, 0x0, 0x60, 0x0, 0x1, 0x1, 0x47, 0x1, 0x64, 0x0, 0x64, 0x0, 0x1, 0x1, 0x22, 0x2, 0x0, 0x79, 0x0 })
                Method(_STA) {
                    Return(0xf)
                }
            }
            OperationRegion(PMIF, SystemIO, 0x68, 0x8)
            Field(PMIF, ByteAcc, NoLock, Preserve) {
                PMUD,	8,
                Offset(0x4),
                PMUC,	8,
                Offset(0x8)
            }
            Mutex(ELCK, 0)
            Method(WIBF) {
                Store(0x0009ffff, Local6)
                Noop
                Noop
                Store(PMUC, Local2)
                And(Local2, 0x22, Local2)
                If(And(Local2, 0x20, Local3)) {
                    Return(0x1)
                }
                And(Local2, 0x2, Local2)
                While(LAnd(LNot(LEqual(Local2, 0x0)), LNot(LEqual(Local6, 0x0)))) {
                    Noop
                    Noop
                    Store(PMUC, Local2)
                    Decrement(Local6)
                    If(And(Local2, 0x20, Local3)) {
                        Return(0x1)
                    }
                    And(Local2, 0x2, Local2)
                }
                Return(0x0)
            }
            Method(WOBF) {
                Store(0x009fffff, Local6)
                Noop
                Noop
                Store(PMUC, Local3)
                And(Local3, 0x21, Local3)
                If(And(Local3, 0x20, Local2)) {
                    Return(0x1)
                }
                While(LAnd(LEqual(Local3, 0x0), LNot(LEqual(Local6, 0x0)))) {
                    Noop
                    Noop
                    Store(PMUC, Local3)
                    And(Local3, 0x21, Local3)
                    If(And(Local3, 0x20, Local2)) {
                        Return(0x1)
                    }
                    Decrement(Local6)
                }
                Return(0x0)
            }
            Method(RCMD, 2) {
                Store(Arg0, Local0)
                Store(Arg1, Local1)
                Store(Local0, PMUC)
                If(WIBF()) {
                    Return(0x1)
                }
                Store(Local1, PMUD)
                If(WOBF()) {
                    Return(0x1)
                }
                Return(0x0)
            }
            Method(WCMD, 2) {
                Store(Arg0, Local0)
                Store(Arg1, Local1)
                Store(Local0, PMUC)
                If(WIBF()) {
                    Return(0x1)
                }
                Store(Local1, PMUD)
                If(WIBF()) {
                    Return(0x1)
                }
                Return(0x0)
            }
            Method(PMRD, 1) {
                Acquire(ELCK, 0xffff)
                Store(Arg0, Local0)
                Store(0x03e8, Local6)
                Store(PMUC, Local1)
                And(Local1, 0x13, Local1)
                While(LAnd(LNot(LEqual(Local1, 0x0)), LNot(LEqual(Local6, 0x0)))) {
                    Sleep(0x1)
                    Store(PMUC, Local1)
                    And(Local1, 0x13, Local1)
                    If(And(Local1, 0x1, Local2)) {
                        Store(PMUD, Local3)
                    }
                    Decrement(Local6)
                }
                While(RCMD(0x80, Local0)) {
                    Noop
                    Noop
                    Store(PMUC, Local5)
                    If(And(Local5, 0x1, Local2)) {
                        Store(PMUD, Local5)
                    }
                }
                Store(PMUD, Local4)
                Release(ELCK)
                Return(Local4)
            }
            Method(PMWT, 2) {
                Acquire(ELCK, 0xffff)
                Store(Arg0, Local0)
                Store(0x03e8, Local6)
                Store(PMUC, Local1)
                And(Local1, 0x13, Local1)
                While(LAnd(LNot(LEqual(Local1, 0x0)), LNot(LEqual(Local6, 0x0)))) {
                    Sleep(0x1)
                    Store(PMUC, Local1)
                    And(Local1, 0x13, Local1)
                    Decrement(Local6)
                }
                While(WCMD(0x81, Local0)) {
                    Noop
                    Noop
                    Store(PMUC, Local5)
                    If(And(Local5, 0x1, Local2)) {
                        Store(PMUD, Local5)
                    }
                }
                Store(Arg1, PMUD)
                Release(ELCK)
            }
        }
        Device(PPB_) {
            Name(_ADR, 0x00010000)
            Name(_PRT, Package(0x4) {
                Package(0x4) {
                    0xffff,
                    0x0,
                    \_SB_.PCI0.PIB_.LNKA,
                    0x0,
                },
                Package(0x4) {
                    0xffff,
                    0x1,
                    \_SB_.PCI0.PIB_.LNKB,
                    0x0,
                },
                Package(0x4) {
                    0xffff,
                    0x2,
                    \_SB_.PCI0.PIB_.LNKC,
                    0x0,
                },
                Package(0x4) {
                    0xffff,
                    0x3,
                    \_SB_.PCI0.PIB_.LNKD,
                    0x0,
                },
            })
            Device(VGA_) {
                Name(_ADR, 0x0)
                Method(_DOS, 1) {
                    Store(Arg0, SWIT)
                }
                Name(_DOD, Package(0x2) {
                    0x00010100,
                    0x00010110,
                })
                Device(CRT_) {
                    Name(_ADR, 0x0100)
                    Name(_DCS, 0x1f)
                    Name(_DGS, 0x1)
                    Method(_DSS, 1) {
                        Or(And(\_SB_.PCI0.PPB_.VGA_.GDGS, 0x1, ), ShiftLeft(And(Arg0, 0x1, ), 0x1, ), \_SB_.PCI0.PPB_.VGA_.GDGS)
                        If(And(Arg0, 0xc0000000, )) {
                            Store(GDGS, GDCS)
                            If(LEqual(And(Arg0, 0x40000000, ), 0x0)) {
                                Store(GDCS, Local0)
                                Store(And(Local0, 0x1, ), \_SB_.PCI0.PPB_.VGA_.LCD_._DCS)
                                Store(ShiftRight(And(Local0, 0x2, ), 0x1, ), \_SB_.PCI0.PPB_.VGA_.CRT_._DCS)
                            }
                        }
                    }
                }
                Device(LCD_) {
                    Name(_ADR, 0x0110)
                    Name(_DCS, 0x1f)
                    Name(_DGS, 0x1)
                    Method(_DSS, 1) {
                        Or(And(\_SB_.PCI0.PPB_.VGA_.GDGS, 0x2, ), And(Arg0, 0x1, ), \_SB_.PCI0.PPB_.VGA_.GDGS)
                        If(And(Arg0, 0xc0000000, )) {
                            Store(GDGS, GDCS)
                            If(LEqual(And(Arg0, 0x40000000, ), 0x0)) {
                                Store(GDCS, Local0)
                                Store(And(Local0, 0x1, ), \_SB_.PCI0.PPB_.VGA_.LCD_._DCS)
                                Store(ShiftRight(And(Local0, 0x2, ), 0x1, ), \_SB_.PCI0.PPB_.VGA_.CRT_._DCS)
                            }
                        }
                    }
                }
                Name(SWIT, 0x1)
                Name(GDCS, 0x2)
                Name(GDGS, 0x2)
            }
        }
        Device(USB0) {
            Name(_ADR, 0x00070002)
            OperationRegion(SB72, PCI_Config, 0x0, 0xc2)
            Field(SB72, ByteAcc, NoLock, Preserve) {
                Offset(0x4),
                UA04,	8,
                Offset(0x20),
                UA20,	8,
                UA21,	8,
                UA22,	8,
                UA23,	8,
                Offset(0x3c),
                U0IR,	4
            }
            Method(_STA) {
                If(\_SB_.PCI0.PIB_.EUSB) {
                    Return(0x0)
                }
                Else {
                    Return(0xf)
                }
            }
            Name(_PRW, Package(0x2) {
                0x9,
                0x1,
            })
        }
        Device(USB1) {
            Name(_ADR, 0x00070003)
            OperationRegion(SB72, PCI_Config, 0x0, 0xc2)
            Field(SB72, ByteAcc, NoLock, Preserve) {
                Offset(0x4),
                UB04,	8,
                Offset(0x20),
                UB20,	8,
                UB21,	8,
                UB22,	8,
                UB23,	8,
                Offset(0x3c),
                U1IR,	4
            }
            Method(_STA) {
                If(\_SB_.PCI0.PIB_.ESB1) {
                    Return(0x0)
                }
                Else {
                    Return(0xf)
                }
            }
            Name(_PRW, Package(0x2) {
                0x9,
                0x1,
            })
        }
        Device(PM__) {
            Name(_ADR, 0x00070004)
            OperationRegion(SB74, PCI_Config, 0x0, 0x0100)
            Field(SB74, DWordAcc, NoLock, Preserve) {
                Offset(0x44),
                PIR0,	8,
                PIR8,	8
            }
            OperationRegion(PMIO, SystemIO, 0x8000, 0x50)
            Field(PMIO, ByteAcc, NoLock, Preserve) {
                Offset(0x10),
                ,	4,
                THON,	1,
                Offset(0x20),
                ,	1,
                GPS1,	1,
                Offset(0x22),
                ,	1,
                GPI1,	1,
                Offset(0x28),
                ,	7,
                PIRS,	1,
                Offset(0x2a),
                ,	7,
                PIEN,	1,
                Offset(0x2c),
                ,	7,
                LPOL,	1,
                Offset(0x2f),
                BCMD,	8,
                Offset(0x48),
                EXMI,	1,
                ,	2,
                LIDI,	1,
                Offset(0x4a),
                GI16,	1,
                GI17,	1,
                GI18,	1,
                GI19,	1,
                Offset(0x4e),
                GO16,	1,
                GO17,	1,
                GO18,	1,
                GO19,	1,
                GO20,	1
            }
            OperationRegion(SMIO, SystemIO, 0x8080, 0x7)
            Field(SMIO, ByteAcc, NoLock, Preserve) {
                HSTS,	8,
                SSTS,	8,
                CTLR,	8,
                CMDR,	8,
                ADDR,	8,
                DAT0,	8,
                DAT1,	8
            }
        }
        Device(AUDI) {
            Name(_ADR, 0x00070005)
            OperationRegion(SB75, PCI_Config, 0x0, 0x85)
            Field(SB75, ByteAcc, NoLock, Preserve) {
                Offset(0x3c),
                ACIR,	4
            }
        }
        Device(MPC2) {
            Name(_ADR, 0x00050000)
            Name(_PRW, Package(0x2) {
                0x5,
                0x4,
            })
        }
        Device(MPCI) {
            Name(_ADR, 0x00060000)
            Name(_PRW, Package(0x2) {
                0x5,
                0x4,
            })
        }
        Device(CRD0) {
            Name(_ADR, 0x000c0000)
            OperationRegion(Z002, PCI_Config, 0xa4, 0x4)
            Field(Z002, DWordAcc, Lock, Preserve) {
                PWST,	2,
                Offset(0x1),
                PMEN,	1,
                ,	6,
                PMST,	1
            }
            Method(_INI) {
                Store(0x0, PWST)
            }
            Method(_PSC) {
                Return(PWST)
            }
            Method(_PS0) {
                Store(0x0, PWST)
            }
            Method(_PS2) {
                Store(0x0, PWST)
            }
            Method(_PS3) {
                Store(0x0, PWST)
            }
            Name(_PRW, Package(0x2) {
                0x5,
                0x1,
            })
        }
        Device(CRD1) {
            Name(_ADR, 0x000c0001)
            OperationRegion(Z003, PCI_Config, 0xa4, 0x4)
            Field(Z003, DWordAcc, Lock, Preserve) {
                PWST,	2,
                Offset(0x1),
                PMEN,	1,
                ,	6,
                PMST,	1
            }
            Method(_INI) {
                Store(0x0, PWST)
            }
            Method(_PSC) {
                Return(PWST)
            }
            Method(_PS0) {
                Store(0x0, PWST)
            }
            Method(_PS2) {
                Store(0x0, PWST)
            }
            Method(_PS3) {
                Store(0x0, PWST)
            }
            Name(_PRW, Package(0x2) {
                0x5,
                0x1,
            })
        }
        Device(IEEE) {
            Name(_ADR, 0x000d0000)
            OperationRegion(Z004, PCI_Config, 0x0, 0x50)
            Field(Z004, DWordAcc, Lock, Preserve) {
                Offset(0x4),
                ,	1,
                PCIC,	2,
                Offset(0x48),
                PWRS,	2,
                Offset(0x49),
                PMEE,	1,
                ,	6,
                PMES,	1
            }
            Method(_INI) {
                Store(0x0, PWRS)
                Store(0x0, PMEE)
                Store(0x0, PMES)
                Store(0x3, PCIC)
            }
            Method(_PSC) {
                Return(PWRS)
            }
            Method(_PS0) {
                Store(0x0, PWRS)
                Store(0x0, PMEE)
                Store(0x0, PMES)
                Store(0x0, PWRS)
                Store(0x3, PCIC)
            }
            Method(_PS2) {
                Store(0x0, PWRS)
            }
            Method(_PS3) {
                Store(0x0, PWRS)
            }
            Name(_PRW, Package(0x2) {
                0x5,
                0x1,
            })
        }
    }
    Mutex(PSMX, 0)
    Device(ACAD) {
        Name(_HID, "ACPI0003")
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(INIT, 0x1)
        Name(ACFG, 0x0)
        Method(_PSR) {
            SHOW("ACAD_PSR")
            Acquire(PSMX, 0xffff)
            And(0x1, \_SB_.PCI0.PIB_.PMRD(0xa0), Local0)
            Store(Local0, ACFG)
            Store(Local0, INIT)
            Release(PSMX)
            SHOW("ACAD_PSR Return")
            SHOW(ACFG)
            Return(ACFG)
        }
        Method(_STA) {
            Return(0xf)
        }
    }
    Device(BAT0) {
        Name(_HID, 0x0a0cd041)
        Name(_UID, 0x1)
        Method(_STA) {
            If(FSTA) {
                Acquire(PSMX, 0xffff)
                And(\_SB_.PCI0.PIB_.PMRD(0xa1), 0x1, Local0)
                Release(PSMX)
                If(LEqual(Local0, 0x0)) {
                    Store(0xf, BSTA)
                }
                Else {
                    Store(0x1f, BSTA)
                }
                Store(Zero, FSTA)
            }
            Return(BSTA)
        }
        Method(_BIF) {
            If(FBIF) {
                And(\_SB_.PCI0.PIB_.PMRD(0xa1), 0x1, Local0)
                If(Local0) {
                    UPBI()
                }
                Else {
                    IVBI()
                    IVBS()
                }
                Store(Zero, FBIF)
            }
            SHOW("BAT0_BIF_RETURN:")
            SHOW(PBIF)
            Return(PBIF)
        }
        Method(_BST) {
            SHOW("BAT0_BST")
            UPBS()
            SHOW("BAT0_BST_RETURN:")
            SHOW(PBST)
            Return(PBST)
        }
        Method(IVBI) {
            Store(0xffffffff, Index(PBIF, 0x1, ))
            Store(0xffffffff, Index(PBIF, 0x2, ))
            Store(0xffffffff, Index(PBIF, 0x4, ))
            Store("Bad", Index(PBIF, 0x9, ))
            Store("Bad", Index(PBIF, 0xa, ))
            Store("Bad", Index(PBIF, 0xb, ))
            Store("Bad", Index(PBIF, 0xc, ))
        }
        Method(IVBS) {
            Store(Zero, Index(PBST, 0x0, ))
            Store(0xffffffff, Index(PBST, 0x1, ))
            Store(0xffffffff, Index(PBST, 0x2, ))
            Store(0xffffffff, Index(PBST, 0x3, ))
        }
        Method(UPBI) {
            Acquire(PSMX, 0xffff)
            Store(0x78, Index(PBIF, 0x1, ))
            Store(0x64, Index(PBIF, 0x2, ))
            Store(0x2580, Index(PBIF, 0x4, ))
            Store("A340", Index(PBIF, 0x9, ))
            If(LEqual(\_SB_.PCI0.PIB_.PMRD(0x16), 0x0)) {
                Store("PC-VP-WP21/OP-570-74002 PC-VP-WP25", Index(PBIF, 0x9, ))
                Store("", Index(PBIF, 0xa, ))
                Store("NiMH", Index(PBIF, 0xb, ))
            }
            Else {
                Store("PC-VP-WP22/OP-570-74001", Index(PBIF, 0x9, ))
                Store("", Index(PBIF, 0xa, ))
                Store("Lion", Index(PBIF, 0xb, ))
            }
            Store("FIC ", Index(PBIF, 0xc, ))
            Release(PSMX)
            Return(PBIF)
        }
        Method(UPBS) {
            Acquire(PSMX, 0xffff)
            Store(\_SB_.PCI0.PIB_.PMRD(0x1a), Local0)
            Store(\_SB_.PCI0.PIB_.PMRD(0x1b), Local1)
            Multiply(Local1, 0x0100, Local2)
            Or(Local2, Local0, Local3)
            Store(Local3, Index(PBST, 0x0, ))
            Store(\_SB_.PCI0.PIB_.PMRD(0xa4), Local0)
            Store(Local0, Index(PBST, 0x2, ))
            Store(0x2580, Index(PBST, 0x3, ))
            Release(PSMX)
            Return(PBST)
        }
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(BSTA, 0x1f)
        Name(FBIF, 0x1)
        Name(FSTA, 0x1)
        Name(GGFG, 0x0)
        Name(PBIF, Package(0xd) {
            0x0,
            0x78,
            0x64,
            0x1,
            0x2580,
            0x8,
            0x3,
            0x1,
            0x1,
            "???",
            "???",
            "???",
            "???",
        })
        Name(PBST, Package(0x4) {
            0x1,
            0xffffffff,
            0x64,
            0x2580,
        })
    }
    Device(LID_) {
        Name(_HID, 0x0d0cd041)
        Name(LIDF, 0x1)
        Method(_LID) {
            SHOW("LID_LID Return:")
            SHOW(LIDF)
            Return(LIDF)
        }
        Name(_PRW, Package(0x2) {
            0x8,
            0x1,
        })
    }
    Device(PWRB) {
        Name(_HID, 0x0c0cd041)
        Method(_STA) {
            Return(0xf)
        }
    }
}
Method(SHOW, 1) {
    Store("__________________________________", Debug)
    Store("", Debug)
    Store(Arg0, Debug)
    Store("__________________________________", Debug)
}
Method(BEEP, 1) {
    Store(Zero, Local0)
    While(LLess(Local0, Arg0)) {
        \_SB_.VIAX(0x87)
        Increment(Local0)
    }
}
Method(HION) {
    Store(Zero, \_SB_.PCI0.PM__.GO17)
    Store(0x1, \_SB_.PCI0.PM__.GO16)
}

}
/*
BOOT: Length=40, Revision=1, Checksum=164,
	OEMID=PTLTD, OEM Table ID=$SBFTBL$, OEM Revision=0x6040000,
	Creator ID= LTP, Creator Revision=0x1
 */

--Boundary-00=_uH6gAulf4xBbDCX--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
