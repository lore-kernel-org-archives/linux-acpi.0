From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi-L693kI9kcNY@public.gmane.org>
Subject: Re: [AML] _OSI
Date: Fri, 30 May 2003 01:42:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ED69AF7.8020103@odi.ch>
References: <3ED691B2.8020609@odi.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000801040005020301020108"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ED691B2.8020609-L693kI9kcNY@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------000801040005020301020108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Okay, I just included some Debug statement into my DSDT.
Findings:

_OSI is not supported.

\_OS_ equals "Linux"

Follows:
Some sections in my DSDT (see attachment) are not executed on Linux.

This is the (decompiled and fixed) DSDT of an Acer TM630.

Isn't it a strange world where the BIOS is specific to an OS? And I
thought the OS should adapt to the hardware and not vice versa...


--------------000801040005020301020108
Content-Type: text/plain;
 name="dsdt.asl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dsdt.asl"

/*
RSD PTR: Checksum=3D34, OEMID=3DPTLTD, RsdtAddress=3D0x1fefa663
 */
/*
RSDT: Length=3D48, Revision=3D1, Checksum=3D0,
	OEMID=3DPTLTD, OEM Table ID=3D  RSDT, OEM Revision=3D0x6040000,
	Creator ID=3D LTP, Creator Revision=3D0x0
 */
/*
	Entries=3D{ 0x1fefeeaf, 0x1fefef23, 0x1fefef4b }
 */
/*
	DSDT=3D0x1fefa693
	INT_MODEL=3DPIC
	SCI_INT=3D9
	SMI_CMD=3D0xb1, ACPI_ENABLE=3D0xf0, ACPI_DISABLE=3D0xf1, S4BIOS_REQ=3D0x=
f2
	PM1a_EVT_BLK=3D0x8000-0x8003
	PM1a_CNT_BLK=3D0xfe10-0xfe11
	PM2_CNT_BLK=3D0x8030-0x8030
	PM2_TMR_BLK=3D0x8008-0x800b
	PM2_GPE0_BLK=3D0x8018-0x8027
	P_LVL2_LAT=3D20ms, P_LVL3_LAT=3D200ms
	FLUSH_SIZE=3D0, FLUSH_STRIDE=3D0
	DUTY_OFFSET=3D1, DUTY_WIDTH=3D3
	DAY_ALRM=3D13, MON_ALRM=3D0, CENTURY=3D50
	Flags=3D{WBINVD,PROC_C1,SLP_BUTTON,RTC_S4,TMR_VAL_EXT}
 */
/*
DSDT: Length=3D18460, Revision=3D1, Checksum=3D96,
	OEMID=3DALI, OEM Table ID=3DM1533, OEM Revision=3D0x6040000,
	Creator ID=3DMSFT, Creator Revision=3D0x100000d
 */
DefinitionBlock (
	"acpi_dsdt.aml",	//Output filename
	"DSDT",		//Signature
	0x1,			//DSDT Revision
	"ALI",			//OEMID
	"M1533",			//TABLE ID
	0x6040000			//OEM Revision
)

