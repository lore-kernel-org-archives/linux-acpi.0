From: Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Subject: Wrong battery info : some news
Date: Wed, 07 Aug 2002 01:04:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D5055F9.9050107@eavr.u-strasbg.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Recently I posted a message on this list about wrong battery informations
on my SONY VAIO. I would like to add the result of apidump concerning
BAT1. If someone could tell me how to debug this, I would appreciate.

Regards,
Jacques

PS: the output of cat /proc/acpi/battery/BAT1/info is :
present:                 yes
design capacity:         5 mWh
last full capacity:      5 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 400 mWh
design capacity low:     384 mWh
capacity granularity 1:  64 mWh
capacity granularity 2:  64 mWh
model number:            BAT1
serial number:
battery type:
OEM info:

which is apparentky the default initialization of the variable PBIF (see=20
below).
So the question is : why PBIF is not altered when calling the method _BIF=
 ?


Device(BAT1) {
        Name(_HID, 0x0a0cd041)
        Name(_UID, 0x1)
        Name(_PCL, Package(0x1) {
            \_SB_,
        })
        Name(PBIF, Package(0xd) {
            0x0,
            0x5,
            0x5,
            0x1,
            0x39d0,
            0x0190,
            0x0180,
            0x40,
            0x40,
            "BAT1",
            " ",
            " ",
            " ",
        })
        Name(PBST, Package(0x4) {
            0x0,
            0x5,
            0x5,
            0x2710,
        })
        Name(UBIF, 0x01e9)
        Name(BP__, 0x1)
        Method(_STA) {
            If(\_SB_.PCI0.PIB_.EC0_.ECON) {
                If(\_SB_.PCI0.PIB_.EC0_.ECOK) {
                    If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1400))) =
{
                        Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local6)
                        Store(0x6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        And(\_SB_.PCI0.PIB_.EC0_.BATD, 0x1, Local0)
                        Store(Local6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        If(Local0) {
                            Store(0x1, BP__)
                        }
                        Else {
                            Store(0x0, BP__)
                        }
                        Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local6)
                        Store(0x6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        Store(\_SB_.PCI0.PIB_.EC0_.BATD,=20
\_SB_.PCI0.PIB_.EC0_.BATO)
                        And(0xfffe, \_SB_.PCI0.PIB_.EC0_.BATF,=20
\_SB_.PCI0.PIB_.EC0_.BATF)
                        If(And(0xc0, \_SB_.PCI0.PIB_.EC0_.BATO, )) {
                            Or(\_SB_.PCI0.PIB_.EC0_.BATF, 0x1,=20
\_SB_.PCI0.PIB_.EC0_.BATF)
                        }
                        Store(Local6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        Release(\_SB_.PCI0.PIB_.EC0_.MUT0)
                    }
                }
            }
            If(BP__) {
                Return(0x1f)
            }
            Else {
                Return(0xf)
            }
        }
        Method(_BIF) {
            If(\_SB_.PCI0.PIB_.EC0_.ECON) {
                If(\_SB_.PCI0.PIB_.EC0_.ECOK) {
                    If(BP__) {
                        UPBI()
                    }
                    Else {
                        IVBI()
                    }
                    Store(0x01e9, UBIF)
                }
            }
            Return(PBIF)
        }
        Method(_BST) {
            If(\_SB_.PCI0.PIB_.EC0_.ECON) {
                If(\_SB_.PCI0.PIB_.EC0_.ECOK) {
                    If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1400))) =
{
                        Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local6)
                        Store(0x6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        And(\_SB_.PCI0.PIB_.EC0_.BATD, 0x1, Local0)
                        Store(Local6, \_SB_.PCI0.PIB_.EC0_.BANK)
                        Release(\_SB_.PCI0.PIB_.EC0_.MUT0)
                    }
                    If(Local0) {
                        UPBS()
                    }
                    Else {
                        IVBS()
                    }
                }
            }
            Else {
                IVBS()
            }
            Return(PBST)
        }
        Method(UPBI) {
            Store(Zero, Local0)
            If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1400))) {
                Store(VTOB(Subtract(_UID, 0x1, )), Local1)
                Or(ShiftLeft(Local1, 0xc, ), 0x0fff, Local2)
                Store(Zero, Local3)
                \_SB_.PCI0.PIB_.EC0_.SMWR(0x8, 0x14, 0x1, Local2)
                \_SB_.PCI0.PIB_.EC0_.SMRD(0x9, 0x14, 0x1, RefOf(Local3))
                Store(Zero, Local0)
                Store(0xc, Local1)
                Store(Buffer(0xd) {0x0, 0x18, 0x0, 0x0, 0x19, 0x0, 0x0,=20
0x0, 0x0, 0x21, 0x0, 0x22, 0x20 }, Local2)
                While(LGreater(Local1, 0x8)) {
                    If(LNot(And(UBIF, VTOB(Local1), ))) {
                        GBFE(Local2, Local1, RefOf(Local3))
                        If(Local3) {
                            If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0xb, 0x16,=20
Local3, RefOf(Local4)))) {
                                GBFE(Local4, 0x20, RefOf(Local5))
                                PBFE(Local4, Local5, 0x20)
                                Increment(Local5)
                                PBFE(Local4, Local5, 0x0)
                                Store(Local4, Index(PBIF, Local1, ))
                                Or(UBIF, VTOB(Local1), UBIF)
                                Store(Ones, Local0)
                            }
                        }
                    }
                    Decrement(Local1)
                }
                While(LGreater(Local1, 0x0)) {
                    If(LNot(And(UBIF, VTOB(Local1), ))) {
                        GBFE(Local2, Local1, RefOf(Local3))
                        If(Local3) {
                            If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0x9, 0x16,=20
Local3, RefOf(Local5)))) {
                                Store(Local5, Index(PBIF, Local1, ))
                                Or(UBIF, VTOB(Local1), UBIF)
                                Store(Ones, Local0)
                            }
                        }
                    }
                    Decrement(Local1)
                }
                Store(0xa, Local1)
                If(LNot(And(UBIF, VTOB(Local1), ))) {
                    If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0x9, 0x16, 0x1c,=20
RefOf(Local5)))) {
                        Store(ToBCD(Local5, ), Local0)
                        Store(ITOS(Local0), Index(PBIF, Local1, ))
                        Or(UBIF, VTOB(Local1), UBIF)
                        Store(Ones, Local0)
                    }
                }
                Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local1)
                Store(0x3, \_SB_.PCI0.PIB_.EC0_.BANK)
                Store(\_SB_.PCI0.PIB_.EC0_.MFCP, Local2)
                If(LEqual(Local2, 0x0)) {
                    Store(0x5, Index(PBIF, 0x2, ))
                }
                Else {
                    Multiply(Local2, 0xa, Local2)
                    Store(Local2, Index(PBIF, 0x2, ))
                }
                Store(Local1, \_SB_.PCI0.PIB_.EC0_.BANK)
                Store(DerefOf(Index(PBIF, 0x1, )), Local2)
                Multiply(Local2, 0xa, Local2)
                Store(Local2, Index(PBIF, 0x1, ))
                Release(\_SB_.PCI0.PIB_.EC0_.MUT0)
            }
            Return(Local0)
        }
        Method(UPBS) {
            Store(Zero, Local0)
            If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1388))) {
                Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local1)
                Store(0x6, \_SB_.PCI0.PIB_.EC0_.BANK)
                Store(\_SB_.PCI0.PIB_.EC0_.MBCT, Local2)
                If(And(Local2, 0x8000, )) {
                    Or(Local2, 0xffff0000, Local2)
                    Add(Not(Local2, ), 0x1, Local2)
                }
                Store(\_SB_.PCI0.PIB_.EC0_.MBVT, Local3)
                Store(0x4, \_SB_.PCI0.PIB_.EC0_.BANK)
                Store(\_SB_.PCI0.PIB_.EC0_.RCAP, Local5)
                Store(Local1, \_SB_.PCI0.PIB_.EC0_.BANK)
                If(LNot(LEqual(Local2, DerefOf(Index(PBST, 0x1, ))))) {
                    Multiply(Local2, 0xa, Local2)
                    Store(Local2, Index(PBST, 0x1, ))
                    Store(Ones, Local0)
                }
                If(LNot(LEqual(Local3, DerefOf(Index(PBST, 0x3, ))))) {
                    Multiply(Local3, 0x14, Local3)
                    Divide(Local3, 0x40, Local4, Local3)
                    Store(Local3, Index(PBST, 0x3, ))
                    Store(Ones, Local0)
                }
                If(LNot(LEqual(Local5, DerefOf(Index(PBST, 0x2, ))))) {
                    Multiply(Local5, 0xa, Local5)
                    Store(Local5, Index(PBST, 0x2, ))
                    Store(Ones, Local0)
                }
                Store(0x0, Local4)
                Store(\_SB_.PCI0.PIB_.EC0_.BANK, Local6)
                Store(0x6, \_SB_.PCI0.PIB_.EC0_.BANK)
                If(And(\_SB_.PCI0.PIB_.EC0_.BATD, 0x0c00, )) {
                    If(And(\_SB_.PCI0.PIB_.EC0_.BATD, 0x10, )) {
                    }
                    Else {
                        Or(0x2, Local4, Local4)
                    }
                }
                Else {
                    If(And(\_SB_.PCI0.PIB_.EC0_.BATD, 0x0100, )) {
                        Or(0x1, Local4, Local4)
                    }
                }
                Store(Local6, \_SB_.PCI0.PIB_.EC0_.BANK)
                If(LNot(LEqual(Local4, DerefOf(Index(PBST, 0x0, ))))) {
                    Store(Local4, Index(PBST, 0x0, ))
                    Store(Ones, Local0)
                }
                Release(\_SB_.PCI0.PIB_.EC0_.MUT0)
            }
            Return(Local0)
        }
        Method(HVBI) {
            Store(0x9650, Index(PBIF, 0x1, ))
            Store(0x9650, Index(PBIF, 0x2, ))
            Store(0x39d0, Index(PBIF, 0x4, ))
            Store("PCGA-BP71", Index(PBIF, 0x9, ))
            Store("LION", Index(PBIF, 0xb, ))
            Store("Sony Corp.", Index(PBIF, 0xc, ))
        }
        Method(IVBI) {
            Store(0x01e9, UBIF)
            Store(0x5, Index(PBIF, 0x1, ))
            Store(0x5, Index(PBIF, 0x2, ))
            Store(0x5, Index(PBIF, 0x4, ))
            Store("Bad", Index(PBIF, 0x9, ))
            Store("Bad", Index(PBIF, 0xa, ))
            Store("Bad", Index(PBIF, 0xb, ))
            Store("Bad", Index(PBIF, 0xc, ))
        }
        Method(IVBS) {
            Store(0x0, Index(PBST, 0x0, ))
            Store(0x5, Index(PBST, 0x1, ))
            Store(0x5, Index(PBST, 0x2, ))
            Store(0x2710, Index(PBST, 0x3, ))
        }
        Method(CHBP, 1) {
            Store(Zero, Local0)
            Store(VTOB(Subtract(_UID, 0x1, )), Local1)
            Or(ShiftLeft(Local1, 0xc, ), 0x0fff, Local2)
            Store(Zero, Local3)
            If(And(Arg0, Local1, )) {
                If(BP__) {
                    UPBS()
                }
                Else {
                    If(LEqual(Local2, Or(Local3, 0x0fff, ))) {
                        UPBI()
                    }
                    UPBS()
                    Store(0x1, BP__)
                    Store(0x01e9, UBIF)
                }
            }
            Else {
                If(BP__) {
                    Store(0x0, BP__)
                    IVBI()
                    IVBS()
                    Or(0x4, Local0, Local0)
                }
            }
        }
    }

--=20
 _________________________________
(
)   Jacques GANGLOFF
(   Associate Professor
)   LSIIT / EAVR		=09
(   Bd S=E9bastien Brant=20
)   67400 Illkirch
(   Tel : +33 (0)3 90 24 44 68
)   Fax : +33 (0)3 90 24 44 80
(   http://eavr.u-strasbg.fr
)_________________________________




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