{
Name(BBLO, 0x0)
Name(OSTP, 0x7)
Method(OSCP, 2) {
    If(LNot(LEqual(SizeOf(Arg0), SizeOf(Arg1)))) {
        Return(0x0)
    }
    Add(SizeOf(Arg0), One, Local0)
    Name(TMB0, Buffer(Local0) { })
    Name(TMB1, Buffer(Local0) { })
    Store(Arg0, TMB0)
    Store(Arg1, TMB1)
    While(Local0) {
        Decrement(Local0)
        If(LNot(LEqual(DerefOf(Index(TMB0, Local0, )), DerefOf(Index(TMB1=
, Local0, ))))) {
            Return(0x0)
        }
    }
    Return(0x1)
}
Scope(_PR_) {
    Processor(CPU0, 1, 0x8010, 0x6) {
    }
}
OperationRegion(DBG1, SystemIO, 0x80, 0x1)
Field(DBG1, ByteAcc, NoLock, Preserve) {
    PX80,	8
}
Name(_S0_, Package(0x2) {
    0x0,
    0x0,
})
Name(_S3_, Package(0x2) {
    0x3,
    0x3,
})
Name(_S4_, Package(0x2) {
    0x4,
    0x4,
})
Name(_S5_, Package(0x2) {
    0x5,
    0x5,
})
Method(_PTS, 1) {
    If(LEqual(Arg0, 0x3)) {
        If(LOr(LEqual(OSTP, 0x0), LEqual(OSTP, 0x2))) {
            Store(0x8e, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
        }
    }
    If(LEqual(Arg0, 0x4)) {
        Store(0x5, BBLO)
    }
    If(LEqual(Arg0, 0x5)) {
        Store(0x5, PX80)
        Store(0x8b, \_SB_.PCI0.ISA_.BCMD)
        Store(Zero, \_SB_.PCI0.ISA_.SMIC)
    }
}
Method(_WAK, 1) {
    \_GPE._L26()
    Store(0x4, \_SB_.PCI0.PM__.R0B1)
    If(LEqual(Arg0, 0x4)) {
        Notify(\_SB_.PWRB, 0x2)
    }
    Return(Package(0x02){0x00, 0x00})
}
Scope(_SI_) {
    Method(_SST, 1) {
        If(LEqual(Arg0, 0x1)) {
            Store("=3D=3D=3D=3D=3D SST Working =3D=3D=3D=3D=3D", Debug)
        }
        If(LEqual(Arg0, 0x2)) {
            Store("=3D=3D=3D=3D=3D SST Waking =3D=3D=3D=3D=3D", Debug)
        }
        If(LEqual(Arg0, 0x3)) {
            Store("=3D=3D=3D=3D=3D SST Sleeping =3D=3D=3D=3D=3D", Debug)
        }
        If(LEqual(Arg0, 0x4)) {
            Store("=3D=3D=3D=3D=3D SST Sleeping S4 =3D=3D=3D=3D=3D", Debu=
g)
        }
    }
}
Scope(\_GPE) {
    Mutex(GLCK, 0)
    Method(_L00) {
        Notify(\_SB_.SLPB, 0x2)
    }
    Method(_L01) {
        And(\_SB_.PCI0.PM__.R088, 0x2, Local0)
        If(LEqual(Local0, 0x2)) {
            Store(0x1, \_SB_.LID_.LIDS)
            Store(\_SB_.PCI0.PM__.R084, Local1)
            And(Local1, 0xf, Local2)
            Or(Local2, 0x30, Local2)
            Store(Local2, \_SB_.PCI0.PM__.R084)
            Notify(\_SB_.LID_, 0x2)
            Notify(\_SB_.PWRB, 0x2)
        }
        Else {
            Store(0x0, \_SB_.LID_.LIDS)
            Store(\_SB_.PCI0.PM__.R084, Local1)
            And(Local1, 0xf, Local2)
            Or(Local2, 0x50, Local2)
            Store(Local2, \_SB_.PCI0.PM__.R084)
        }
        Notify(\_SB_.LID_, 0x80)
    }
    Method(_L26) {
        If(LOr(LEqual(OSTP, 0x0), LEqual(OSTP, 0x2))) {
            Sleep(0x03e8)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x0)
            Notify(\_SB_.PCI0.IDE_.SECN.SLAV, 0x0)
            Sleep(0x64)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x1)
            Notify(\_SB_.PCI0.IDE_.SECN.SLAV, 0x1)
        }
        Else {
            Acquire(\_SB_.PCI0.ISA_.EC__.MUT0, 0xffff)
            Store(0xb, \_SB_.PCI0.ISA_.EC__.DAT1)
            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
            Sleep(0x64)
            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local0)
            Store(0x1e, \_SB_.PCI0.ISA_.EC__.DAT1)
            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
            Sleep(0x64)
            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local1)
            ShiftLeft(Local1, 0x1, Local1)
            Or(Local0, Local1, Local0)
            Release(\_SB_.PCI0.ISA_.EC__.MUT0)
            Sleep(0x32)
            If(LEqual(Local0, 0x3)) {
                Store(0x0, \_SB_.PCI0.ISA_.SSIG)
                And(\_SB_.PCI0.PM__.R09D, 0xf7, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x2)) {
                Store(0x0, \_SB_.PCI0.ISA_.SSIG)
                And(\_SB_.PCI0.PM__.R09D, 0xf7, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x0)) {
                Store(0x1, \_SB_.PCI0.ISA_.SSIG)
                Or(\_SB_.PCI0.PM__.R09D, 0x8, \_SB_.PCI0.PM__.R09D)
            }
            If(LEqual(Local0, 0x1)) {
                Store(0x1, \_SB_.PCI0.ISA_.SSIG)
                Or(\_SB_.PCI0.PM__.R09D, 0x8, \_SB_.PCI0.PM__.R09D)
            }
            Sleep(0xc8)
            Notify(\_SB_.PCI0.ISA_.FDC_, 0x0)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x0)
            Sleep(0xc8)
            Notify(\_SB_.PCI0.ISA_.FDC_, 0x1)
            Notify(\_SB_.PCI0.IDE_.SECN.MAST, 0x1)
        }
    }
    Method(_L30) {
        Acquire(\_GPE.GLCK, 0xffff)
        Store("----------------- Thermal event -------------------", Debu=
g)
        Store(0x81, \_SB_.PCI0.ISA_.BCMD)
        Store(Zero, \_SB_.PCI0.ISA_.SMIC)
        Store(\_SB_.PCI0.ISA_.INF_, Local0)
        Store(Local0, Debug)
        If(Local0) {
            Notify(\_TZ_.THRS, 0x80)
            Notify(\_TZ_.THRC, 0x80)
        }
        Release(\_GPE.GLCK)
    }
    Method(_L09) {
        Store("---- PMEJ event -----", Debug)
        Notify(\_SB_.PCI0.CRD0, 0x0)
        Notify(\_SB_.PCI0.CRD0, 0x2)
        Notify(\_SB_.PCI0.MDM_, 0x0)
        Notify(\_SB_.PCI0.MDM_, 0x2)
        Notify(\_SB_.PCI0.LAN_, 0x0)
    }
    Method(_L21) {
        Store(0x89, \_SB_.PCI0.ISA_.BCMD)
        Store(Zero, \_SB_.PCI0.ISA_.SMIC)
        Store(\_SB_.PCI0.PM__.R08F, Local1)
        And(Local1, 0x9f, Local1)
        And(\_SB_.PCI0.PM__.R098, 0x2, Local0)
        If(Local0) {
            Or(Local1, 0x30, Local1)
        }
        Else {
            Or(Local1, 0x50, Local1)
        }
        Store(Local1, \_SB_.PCI0.PM__.R08F)
        Store(0x82, \_SB_.PCI0.ISA_.BCMD)
        Store(Zero, \_SB_.PCI0.ISA_.SMIC)
        Notify(\_SB_.BAT0, 0x80)
        Notify(\_SB_.AC__, 0x80)
    }
    Method(_L03) {
        Notify(\_SB_.BAT0, 0x80)
    }
}
Scope(_TZ_) {
    Name(TBSE, 0x0aac)
    Name(DCRT, 0x0dcc)
    ThermalZone(THRS) {
        Method(_TMP) {
            Store("SYST of _TMP =3D", Debug)
            Store(0x80, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            And(Local0, 0x80, Local1)
            If(LEqual(Local1, 0x80)) {
                Store(0x1e, Local0)
            }
            Else {
                If(LNot(LGreater(Local0, 0x10))) {
                    Store(0x11, Local0)
                }
            }
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Method(_CRT) {
            Store("SYS T5 _CRT =3D", Debug)
            Store(0x83, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Method(_SCP, 1) {
            Store("_SCP", Debug)
        }
        Name(_PSL, Package(0x1) {
            \_PR_.CPU0,
        })
        Method(_PSV) {
            Store("SYS T4 _CRT =3D", Debug)
            Store(0x87, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Name(_TC1, 0x2)
        Name(_TC2, 0x5)
        Name(_TSP, 0x012c)
    }
    ThermalZone(THRC) {
        Method(_TMP) {
            Store("CPU _TMP =3D", Debug)
            Store(0x85, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            And(Local0, 0x80, Local1)
            If(LEqual(Local1, 0x80)) {
                Store(0x1e, Local0)
            }
            Else {
                If(LNot(LGreater(Local0, 0x10))) {
                    Store(0x11, Local0)
                }
            }
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Method(_CRT) {
            Store("CPU T5 _CRT =3D", Debug)
            Store(0x86, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Method(_SCP, 1) {
            Store("_SCP", Debug)
        }
        Name(_PSL, Package(0x1) {
            \_PR_.CPU0,
        })
        Method(_PSV) {
            Store("CPU T4 _CRT =3D", Debug)
            Store(0x88, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            Store(Local0, Debug)
            Return(Add(Multiply(Local0, 0xa, ), TBSE, ))
        }
        Name(_TC1, 0x2)
        Name(_TC2, 0x5)
        Name(_TSP, 0x012c)
    }
}
Scope(_SB_) {
    Method(_INI) {
        If(CondRefOf(_OSI, Local0)) {
            If(\_OSI("Windows 2001")) {
                Store(0x3, OSTP)
                Store(0x8c, \_SB_.PCI0.ISA_.BCMD)
                Store(Zero, \_SB_.PCI0.ISA_.SMIC)
                Store("Detected Windows XP", Debug)
            }
            Else {
                Store("unsupported OSI capable OS", Debug)
            }
        }
        Else {
            If(OSCP(\_OS_, "Microsoft Windows")) {
                Store(0x0, OSTP)
            }
            If(OSCP(\_OS_, "Microsoft Windows NT")) {
                Store(0x1, OSTP)
            }
            If(OSCP(\_OS_, "Microsoft WindowsME: Millennium Edition")) {
                Store(0x2, OSTP)
            }
            Store("Detected:", Debug)
            Store(\_OS_, Debug)
        }
    }
    Device(PWRB) {
        Name(_HID, 0x0c0cd041)
    }
    Device(SLPB) {
        Name(_HID, 0x0e0cd041)
        Name(_PRW, Package(0x2) {
            0x0,
            0x3,
        })
    }
    Device(LID_) {
        Name(_HID, 0x0d0cd041)
        Name(LIDS, 0x1)
        Method(_LID) {
            Store(LIDS, Local1)
            If(Local1) {
                Return(0x1)
            }
            Else {
                Return(0x0)
            }
        }
        Name(_PRW, Package(0x2) {
            0x1,
            0x3,
        })
    }
    Device(BAT0) {
        Name(_HID, 0x0a0cd041)
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(BP__, 0x1)
        Name(IBP_, 0x0)
        Name(PSTA, 0x1f)
        Name(CHAR, 0x1)
        Method(VTOB, 1) {
            Store(0x1, Local0)
            ShiftLeft(Local0, Arg0, Local0)
            Return(Local0)
        }
        Method(BTOV, 1) {
            ShiftRight(Arg0, 0x1, Local0)
            Store(0x0, Local1)
            While(Local0) {
                Increment(Local1)
                ShiftRight(Local0, 0x1, Local0)
            }
            Return(Local1)
        }
        Method(MKWD, 2) {
            If(And(Arg1, 0x80, )) {
                Store(0xffff0000, Local0)
            }
            Else {
                Store(Zero, Local0)
            }

            Or(Local0, Arg0, Local0)
            Or(Local0, ShiftLeft(Arg1, 0x8, ), Local0)
            Return(Local0)
        }
        Method(GBFE, 3) {
            CreateByteField(Arg0, Arg1, TIDX)
            Store(TIDX, Arg2)
        }
        Method(PBFE, 3) {
            CreateByteField(Arg0, Arg1, TIDX)
            Store(Arg2, TIDX)
        }
        Method(ITOS, 1) {
            Store(Buffer(0x9) {0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, =
0x20, 0x0 }, Local0)
            Store(Buffer(0x11) {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,=
 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x0 }, Local7)
            Store(0x8, Local1)
            Store(0x0, Local2)
            Store(0x0, Local3)
            While(Local1) {
                Decrement(Local1)
                And(ShiftRight(Arg0, ShiftLeft(Local1, 0x2, ), ), 0xf, Lo=
cal4)
                If(Local4) {
                    Store(Ones, Local3)
                }
                If(Local3) {
                    GBFE(Local7, Local4, RefOf(Local5))
                    PBFE(Local0, Local2, Local5)
                    Increment(Local2)
                }
            }
            Return(Local0)
        }
        Name(PBIF, Package(0xd) {
            0x1,
            0xffffffff,
            0xffffffff,
            0x1,
            0xffffffff,
            0x1e,
            0x14,
            0xa,
            0x0d8e,
            "BAT0",
            " ",
            " ",
            "ACER",
        })
        Name(PBST, Package(0x4) {
            0x0,
            0xffffffff,
            0xffffffff,
            0x39d0,
        })
        Name(UBIF, 0x01e9)
        Name(SMBF, Zero)
        Method(_STA) {
            If(\_SB_.PCI0.ISA_.EC__.ECOK) {
                If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                    Return(0xf)
                }
                Else {
                    Return(0x1f)
                }
            }
            Else {
                Return(0xf)
            }
        }
        Method(_BIF) {
            If(\_SB_.PCI0.ISA_.EC__.ECOK) {
                If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                    IVBI()
                }
                Else {
                    UPBI()
                }
            }
            Else {
                IVBI()
            }
            Store("BAT0_BIF_RETURN:", Debug)
            Return(PBIF)
        }
        Method(_BST) {
            If(\_SB_.PCI0.ISA_.EC__.ECOK) {
                If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                    IVBS()
                }
                Else {
                    UPBS()
                }
            }
            Else {
                IVBS()
            }
            Store("BAT0_BST_RETURN:", Debug)
            Return(PBST)
        }
        Method(IVBI) {
            Store(0x01e9, UBIF)
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
            Store(0x0f50, Index(PBIF, 0x1, ))
            Store(0x0f50, Index(PBIF, 0x2, ))
            Store(0x39d0, Index(PBIF, 0x4, ))
            Store(0x1e, Index(PBIF, 0x5, ))
            Store(0x14, Index(PBIF, 0x6, ))
            Store(0xa, Index(PBIF, 0x7, ))
            Store(0x0d8e, Index(PBIF, 0x8, ))
            Store("Bat0", Index(PBIF, 0x9, ))
            Store("   ", Index(PBIF, 0xa, ))
            Store("Lion", Index(PBIF, 0xb, ))
            Store("Acer", Index(PBIF, 0xc, ))
        }
        Method(UPBS) {
            Store(0x84, \_SB_.PCI0.ISA_.BCMD)
            Store(Zero, \_SB_.PCI0.ISA_.SMIC)
            Store(\_SB_.PCI0.ISA_.INF_, Local0)
            If(LEqual(Local0, 0x0)) {
                If(LGreater(BBLO, 0x0)) {
                    Store(0x64, Local0)
                    Decrement(BBLO)
                }
            }
            And(\_SB_.PCI0.PM__.R098, 0x2, Local1)
            If(LEqual(Local1, 0x2)) {
                If(LNot(LLess(Local0, 0x63))) {
                    Store(0x1, Index(PBST, 0x0, ))
                    Store(0x64, Local0)
                }
                Else {
                    Store(0x2, Index(PBST, 0x0, ))
                }
            }
            Else {
                If(LNot(LGreater(Local0, 0x3))) {
                    Store(0x5, Index(PBST, 0x0, ))
                }
                Else {
                    Store(0x1, Index(PBST, 0x0, ))
                }
            }
            Multiply(Local0, 0x28, Local2)
            Store(0xffffffff, Index(PBST, 0x1, ))
            Store(Local2, Index(PBST, 0x2, ))
            Store(0x39d0, Index(PBST, 0x3, ))
        }
        Method(CHBP) {
            Store(Zero, Local0)
            If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                Store("--------------------------------BAT0 is not presen=
t", Debug)
                If(BP__) {
                    Store("--------------------------------BAT0 is just d=
isconnected", Debug)
                    Store(0x0, BP__)
                    IVBI()
                    IVBS()
                    Or(0x4, Local0, Local0)
                }
            }
            Else {
                If(BP__) {
                    Store("--------------------------------BAT0 is still =
present", Debug)
                    UPBI()
                    Or(0x1, Local0, Local0)
                    UPBS()
                    Or(0x2, Local0, Local0)
                    Store("------local0.0 =3D BAT0 PBIF modified-----", D=
ebug)
                    Store(Local0, Debug)
                    Store("------local0.1 =3D BAT0 PBST modified-----", D=
ebug)
                }
                Else {
                    Store("--------------------------------BAT0 just conn=
ect", Debug)
                    UPBI()
                    UPBS()
                    Store(0x1, BP__)
                    Or(0x5, Local0, Local0)
                    Store(0x01e9, UBIF)
                }
            }
            Return(Local0)
        }
        Method(CHSM) {
            If(LNot(\_SB_.PCI0.ISA_.EC__.SMRD(0x9, 0x16, 0xa, RefOf(Local=
5)))) {
                Store(Zero, SMBF)
            }
            Else {
                Store(One, SMBF)
            }
        }
    }
    Device(AC__) {
        Name(_HID, "ACPI0003")
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Method(_STA) {
            Store("------------------------- AC_STA", Debug)
            If(\_SB_.PCI0.ISA_.EC__.ECOK) {
                \_SB_.PCI0.ISA_.EC__.BPOL()
                If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                    Store(0x88, \_SB_.PCI0.ISA_.EC__.P60S)
                }
                Else {
                    Store(0x98, \_SB_.PCI0.ISA_.EC__.P60S)
                }
                Store(0x80, \_SB_.PCI0.ISA_.EC__.P60T)
            }
            Return(0xf)
        }
        Name(ACFG, 0x0)
        Name(ACP_, 0x1)
        Method(_PSR) {
            Store(ACP_, Local1)
            Store(And(\_SB_.PCI0.PM__.R098, 0x2, ), Local1)
            If(Local1) {
                Store("--------------------------------------- AC Present=
   ", Debug)
                Return(0x1)
            }
            Else {
                Store("--------------------------------------- AC Non-pre=
sent", Debug)
                Return(0x0)
            }
        }
        Method(CHAC) {
            Store(And(\_SB_.PCI0.PM__.R098, 0x2, ), Local0)
            If(Local0) {
                Store(0x1, Local0)
            }
            Store(One, Local0)
            If(LNot(LEqual(Local0, ACP_))) {
                Store("--------------------------------------- Access CHA=
C", Debug)
                Store(Local0, ACP_)
                Notify(\_SB_.AC__, 0x0)
                Return(Ones)
            }
            Else {
                Return(Zero)
            }
        }
        Method(FLPA) {
            Store("--------------------------------------- FLIP AC to For=
ce", Debug)
            If(ACP_) {
                Store(0x0, ACP_)
            }
            Else {
                Store(0x1, ACP_)
            }
            Notify(\_SB_.AC__, 0x0)
        }
    }
    Device(PCI0) {
        Name(_HID, 0x030ad041)
        Name(_ADR, 0x0)
        Method(_INI) {
            If(CondRefOf(_OSI, Local0)) {
                If(\_OSI("Windows 2001")) {
                    Store(0x3, OSTP)
                    Store(0x8c, \_SB_.PCI0.ISA_.BCMD)
                    Store(Zero, \_SB_.PCI0.ISA_.SMIC)
                }
            }
            Else {
                If(OSCP(\_OS_, "Microsoft Windows")) {
                    Store(0x0, OSTP)
                }
                If(OSCP(\_OS_, "Microsoft Windows NT")) {
                    Store(0x1, OSTP)
                }
                If(OSCP(\_OS_, "Microsoft WindowsME: Millennium Edition")=
) {
                    Store(0x2, OSTP)
                }
            }
        }
        Name(_BBN, 0x0)
        OperationRegion(REGS, PCI_Config, 0x90, 0x70)
        Field(REGS, ByteAcc, NoLock, Preserve) {
            SR90,	8,
            SR91,	8,
            SR92,	8,
            SR93,	8,
            Offset(0x6e),
            SRFE,	8,
            SRFF,	8
        }
        Name(RSRC, Buffer(0x01b7) {0x88, 0xe, 0x0, 0x2, 0xe, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0xff, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x87, 0x18, 0x0, 0x0, 0x=
e, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xa, 0x0, 0xff, 0xff, 0xb, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc, 0x0, 0xff, 0x3f, 0xc, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x40, 0xc, 0x0, 0xff, 0x7f, 0xc, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x80, 0xc, 0x0, 0xff, 0xbf, 0xc, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, =
0x0, 0x0, 0xc0, 0xc, 0x0, 0xff, 0xff, 0xc, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0xd, 0x0, 0xff, 0x3f, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, =
0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x40, 0xd, 0x0, 0xff, 0x7f, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, =
0x0, 0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x80, =
0xd, 0x0, 0xff, 0xbf, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, =
0x0, 0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc0, 0xd, =
0x0, 0xff, 0xff, 0xd, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, =
0x87, 0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xe, 0x0, 0=
xff, 0x3f, 0xe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, =
0x18, 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0xe, 0x0, 0xff, =
0x7f, 0xe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18,=
 0x0, 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x80, 0xe, 0x0, 0xff, 0xbf,=
 0xe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0,=
 0x0, 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc0, 0xe, 0x0, 0xff, 0xff, 0xe,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x0, 0x0, 0x0, 0x87, 0x18, 0x0, 0x0,=
 0xe, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xff, 0xff, 0xff, 0xff=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x47, 0x1, 0xf8, 0xc, 0xf8=
, 0xc, 0x1, 0x8, 0x88, 0xe, 0x0, 0x1, 0xc, 0x3, 0x0, 0x0, 0x0, 0x0, 0xf7,=
 0xc, 0x0, 0x0, 0xf8, 0xc, 0x0, 0x88, 0xe, 0x0, 0x1, 0xc, 0x3, 0x0, 0x0, =
0x0, 0xd, 0xff, 0xff, 0x0, 0x0, 0x0, 0xf3, 0x0, 0x79, 0x0 })
        Method(_CRS, 0, Serialized) {
            CreateBitField(RSRC, 0x0188, C0RW)
            CreateDWordField(RSRC, 0x42, C0LN)
            Store(One, C0RW)
            Store(0x4000, C0LN)
            If(And(SR90, 0x1, )) {
                Store(0x0, C0LN)
            }
            CreateBitField(RSRC, 0x0260, C4RW)
            CreateDWordField(RSRC, 0x5d, C4LN)
            Store(One, C4RW)
            Store(0x4000, C4LN)
            If(And(SR90, 0x4, )) {
                Store(0x0, C4LN)
            }
            CreateBitField(RSRC, 0x0338, C8RW)
            CreateDWordField(RSRC, 0x78, C8LN)
            Store(One, C8RW)
            Store(0x4000, C8LN)
            If(And(SR90, 0x10, )) {
                Store(0x0, C8LN)
            }
            CreateBitField(RSRC, 0x0410, CCRW)
            CreateDWordField(RSRC, 0x93, CCLN)
            Store(One, CCRW)
            Store(0x4000, CCLN)
            If(And(SR90, 0x40, )) {
                Store(0x0, CCLN)
            }
            CreateBitField(RSRC, 0x04e8, D0RW)
            CreateDWordField(RSRC, 0xae, D0LN)
            Store(One, D0RW)
            Store(0x4000, D0LN)
            If(And(SR91, 0x1, )) {
                Store(0x0, D0LN)
            }
            CreateBitField(RSRC, 0x05c0, D4RW)
            CreateDWordField(RSRC, 0xc9, D4LN)
            Store(One, D4RW)
            Store(0x4000, D4LN)
            If(And(SR91, 0x4, )) {
                Store(0x0, D4LN)
            }
            CreateBitField(RSRC, 0x0698, D8RW)
            CreateDWordField(RSRC, 0xe4, D8LN)
            Store(One, D8RW)
            Store(0x4000, D8LN)
            If(And(SR91, 0x10, )) {
                Store(0x0, D8LN)
            }
            CreateBitField(RSRC, 0x0770, DCRW)
            CreateDWordField(RSRC, 0xff, DCLN)
            Store(One, DCRW)
            Store(0x4000, DCLN)
            If(And(SR91, 0x40, )) {
                Store(0x0, DCLN)
            }
            CreateBitField(RSRC, 0x0848, E0RW)
            CreateDWordField(RSRC, 0x011a, E0LN)
            Store(One, E0RW)
            Store(0x4000, E0LN)
            If(And(SR92, 0x1, )) {
                Store(0x0, E0LN)
            }
            CreateBitField(RSRC, 0x0920, E4RW)
            CreateDWordField(RSRC, 0x0135, E4LN)
            Store(One, E4RW)
            Store(0x4000, E4LN)
            If(And(SR92, 0x4, )) {
                Store(0x0, E4LN)
            }
            CreateBitField(RSRC, 0x09f8, E8RW)
            CreateDWordField(RSRC, 0x0150, E8LN)
            Store(One, E8RW)
            Store(0x4000, E8LN)
            If(And(SR92, 0x10, )) {
                Store(0x0, E8LN)
            }
            CreateBitField(RSRC, 0x0ad0, ECRW)
            CreateDWordField(RSRC, 0x016b, ECLN)
            Store(One, ECRW)
            Store(0x4000, ECLN)
            If(And(SR92, 0x40, )) {
                Store(0x0, ECLN)
            }
            CreateDWordField(RSRC, 0x017a, BTMN)
            CreateDWordField(RSRC, 0x0186, BTLN)
            Multiply(SRFE, 0x00100000, Local0)
            Multiply(SRFF, 0x10000000, Local1)
            Add(Local0, Local1, BTMN)
            Add(Not(BTMN, ), 0x1, BTLN)
            Return(RSRC)
        }
        Method(_STA) {
            Return(0xf)
        }
        Name(_PRT, Package(0xe) {
            Package(0x4) {
                0x0001ffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x0014ffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKU,
                0x0,
            },
            Package(0x4) {
                0x0008ffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKG,
                0x0,
            },
            Package(0x4) {
                0x0006ffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKH,
                0x0,
            },
            Package(0x4) {
                0x000affff,
                0x0,
                \_SB_.PCI0.ISA_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x0013ffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKB,
                0x0,
            },
            Package(0x4) {
                0x0013ffff,
                0x1,
                \_SB_.PCI0.ISA_.LNKB,
                0x0,
            },
            Package(0x4) {
                0x000bffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKC,
                0x0,
            },
            Package(0x4) {
                0x000cffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKD,
                0x0,
            },
            Package(0x4) {
                0x000cffff,
                0x1,
                \_SB_.PCI0.ISA_.LNKF,
                0x0,
            },
            Package(0x4) {
                0x000dffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x000dffff,
                0x1,
                \_SB_.PCI0.ISA_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x000dffff,
                0x2,
                \_SB_.PCI0.ISA_.LNKA,
                0x0,
            },
            Package(0x4) {
                0x000fffff,
                0x0,
                \_SB_.PCI0.ISA_.LNKE,
                0x0,
            },
        })
        Device(ISA_) {
            Name(_ADR, 0x00070000)
            Mutex(PSMX, 0)
            OperationRegion(CFG_, PCI_Config, 0x0, 0xff)
            Field(CFG_, ByteAcc, NoLock, Preserve) {
                Offset(0x58),
                ,	3,
                SSIG,	1
            }
            OperationRegion(PUSB, PCI_Config, 0x74, 0x1)
            Field(PUSB, ByteAcc, NoLock, Preserve) {
                PIRU,	4,
                Offset(0x1)
            }
            OperationRegion(PIRX, PCI_Config, 0x48, 0x4)
            Field(PIRX, ByteAcc, NoLock, Preserve) {
                PIRA,	4,
                PIRB,	4,
                PIRC,	4,
                PIRD,	4,
                PIRE,	4,
                PIRF,	4,
                PIRG,	4,
                PIRH,	4
            }
            Name(IPRS, Buffer(0x6) {0x23, 0x0, 0xc, 0x18, 0x79, 0x0 })
            Name(IPR1, Buffer(0x6) {0x23, 0x0, 0x4, 0x18, 0x79, 0x0 })
            Name(IPR2, Buffer(0x6) {0x23, 0x0, 0x8, 0x18, 0x79, 0x0 })
            Name(IXLT, Package(0x10) {
                0x0,
                0x0200,
                0x8,
                0x0400,
                0x10,
                0x20,
                0x80,
                0x40,
                0x2,
                0x0800,
                0x0,
                0x1000,
                0x0,
                0x4000,
                0x0,
                0x8000,
            })
            Device(LNKA) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x1)
                Method(_STA) {
                    If(PIRA) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR1)
                }
                Method(_DIS) {
                    Store(0x0, PIRA)
                }
                Method(_CRS) {
                    Store(IPR1, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRA, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRA)
                }
            }
            Device(LNKB) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x2)
                Method(_STA) {
                    If(PIRB) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR2)
                }
                Method(_DIS) {
                    Store(0x0, PIRB)
                }
                Method(_CRS) {
                    Store(IPR2, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRB, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRB)
                }
            }
            Device(LNKC) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x3)
                Method(_STA) {
                    If(PIRC) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR1)
                }
                Method(_DIS) {
                    Store(0x0, PIRC)
                }
                Method(_CRS) {
                    Store(IPR1, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRC, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRC)
                }
            }
            Device(LNKD) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x4)
                Method(_STA) {
                    If(PIRD) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR2)
                }
                Method(_DIS) {
                    Store(0x0, PIRD)
                }
                Method(_CRS) {
                    Store(IPR2, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRD, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRD)
                }
            }
            Device(LNKE) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x5)
                Method(_STA) {
                    If(PIRE) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR1)
                }
                Method(_DIS) {
                    Store(0x0, PIRE)
                }
                Method(_CRS) {
                    Store(IPR1, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRE, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRE)
                }
            }
            Device(LNKF) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x6)
                Method(_STA) {
                    If(PIRF) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR2)
                }
                Method(_DIS) {
                    Store(0x0, PIRF)
                }
                Method(_CRS) {
                    Store(IPR2, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRF, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRF)
                }
            }
            Device(LNKG) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x7)
                Method(_STA) {
                    If(PIRG) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR1)
                }
                Method(_DIS) {
                    Store(0x0, PIRG)
                }
                Method(_CRS) {
                    Store(IPR1, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRG, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRG)
                }
            }
            Device(LNKH) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x8)
                Method(_STA) {
                    If(PIRH) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR2)
                }
                Method(_DIS) {
                    Store(0x0, PIRH)
                }
                Method(_CRS) {
                    Store(IPR2, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRH, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRH)
                }
            }
            Device(LNKU) {
                Name(_HID, 0x0f0cd041)
                Name(_UID, 0x9)
                Method(_STA) {
                    If(PIRU) {
                        Return(0xb)
                    }
                    Else {
                        Return(0x9)
                    }
                }
                Method(_PRS) {
                    Return(IPR1)
                }
                Method(_DIS) {
                    Store(0x0, PIRU)
                }
                Method(_CRS) {
                    Store(IPR1, Local0)
                    CreateWordField(Local0, 0x1, IRA0)
                    Store(PIRU, Local1)
                    Store(DerefOf(Index(IXLT, Local1, )), IRA0)
                    Return(Local0)
                }
                Method(_SRS, 1) {
                    CreateWordField(Arg0, 0x1, IRA0)
                    Store(Match(IXLT, MEQ, IRA0, MGT, 0x0, 0x0), PIRU)
                }
            }
            Device(DMAC) {
                Name(_HID, 0x0002d041)
                Name(_CRS, Buffer(0x1d) {0x47, 0x1, 0x0, 0x0, 0x0, 0x0, 0=
x1, 0x10, 0x47, 0x1, 0x81, 0x0, 0x81, 0x0, 0x1, 0xf, 0x47, 0x1, 0xc0, 0x0=
, 0xc0, 0x0, 0x1, 0x20, 0x2a, 0x10, 0x2, 0x79, 0x0 })
            }
            Device(PIC_) {
                Name(_HID, 0xd041)
                Name(_CRS, Buffer(0x16) {0x47, 0x1, 0x20, 0x0, 0x20, 0x0,=
 0x1, 0x2, 0x47, 0x1, 0xa0, 0x0, 0xa0, 0x0, 0x1, 0x2, 0x23, 0x4, 0x0, 0x1=
, 0x79, 0x0 })
            }
            Device(TIME) {
                Name(_HID, 0x0001d041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0x40, 0x0, 0x40, 0x0, =
0x1, 0x4, 0x23, 0x1, 0x0, 0x1, 0x79, 0x0 })
            }
            Device(RTC_) {
                Name(_HID, 0x000bd041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0x70, 0x0, 0x70, 0x0, =
0x1, 0x2, 0x23, 0x0, 0x1, 0x1, 0x79, 0x0 })
            }
            Device(MATH) {
                Name(_HID, 0x040cd041)
                Name(_CRS, Buffer(0xe) {0x47, 0x1, 0xf0, 0x0, 0xf0, 0x0, =
0x1, 0xf, 0x23, 0x0, 0x20, 0x1, 0x79, 0x0 })
            }
            Device(SPKR) {
                Name(_HID, 0x0008d041)
                Name(_CRS, Buffer(0xa) {0x47, 0x1, 0x61, 0x0, 0x61, 0x0, =
0x1, 0x1, 0x79, 0x0 })
            }
            Device(KBC0) {
                Name(_HID, 0x0303d041)
                Name(_CRS, Buffer(0x16) {0x47, 0x1, 0x60, 0x0, 0x60, 0x0,=
 0x1, 0x1, 0x47, 0x1, 0x64, 0x0, 0x64, 0x0, 0x1, 0x1, 0x23, 0x2, 0x0, 0x1=
, 0x79, 0x0 })
            }
            Device(MSE0) {
                Name(_HID, 0x130fd041)
                Name(_CRS, Buffer(0x6) {0x23, 0x0, 0x10, 0x1, 0x79, 0x0 }=
)
            }
            Device(SYSR) {
                Name(_HID, 0x020cd041)
                Name(_CRS, Buffer(0x72) {0x47, 0x1, 0x80, 0x0, 0x80, 0x0,=
 0x1, 0x1, 0x47, 0x1, 0x22, 0x0, 0x22, 0x0, 0x1, 0x1, 0x47, 0x1, 0xb1, 0x=
0, 0xb1, 0x0, 0x1, 0x1, 0x47, 0x1, 0x92, 0x0, 0x92, 0x0, 0x1, 0x1, 0x47, =
0x1, 0x10, 0x38, 0x10, 0x38, 0x1, 0x10, 0x47, 0x1, 0xd0, 0x4, 0xd0, 0x4, =
0x1, 0x2, 0x47, 0x1, 0x0, 0x80, 0x0, 0x80, 0x1, 0x60, 0x47, 0x1, 0xd6, 0x=
4, 0xd6, 0x4, 0x1, 0x1, 0x47, 0x1, 0x80, 0x4, 0x80, 0x4, 0x1, 0x10, 0x47,=
 0x1, 0xb, 0x4, 0xb, 0x4, 0x1, 0x1, 0x47, 0x1, 0x10, 0xfe, 0x10, 0xfe, 0x=
1, 0x2, 0x86, 0x9, 0x0, 0x0, 0x0, 0x0, 0xfc, 0xff, 0x0, 0x0, 0x4, 0x0, 0x=
86, 0x9, 0x0, 0x0, 0x0, 0x0, 0xc0, 0xfe, 0x0, 0x10, 0x0, 0x0, 0x79, 0x0 }=
)
            }
            OperationRegion(SMI0, SystemIO, 0x0000fe00, 0x00000002)
            Field(SMI0, AnyAcc, NoLock, Preserve) {
                SMIC,	8
            }
            OperationRegion(SMI1, SystemMemory, 0x1feffe4d, 0x00000100)
            Field(SMI1, AnyAcc, NoLock, Preserve) {
                BCMD,	8,
                DID_,	32,
                INFO,	2008
            }
            Field(SMI1, AnyAcc, NoLock, Preserve) {
                AccessAs(ByteAcc, 0),
                Offset(0x5),
                INF_,	8
            }
            Device(LPTB) {
                Name(MCD_, 0x13)
                Name(_HID, 0x0004d041)
                Name(_UID, 0x0)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x1, 0x0, 0x1, 0x=
1, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    Acquire(PSMX, 0xffff)
                    Store(0x1, BCMD)
                    Store(MCD_, DID_)
                    Store(Arg0, INFO)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_PRS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x2, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INFO, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
                Method(_DIS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x3, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_STA) {
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(ECP_) {
                Name(MCD_, 0x14)
                Name(_HID, 0x0104d041)
                Name(RSRC, Buffer(0x18) {0x2a, 0x0, 0x0, 0x47, 0x1, 0x0, =
0x1, 0x0, 0x1, 0x8, 0x8, 0x47, 0x1, 0x0, 0x5, 0x0, 0x5, 0x8, 0x8, 0x22, 0=
x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(B_SR, 1) {
                    Acquire(PSMX, 0xffff)
                    Store(0x1, BCMD)
                    Store(MCD_, DID_)
                    Store(Arg0, INFO)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(B_PR) {
                    Acquire(PSMX, 0xffff)
                    Store(0x2, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INFO, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
                Method(B_DI) {
                    If(LNot(LEqual(OSTP, 0x2))) {
                        Acquire(PSMX, 0xffff)
                        Store(0x3, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Release(PSMX)
                    }
                }
                Method(_STA) {
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(EPP_) {
                Name(MCD_, 0x11)
                Name(_HID, 0x0004d041)
                Name(_UID, 0x1)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x1, 0x0, 0x1, 0x=
1, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(B_SR, 1) {
                    Acquire(PSMX, 0xffff)
                    Store(0x1, BCMD)
                    Store(MCD_, DID_)
                    Store(Arg0, INFO)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(B_PR) {
                    Acquire(PSMX, 0xffff)
                    Store(0x2, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INFO, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
                Method(B_DI) {
                    Acquire(PSMX, 0xffff)
                    Store(0x3, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_STA) {
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(COMA) {
                Name(MCD_, 0xf)
                Name(_HID, 0x0105d041)
                Name(_UID, 0x1)
                Name(RSRC, Buffer(0xd) {0x47, 0x1, 0x0, 0x1, 0x0, 0x1, 0x=
1, 0x8, 0x22, 0x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    Acquire(PSMX, 0xffff)
                    Store(0x1, BCMD)
                    Store(MCD_, DID_)
                    Store(Arg0, INFO)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_PRS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x2, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INFO, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
                Method(_DIS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x3, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_STA) {
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(FIR_) {
                Name(MCD_, 0x10)
                Name(_HID, 0x23518905)
                Name(_CID, 0x1105d041)
                Name(RSRC, Buffer(0x10) {0x47, 0x1, 0x0, 0x1, 0x0, 0x1, 0=
x1, 0x8, 0x22, 0x0, 0x0, 0x2a, 0x0, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    Acquire(PSMX, 0xffff)
                    Store(0x1, BCMD)
                    Store(MCD_, DID_)
                    Store(Arg0, INFO)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_PRS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x2, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INFO, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
                Method(_DIS) {
                    Acquire(PSMX, 0xffff)
                    Store(0x3, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Release(PSMX)
                }
                Method(_STA) {
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(FDC_) {
                Name(MCD_, 0xe)
                Name(_HID, 0x0007d041)
                Device(FDD0) {
                    Name(_ADR, 0x0)
                    Name(_RMV, 0x1)
                    Method(_EJ0, 1) {
                        If(Arg0) {
                            Or(\_SB_.PCI0.PM__.R09D, 0x8, \_SB_.PCI0.PM__=
=2ER09D)
                        }
                    }
                    Method(_STA) {
                        And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                        If(LNot(LEqual(Local0, 0x0))) {
                            Return(0x0)
                        }
                        Acquire(\_SB_.PCI0.ISA_.EC__.MUT0, 0xffff)
                        Store(0xb, \_SB_.PCI0.ISA_.EC__.DAT1)
                        Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
                        Sleep(0xc8)
                        And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local0)
                        Store(0x1e, \_SB_.PCI0.ISA_.EC__.DAT1)
                        Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
                        Sleep(0xc8)
                        And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local1)
                        ShiftLeft(Local1, 0x1, Local1)
                        Or(Local0, Local1, Local0)
                        Release(\_SB_.PCI0.ISA_.EC__.MUT0)
                        Store(Local0, PX80)
                        If(LEqual(Local0, 0x2)) {
                            Return(0xf)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Name(_FDI, Package(0x10) {
                        0x0,
                        0x4,
                        0x4f,
                        0x12,
                        0x1,
                        0xdf,
                        0x2,
                        0x25,
                        0x2,
                        0x12,
                        0x1b,
                        0xff,
                        0x65,
                        0xf6,
                        0xf,
                        0x8,
                    })
                }
                Method(_FDE) {
                    Name(FDEX, Buffer(0x14) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x0 })=

                    CreateByteField(FDEX, 0x0, FDE0)
                    CreateByteField(FDEX, 0x4, FDE1)
                    Store(\_SB_.PCI0.ISA_.FDC_.FDD0._STA(), Local0)
                    If(LEqual(Local0, 0xf)) {
                        Store(0x1, FDE0)
                    }
                    Return(FDEX)
                }
                Name(RSRC, Buffer(0x18) {0x47, 0x1, 0xf0, 0x3, 0xf0, 0x3,=
 0x0, 0x6, 0x47, 0x1, 0xf7, 0x3, 0xf7, 0x3, 0x0, 0x1, 0x22, 0x40, 0x0, 0x=
2a, 0x4, 0x0, 0x79, 0x0 })
                Method(_CRS) {
                    If(And(_STA(), 0x2, )) {
                        Acquire(PSMX, 0xffff)
                        Store(0x0, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                    Return(RSRC)
                }
                Method(_SRS, 1) {
                    If(LEqual(OSTP, 0x0)) {
                        And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            Acquire(PSMX, 0xffff)
                            Store(0x1, BCMD)
                            Store(MCD_, DID_)
                            Store(Arg0, INFO)
                            Store(Zero, SMIC)
                            Release(PSMX)
                        }
                    }
                    Else {
                        Acquire(PSMX, 0xffff)
                        Store(0x1, BCMD)
                        Store(MCD_, DID_)
                        Store(Arg0, INFO)
                        Store(Zero, SMIC)
                        Release(PSMX)
                    }
                }
                Method(_PRS) {
                    If(LEqual(OSTP, 0x0)) {
                        And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            Acquire(PSMX, 0xffff)
                            Store(0x2, BCMD)
                            Store(MCD_, DID_)
                            Store(Zero, SMIC)
                            Store(INFO, Local0)
                            Release(PSMX)
                            Return(Local0)
                        }
                        Return(RSRC)
                    }
                    Else {
                        Acquire(PSMX, 0xffff)
                        Store(0x2, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Store(INFO, Local0)
                        Release(PSMX)
                        Return(Local0)
                    }
                }
                Method(_DIS) {
                    If(LEqual(OSTP, 0x0)) {
                        And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                        If(LEqual(Local0, 0x0)) {
                            Acquire(PSMX, 0xffff)
                            Store(0x3, BCMD)
                            Store(MCD_, DID_)
                            Store(Zero, SMIC)
                            Release(PSMX)
                        }
                    }
                    Else {
                        Acquire(PSMX, 0xffff)
                        Store(0x3, BCMD)
                        Store(MCD_, DID_)
                        Store(Zero, SMIC)
                        Release(PSMX)
                    }
                }
                Method(_STA) {
                    If(LEqual(OSTP, 0x0)) {
                        And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                        If(LEqual(Local0, 0x8)) {
                            Return(0x0)
                        }
                    }
                    Acquire(PSMX, 0xffff)
                    Store(0x4, BCMD)
                    Store(MCD_, DID_)
                    Store(Zero, SMIC)
                    Store(INF_, Local0)
                    Release(PSMX)
                    Return(Local0)
                }
            }
            Device(EC__) {
                Name(_HID, 0x090cd041)
                Name(_GPE, 0x22)
                Name(ECOK, 0x0)
                Method(_REG, 2) {
                    If(LEqual(Arg0, 0x3)) {
                        Store(Arg1, ECOK)
                    }
                }
                Name(_CRS, Buffer(0x12) {0x47, 0x1, 0x62, 0x0, 0x62, 0x0,=
 0x1, 0x1, 0x47, 0x1, 0x66, 0x0, 0x66, 0x0, 0x1, 0x1, 0x79, 0x0 })
                OperationRegion(ERAM, EmbeddedControl, 0x0, 0xff)
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1),
                    SCIC,	8,
                    Offset(0x4),
                    CMCD,	8,
                    DAT1,	8,
                    DAT2,	8,
                    DAT3,	8,
                    Offset(0x18),
                    SMPR,	8,
                    SMST,	8,
                    SMAD,	8,
                    SMCM,	8,
                    SMD0,	264,
                    SMAA,	8,
                    Offset(0x48),
                    P54S,	8,
                    P55S,	8,
                    P54T,	8,
                    P55T,	8,
                    P54D,	8,
                    P55D,	8,
                    ,	4,
                    P54_,	1,
                    P55_,	1,
                    Offset(0x4f),
                    Offset(0x50),
                    P60S,	8,
                    Offset(0x58),
                    P60T,	8,
                    Offset(0x5a),
                    P62T,	8,
                    P63T,	8,
                    P64T,	8,
                    P65T,	8,
                    Offset(0x78),
                    P60_,	1
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    SMW0,	16
                }
                Field(ERAM, ByteAcc, NoLock, Preserve) {
                    Offset(0x1c),
                    SMB0,	8
                }
                OperationRegion(EC01, SystemIO, 0x62, 0x1)
                Field(EC01, ByteAcc, Lock, Preserve) {
                    PX62,	8
                }
                OperationRegion(EC02, SystemIO, 0x66, 0x1)
                Field(EC02, ByteAcc, Lock, Preserve) {
                    PX66,	8
                }
                Mutex(MUT0, 0)
                Mutex(MUT1, 0)
                Method(_Q03) {
                    Store("Sleep button be pressed:----", Debug)
                    Store(0x89, \_SB_.PCI0.ISA_.BCMD)
                    Store(Zero, \_SB_.PCI0.ISA_.SMIC)
                    Notify(\_SB_.SLPB, 0x80)
                }
                Method(_Q04) {
                    If(LOr(LEqual(OSTP, 0x0), LEqual(OSTP, 0x2))) {
                        Store(0x8d, \_SB_.PCI0.ISA_.BCMD)
                        Store(Zero, \_SB_.PCI0.ISA_.SMIC)
                    }
                    Else {
                        Store(" ---- Ctrl+Alt+F5 switch ---- ", Debug)
                        Store(\_SB_.PCI0.AGP_.VGA_.SWIT, Local1)
                        If(LEqual(Local1, 0x0)) {
                            Increment(\_SB_.PCI0.AGP_.VGA_.TOGF)
                            Store(\_SB_.PCI0.AGP_.VGA_.TOGF, Local0)
                            If(LEqual(Local0, 0x1)) {
                                Store("LCD", Debug)
                                Store(One, \_SB_.PCI0.AGP_.VGA_.CRTA)
                                Store(Zero, \_SB_.PCI0.AGP_.VGA_.LCDA)
                            }
                            If(LEqual(Local0, 0x2)) {
                                Store("CRT", Debug)
                                Store(Zero, \_SB_.PCI0.AGP_.VGA_.CRTA)
                                Store(One, \_SB_.PCI0.AGP_.VGA_.LCDA)
                            }
                            If(LEqual(Local0, 0x3)) {
                                Store("Both", Debug)
                                Store(One, \_SB_.PCI0.AGP_.VGA_.CRTA)
                                Store(One, \_SB_.PCI0.AGP_.VGA_.LCDA)
                                Store(Zero, \_SB_.PCI0.AGP_.VGA_.TOGF)
                            }
                            Notify(\_SB_.PCI0.AGP_.VGA_, 0x80)
                        }
                        If(LEqual(Local1, 0x1)) {
                            Store(" SMI routine ", Debug)
                        }
                    }
                }
                Method(_Q30) {
                    If(LEqual(\_SB_.PCI0.ISA_.EC__.P60_, 0x1)) {
                        Store(0x88, \_SB_.PCI0.ISA_.EC__.P60S)
                        Notify(\_SB_.BAT0, 0x1)
                    }
                    Else {
                        Store(0x98, \_SB_.PCI0.ISA_.EC__.P60S)
                        Notify(\_SB_.BAT0, 0x0)
                    }
                    Notify(\_SB_.BAT0, 0x81)
                    Notify(\_SB_.BAT0, 0x80)
                }
                Method(RAMR, 2) {
                    If(LGreater(Arg0, 0x7f)) {
                        Store(Arg1, DAT3)
                    }
                    Store(Arg0, DAT2)
                    Store(0xba, CMCD)
                    Sleep(0xc8)
                    Return(DAT1)
                }
                Method(RAMW, 3) {
                    If(LGreater(Arg0, 0x7f)) {
                        Store(Arg2, DAT3)
                    }
                    Store(Arg0, DAT2)
                    Store(Arg1, DAT1)
                    Store(0xbb, CMCD)
                    Sleep(0xc8)
                }
                Method(COMD, 2) {
                    Store(Arg1, DAT1)
                    Store(Arg0, CMCD)
                    Sleep(0xc8)
                }
                Method(SMRD, 4) {
                    If(LNot(LEqual(Arg0, 0x7))) {
                        If(LNot(LEqual(Arg0, 0x9))) {
                            If(LNot(LEqual(Arg0, 0xb))) {
                                Return(0x19)
                            }
                        }
                    }
                    Acquire(MUT0, 0xffff)
                    Store(0x3, Local0)
                    While(LGreater(Local0, 0x1)) {
                        And(SMST, 0x40, SMST)
                        Store(Arg2, SMCM)
                        Store(Arg1, SMAD)
                        Store(Arg0, SMPR)
                        While(LNot(And(SMST, 0xbf, Local1))) {
                            Sleep(0x2)
                        }
                        If(LEqual(Local1, 0x80)) {
                            Store(0x0, Local0)
                        }
                        Else {
                            Decrement(Local0)
                        }
                    }
                    If(Local0) {
                        Store(And(Local1, 0x1f, ), Local0)
                    }
                    Else {
                        If(LEqual(Arg0, 0x7)) {
                            Store(SMB0, Arg3)
                        }
                        If(LEqual(Arg0, 0x9)) {
                            Store(SMW0, Arg3)
                        }
                        If(LEqual(Arg0, 0xb)) {
                            Store(SMD0, Arg3)
                        }
                    }
                    Release(MUT0)
                    Return(Local0)
                }
                Method(SMWR, 4) {
                    If(LNot(LEqual(Arg0, 0x6))) {
                        If(LNot(LEqual(Arg0, 0x8))) {
                            If(LNot(LEqual(Arg0, 0xa))) {
                                Return(0x19)
                            }
                        }
                    }
                    Acquire(MUT0, 0xffff)
                    Store(0x3, Local0)
                    While(LGreater(Local0, 0x1)) {
                        If(LEqual(Arg0, 0x6)) {
                            Store(Arg3, SMB0)
                        }
                        If(LEqual(Arg0, 0x8)) {
                            Store(Arg3, SMW0)
                        }
                        If(LEqual(Arg0, 0xa)) {
                            Store(Arg3, SMD0)
                        }
                        And(SMST, 0x40, SMST)
                        Store(Arg2, SMCM)
                        Store(Arg1, SMAD)
                        Store(Arg0, SMPR)
                        While(LNot(And(SMST, 0xbf, Local1))) {
                            Sleep(0x2)
                        }
                        If(LEqual(Local1, 0x80)) {
                            Store(0x0, Local0)
                        }
                        Else {
                            Decrement(Local0)
                        }
                    }
                    If(Local0) {
                        Store(And(Local1, 0x1f, ), Local0)
                    }
                    Release(MUT0)
                    Return(Local0)
                }
                Name(SMCN, 0x4)
                Method(BPOL) {
                    Store(0x6b, DAT2)
                    Store(0xf, DAT1)
                    Store(0xbb, CMCD)
                }
                Method(_Q09) {
                    BPOL()
                    Decrement(SMCN)
                    If(LNot(SMCN)) {
                        Store(0x3, SMCN)
                    }
                }
            }
        }
        Device(IDE_) {
            Name(_ADR, 0x00100000)
            Name(UDMT, Package(0x8) {
                0x1e,
                0x2d,
                0x3c,
                0x5a,
                0x78,
                0x78,
                0x78,
                0x14,
            })
            Name(PIOT, Package(0x5) {
                0x78,
                0xb4,
                0xf0,
                0x017f,
                0x0258,
            })
            Name(PIOC, Package(0x5) {
                0x4,
                0x6,
                0x8,
                0xd,
                0x10,
            })
            Name(CBCT, Package(0x5) {
                0x31,
                0x33,
                0x1,
                0x3,
                0xa,
            })
            Name(DACT, Package(0x5) {
                0x3,
                0x3,
                0x4,
                0x5,
                0x8,
            })
            Name(DRCT, Package(0x5) {
                0x1,
                0x3,
                0x4,
                0x8,
                0x8,
            })
            Name(PXLM, Package(0x5) {
                0x2,
                0x1,
                0x0,
                0x0,
                0x0,
            })
            OperationRegion(PCI_, PCI_Config, 0x0, 0x60)
            Field(PCI_, ByteAcc, NoLock, Preserve) {
                Offset(0x9),
                ,	4,
                SCHE,	1,
                PCHE,	1,
                Offset(0xa),
                Offset(0xd),
                IDLT,	8,
                Offset(0x4b),
                U66E,	1,
                Offset(0x4c),
                Offset(0x53),
                CDFI,	1,
                CDUD,	1,
                Offset(0x54),
                PFTH,	8,
                SFTH,	8,
                PUDC,	8,
                SUDC,	8,
                PAST,	8,
                PCBT,	8,
                PTM0,	8,
                PTM1,	8,
                SAST,	8,
                SCBT,	8,
                STM0,	8,
                STM1,	8
            }
            Method(GTM_, 3) {
                Store(Buffer(0x14) { }, Local0)
                CreateDWordField(Local0, 0x0, PIO0)
                CreateDWordField(Local0, 0x4, DMA0)
                CreateDWordField(Local0, 0x8, PIO1)
                CreateDWordField(Local0, 0xc, DMA1)
                CreateDWordField(Local0, 0x10, FLAG)
                Store(Zero, PIO0)
                Store(Zero, DMA0)
                Store(Zero, PIO1)
                Store(Zero, DMA1)
                Store(Zero, FLAG)
                If(Arg0) {
                    ShiftRight(And(Arg0, 0x70, ), 0x4, Local1)
                    If(LEqual(Local1, Zero)) {
                        Store(0x8, Local1)
                    }
                    Add(And(Arg0, 0xf, Local2), Local1, Local1)
                    Store(Match(^PIOC, MLE, Local1, MTR, 0x0, 0x0), Local=
2)
                    Store(DerefOf(Index(^PIOT, Local2, )), PIO0)
                    If(LNot(LGreater(PIO0, 0xf0))) {
                        Or(FLAG, 0x2, FLAG)
                    }
                }
                If(And(Arg2, 0x8, )) {
                    Store(DerefOf(Index(^UDMT, And(Arg2, 0x7, ), )), DMA0=
)
                    Or(FLAG, 0x1, FLAG)
                }
                Else {
                    Store(PIO0, DMA0)
                }
                If(Arg1) {
                    ShiftRight(And(Arg1, 0x70, ), 0x4, Local1)
                    If(LEqual(Local1, Zero)) {
                        Store(0x8, Local1)
                    }
                    Add(And(Arg1, 0xf, Local2), Local1, Local1)
                    Store(Match(^PIOC, MLE, Local1, MTR, 0x0, 0x0), Local=
2)
                    Store(DerefOf(Index(^PIOT, Local2, )), PIO1)
                    If(LNot(LGreater(PIO1, 0xf0))) {
                        Or(FLAG, 0x8, FLAG)
                    }
                }
                If(And(Arg2, 0x80, )) {
                    Store(DerefOf(Index(^UDMT, ShiftRight(And(Arg2, 0x70,=
 ), 0x4, ), )), DMA1)
                    Or(FLAG, 0x4, FLAG)
                }
                Else {
                    Store(PIO1, DMA1)
                }
                Or(FLAG, 0x10, FLAG)
                Return(Local0)
            }
            Method(STM_, 3) {
                Store(Buffer(0x6) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0 }, Local7=
)
                CreateByteField(Local7, 0x0, TM0_)
                CreateByteField(Local7, 0x1, TM1_)
                CreateByteField(Local7, 0x2, UDC_)
                CreateByteField(Local7, 0x3, AST_)
                CreateByteField(Local7, 0x4, CBT_)
                CreateByteField(Local7, 0x5, U66_)
                CreateDWordField(Arg0, 0x0, PIO0)
                CreateDWordField(Arg0, 0x4, DMA0)
                CreateDWordField(Arg0, 0x8, PIO1)
                CreateDWordField(Arg0, 0xc, DMA1)
                CreateDWordField(Arg0, 0x10, FLAG)
                Store(FLAG, Local6)
                Store(Ones, Local4)
                If(LOr(DMA0, PIO0)) {
                    If(LAnd(DMA0, LNot(PIO0))) {
                        If(And(Local6, 0x1, )) {
                            If(LAnd(LLess(DMA0, 0x1e), LNot(LLess(DMA0, 0=
xf)))) {
                                Store(0x7, Local0)
                            }
                            Else {
                                Store(Match(^UDMT, MGE, DMA0, MTR, 0x0, 0=
x0), Local0)
                            }
                            Or(Local0, 0x8, UDC_)
                            If(LLess(DMA0, 0x3c)) {
                                Store(One, U66_)
                            }
                        }
                        Store(Match(^PIOT, MGE, DMA0, MTR, 0x0, 0x0), Loc=
al0)
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM0_)
                        Store(Local0, Local4)
                    }
                    If(LAnd(LNot(DMA0), PIO0)) {
                        Store(Match(^PIOT, MGE, PIO0, MTR, 0x0, 0x0), Loc=
al0)
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM0_)
                        Store(Local0, Local4)
                    }
                    If(LAnd(DMA0, PIO0)) {
                        If(And(Local6, 0x1, )) {
                            If(LAnd(LLess(DMA0, 0x1e), LNot(LLess(DMA0, 0=
xf)))) {
                                Store(0x7, Local0)
                            }
                            Else {
                                Store(Match(^UDMT, MGE, DMA0, MTR, 0x0, 0=
x0), Local0)
                            }
                            Or(Local0, 0x8, UDC_)
                            If(LLess(DMA0, 0x3c)) {
                                Store(One, U66_)
                            }
                        }
                        If(LNot(LLess(PIO0, DMA0))) {
                            Store(Match(^PIOT, MGE, PIO0, MTR, 0x0, 0x0),=
 Local0)
                            Store(Local0, Local4)
                        }
                        Else {
                            Store(Match(^PIOT, MGE, DMA0, MTR, 0x0, 0x0),=
 Local0)
                            Store(Local0, Local4)
                        }
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM0_)
                    }
                }
                Store(Ones, Local5)
                If(LOr(DMA1, PIO1)) {
                    If(LAnd(DMA1, LNot(PIO1))) {
                        If(And(Local6, 0x4, )) {
                            If(LAnd(LLess(DMA1, 0x1e), LNot(LLess(DMA1, 0=
xf)))) {
                                Store(0x7, Local0)
                            }
                            Else {
                                Store(Match(^UDMT, MGE, DMA1, MTR, 0x0, 0=
x0), Local0)
                            }
                            Or(ShiftLeft(Or(Local0, 0x8, ), 0x4, ), UDC_,=
 UDC_)
                            If(LLess(DMA1, 0x3c)) {
                                Store(One, U66_)
                            }
                        }
                        Store(Match(^PIOT, MGE, DMA1, MTR, 0x0, 0x0), Loc=
al0)
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM1_)
                        Store(Local0, Local5)
                    }
                    If(LAnd(LNot(DMA1), PIO1)) {
                        Store(Match(^PIOT, MGE, PIO1, MTR, 0x0, 0x0), Loc=
al0)
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM1_)
                        Store(Local0, Local5)
                    }
                    If(LAnd(DMA1, PIO1)) {
                        If(And(Local6, 0x4, )) {
                            If(LAnd(LLess(DMA1, 0x1e), LNot(LLess(DMA1, 0=
xf)))) {
                                Store(0x7, Local0)
                            }
                            Else {
                                Store(Match(^UDMT, MGE, DMA1, MTR, 0x0, 0=
x0), Local0)
                            }
                            Or(ShiftLeft(Or(Local0, 0x8, ), 0x4, ), UDC_,=
 UDC_)
                            If(LLess(DMA1, 0x3c)) {
                                Store(One, U66_)
                            }
                        }
                        If(LNot(LLess(PIO1, DMA1))) {
                            Store(Match(^PIOT, MGE, PIO1, MTR, 0x0, 0x0),=
 Local0)
                            Store(Local0, Local5)
                        }
                        Else {
                            Store(Match(^PIOT, MGE, DMA1, MTR, 0x0, 0x0),=
 Local0)
                            Store(Local0, Local5)
                        }
                        Store(DerefOf(Index(^DACT, Local0, )), Local2)
                        Store(DerefOf(Index(^DRCT, Local0, )), Local3)
                        Add(Local3, ShiftLeft(Local2, 0x4, ), TM1_)
                    }
                }
                If(LEqual(Local4, Ones)) {
                    If(LEqual(Local5, Ones)) {
                        Store(Zero, CBT_)
                    }
                    Else {
                        Store(DerefOf(Index(^CBCT, Local5, )), CBT_)
                    }
                }
                Else {
                    If(LEqual(Local5, Ones)) {
                        Store(DerefOf(Index(^CBCT, Local4, )), CBT_)
                    }
                    Else {
                        If(LNot(LLess(Local4, Local5))) {
                            Store(DerefOf(Index(^CBCT, Local4, )), CBT_)
                        }
                        Else {
                            Store(DerefOf(Index(^CBCT, Local5, )), CBT_)
                        }
                    }
                }
                Store(0x2, AST_)
                Return(Local7)
            }
            Method(GTF0, 3) {
                Store(Buffer(0x7) {0x3, 0x0, 0x0, 0x0, 0x0, 0xa0, 0xef },=
 Local7)
                CreateByteField(Local7, 0x1, MODE)
                If(And(Arg1, 0x8, )) {
                    And(Arg1, 0x7, Local0)
                    If(LEqual(Local0, 0x7)) {
                        Store(0x5, MODE)
                    }
                    Else {
                        Subtract(0x4, Local0, MODE)
                    }
                    Or(MODE, 0x40, MODE)
                }
                Else {
                    And(Arg2, 0xf, Local0)
                    Store(Match(^DRCT, MEQ, Local0, MTR, 0x0, 0x0), Local=
1)
                    Store(DerefOf(Index(^PXLM, Local1, )), MODE)
                    Or(MODE, 0x20, MODE)
                }
                Concatenate(Local7, Local7, Local6)
                And(Arg2, 0xf, Local0)
                Store(Match(^DRCT, MEQ, Local0, MTR, 0x0, 0x0), Local1)
                Subtract(0x4, Local1, MODE)
                Or(MODE, 0x8, MODE)
                Concatenate(Local6, Local7, Local5)
                Return(Local5)
            }
            Method(GTF1, 3) {
                Store(Buffer(0x7) {0x3, 0x0, 0x0, 0x0, 0x0, 0xb0, 0xef },=
 Local7)
                CreateByteField(Local7, 0x1, MODE)
                If(And(Arg1, 0x80, )) {
                    ShiftRight(And(Arg1, 0x70, ), 0x4, Local0)
                    If(LEqual(Local0, 0x7)) {
                        Store(0x5, MODE)
                    }
                    Else {
                        Subtract(0x4, Local0, MODE)
                    }
                    Or(MODE, 0x40, MODE)
                }
                Else {
                    And(Arg2, 0xf, Local0)
                    Store(Match(^DRCT, MEQ, Local0, MTR, 0x0, 0x0), Local=
1)
                    Store(DerefOf(Index(^PXLM, Local1, )), MODE)
                    Or(MODE, 0x20, MODE)
                }
                Concatenate(Local7, Local7, Local6)
                And(Arg2, 0xf, Local0)
                Store(Match(^DRCT, MEQ, Local0, MTR, 0x0, 0x0), Local1)
                Subtract(0x4, Local1, MODE)
                Or(MODE, 0x8, MODE)
                Concatenate(Local6, Local7, Local5)
                Return(Local5)
            }
            Device(PRIM) {
                Name(_ADR, 0x0)
                Method(_GTM) {
                    Store("GTM - Primary Controller", Debug)
                    Store(^^GTM_(^^PTM0, ^^PTM1, ^^PUDC), Local0)
                    Return(Local0)
                }
                Method(_STM, 3) {
                    Store("STM - Primary Controller", Debug)
                    Store(^^STM_(Arg0, Arg1, Arg2), Local0)
                    CreateByteField(Local0, 0x0, TM0_)
                    CreateByteField(Local0, 0x1, TM1_)
                    CreateByteField(Local0, 0x2, UDC_)
                    CreateByteField(Local0, 0x3, AST_)
                    CreateByteField(Local0, 0x4, CBT_)
                    CreateByteField(Local0, 0x5, U66_)
                    Store(TM0_, ^^PTM0)
                    Store(TM1_, ^^PTM1)
                    Store(UDC_, ^^PUDC)
                    Store(AST_, ^^PAST)
                    Store(CBT_, ^^PCBT)
                    If(U66_) {
                        Store(U66_, ^^U66E)
                    }
                    Store(0x55, ^^PFTH)
                }
                Device(MAST) {
                    Name(_ADR, 0x0)
                    Method(_GTF) {
                        Store("GTF - Primary Master", Debug)
                        Store(^^^GTF0(^^^PCHE, ^^^PUDC, ^^^PTM0), Local0)=

                        Return(Local0)
                    }
                }
                Device(SLAV) {
                    Name(_ADR, 0x1)
                    Method(_GTF) {
                        Store("GTF - Primary Slave", Debug)
                        Store(^^^GTF1(^^^PCHE, ^^^PUDC, ^^^PTM1), Local0)=

                        Return(Local0)
                    }
                }
            }
            Device(SECN) {
                Name(_ADR, 0x1)
                Method(_GTM) {
                    Store("GTM - Secondary Controller", Debug)
                    Store(^^GTM_(^^STM0, ^^STM1, ^^SUDC), Local0)
                    Return(Local0)
                }
                Method(_STM, 3) {
                    Store("STM - Secondary Controller", Debug)
                    Store(^^STM_(Arg0, Arg1, Arg2), Local0)
                    CreateByteField(Local0, 0x0, TM0_)
                    CreateByteField(Local0, 0x1, TM1_)
                    CreateByteField(Local0, 0x2, UDC_)
                    CreateByteField(Local0, 0x3, AST_)
                    CreateByteField(Local0, 0x4, CBT_)
                    CreateByteField(Local0, 0x5, U66_)
                    Store(TM0_, ^^STM0)
                    Store(TM1_, ^^STM1)
                    Store(UDC_, ^^SUDC)
                    Store(AST_, ^^SAST)
                    Store(CBT_, ^^SCBT)
                    If(U66_) {
                        Store(U66_, ^^U66E)
                    }
                    Store(0x55, ^^SFTH)
                }
                Device(MAST) {
                    Name(_ADR, 0x0)
                    Method(_EJ0, 1) {
                        If(Arg0) {
                            Store(0x0, \_SB_.PCI0.ISA_.SSIG)
                            Sleep(0x32)
                            Sleep(0x32)
                        }
                    }
                    Method(_STA) {
                        If(\_SB_.PCI0.ISA_.EC__.ECOK) {
                            And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                            If(LEqual(Local0, 0x0)) {
                                Return(0x8)
                            }
                            Acquire(\_SB_.PCI0.ISA_.EC__.MUT0, 0xffff)
                            Store(0xb, \_SB_.PCI0.ISA_.EC__.DAT1)
                            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
                            Sleep(0xc8)
                            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local0)
                            Store(0x1e, \_SB_.PCI0.ISA_.EC__.DAT1)
                            Store(0xc5, \_SB_.PCI0.ISA_.EC__.CMCD)
                            Sleep(0xc8)
                            And(\_SB_.PCI0.ISA_.EC__.DAT1, 0x1, Local1)
                            ShiftLeft(Local1, 0x1, Local1)
                            Or(Local0, Local1, Local0)
                            Release(\_SB_.PCI0.ISA_.EC__.MUT0)
                            If(LOr(LEqual(Local0, 0x0), LEqual(Local0, 0x=
1))) {
                                Return(0xf)
                            }
                            Return(0x8)
                        }
                        Else {
                            And(\_SB_.PCI0.PM__.R09D, 0x8, Local0)
                            If(LEqual(Local0, 0x8)) {
                                Return(0xf)
                            }
                            Else {
                                Return(0x8)
                            }
                        }
                    }
                    Method(_GTF) {
                        Store("GTF - Secondary Master", Debug)
                        Store(^^^GTF0(^^^SCHE, ^^^SUDC, ^^^STM0), Local0)=

                        Return(Local0)
                    }
                }
                Device(SLAV) {
                    Name(_ADR, 0x1)
                    Method(_GTF) {
                        Store("GTF - Secondary Slave", Debug)
                        Store(^^^GTF1(^^^SCHE, ^^^SUDC, ^^^STM1), Local0)=

                        Return(Local0)
                    }
                }
            }
        }
        Device(AGP_) {
            Name(_ADR, 0x00010000)
            Device(VGA_) {
                Name(_ADR, 0x0)
                Name(SWIT, 0x1)
                Name(CRTA, 0x1)
                Name(LCDA, 0x1)
                Name(TVAF, 0x1)
                Name(TOGF, 0x0)
                Name(OSF_, 0x0)
                Method(_INI) {
                }
                Method(_DOS, 1) {
                    Store(Arg0, Local0)
                    And(Local0, 0x1, Local1)
                    Store(Local1, SWIT)
                }
                Method(_DOD) {
                    Return(Package(0x3) {
                        0x00010100,
                        0x00010110,
                        0x00010200,
                    })
                }
                Device(CRT_) {
                    Name(_ADR, 0x0100)
                    Method(_DCS) {
                        If(CRTA) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DGS) {
                        If(CRTA) {
                            Return(0x1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_DSS, 1) {
                    }
                }
                Device(LCD_) {
                    Name(_ADR, 0x0110)
                    Method(_DCS) {
                        If(LCDA) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DGS) {
                        If(LCDA) {
                            Return(0x1)
                        }
                        Else {
                            Return(0x0)
                        }
                    }
                    Method(_DSS, 1) {
                    }
                    Method(_DDC, 1) {
                        If(LEqual(Arg0, 0x1)) {
                            Return(\_SB_.PCI0.AGP_.VGA_.DDC4)
                        }
                        If(LEqual(Arg0, 0x2)) {
                            Concatenate(\_SB_.PCI0.AGP_.VGA_.DDC4, \_SB_.=
PCI0.AGP_.VGA_.DDC0, Local0)
                            Return(Local0)
                        }
                        Return(0x0)
                    }
                }
                Device(TVO_) {
                    Name(_ADR, 0x0200)
                    Method(_DCS) {
                        If(TVAF) {
                            Return(0x1f)
                        }
                        Else {
                            Return(0x1d)
                        }
                    }
                    Method(_DSS, 1) {
                    }
                    Method(_DDC, 1) {
                        If(LEqual(Arg0, 0x1)) {
                            Return(\_SB_.PCI0.AGP_.VGA_.DDC3)
                        }
                        If(LEqual(Arg0, 0x2)) {
                            Concatenate(\_SB_.PCI0.AGP_.VGA_.DDC3, \_SB_.=
PCI0.AGP_.VGA_.DDC0, Local0)
                            Return(Local0)
                        }
                        Return(0x0)
                    }
                }
                Name(DDC0, Buffer(0x80) {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0 })
                Name(DDC3, Buffer(0x80) {0x0, 0xff, 0xff, 0xff, 0xff, 0xf=
f, 0xff, 0x0, 0x41, 0xd0, 0xfe, 0x9, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0xf0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x21, 0x8, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xd3 })
                Name(DDC4, Buffer(0x80) {0x0, 0xff, 0xff, 0xff, 0xff, 0xf=
f, 0xff, 0x0, 0x36, 0x7f, 0x3, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x=
0, 0x1, 0x28, 0x1e, 0x0, 0xf0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x21, 0x8, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, =
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,=
 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xec })
            }
        }
        Device(PM__) {
            Name(_ADR, 0x00110000)
            OperationRegion(PMUR, PCI_Config, 0x0, 0xff)
            Field(PMUR, ByteAcc, NoLock, Preserve) {
                Offset(0x45),
                R045,	8,
                R046,	8,
                Offset(0x49),
                R049,	8,
                Offset(0x83),
                R083,	8,
                R084,	8,
                Offset(0x87),
                R087,	8,
                R088,	8,
                Offset(0x8f),
                R08F,	8,
                Offset(0x97),
                R097,	8,
                R098,	8,
                R099,	8,
                Offset(0x9c),
                R09C,	8,
                R09D,	8,
                Offset(0xac),
                R0AC,	8,
                Offset(0xae),
                R0AE,	8,
                Offset(0xb0),
                Offset(0xb1),
                R0B1,	8,
                SPKC,	8,
                LED0,	8,
                PLED,	8,
                Offset(0xb7),
                R0B7,	8,
                Offset(0xba),
                BLED,	8,
                Offset(0xd3),
                BEEP,	8,
                Offset(0xe0),
                PMIO,	16,
                SBIO,	16
            }
        }
        Device(MDM_) {
            Name(_ADR, 0x00080000)
            Name(_PRW, Package(0x2) {
                0xc,
                0x3,
            })
        }
        Device(CRD0) {
            Name(_ADR, 0x00130000)
            Name(_PRW, Package(0x2) {
                0x9,
                0x3,
            })
        }
        Device(LAN_) {
            Name(_ADR, 0x000a0000)
            Name(_PRW, Package(0x2) {
                0x9,
                0x4,
            })
        }
    }
}

}
/*
BOOT: Length=3D40, Revision=3D1, Checksum=3D164,
	OEMID=3DPTLTD, OEM Table ID=3D$SBFTBL$, OEM Revision=3D0x6040000,
	Creator ID=3D LTP, Creator Revision=3D0x1
 */
/*
SSDT: Length=3D181, Revision=3D1, Checksum=3D185,
	OEMID=3DPTLTD, OEM Table ID=3DACPIPST1, OEM Revision=3D0x6040000,
	Creator ID=3D LTP, Creator Revision=3D0x1
 */


--------------000801040005020301020108--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
