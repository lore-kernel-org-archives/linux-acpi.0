From: Jacques GANGLOFF <jacques-gXTsMEhN/Y091FlJP1ih0VAUjnlXr6A1@public.gmane.org>
Subject: latest acpi: new behavior of the UPBI method
Date: Thu, 19 Dec 2002 15:11:15 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E01E193.3040406@eavr.u-strasbg.fr>
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
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On my VAIO FX702, I have a recurrent problem
with the battery info:

* the time needed to dump /proc/acpi/battery/BAT1/info
is about 0.5s and during this time the box is frozen.
* the last entries in info are corrupted, i.e. model number,
serial number, battery type and OEM info.

As reported by another VAIO user on this list, my feeling is
that these problems are linked.

The interesting thing with the latest acpi patch (20021212), is that
the corruption in the last entries of info has changed. Now I get :

cat /proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         44400 mWh
last full capacity:      44400 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 400 mWh
design capacity low:     384 mWh
capacity granularity 1:  64 mWh
capacity granularity 2:  64 mWh
model number:            50 43 47 41 2D 42 50 37 31 41 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0A
serial number:           20 20 20 20 20 20 20 20 00
battery type:            4C 49 4F 4E 20 43 6F 72 70 2E 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04
OEM info:                53 6F 6E 79 20 43 6F 72 70 2E 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0A

This is a progress since if we translate all the hex numbers in ASCII 
caracters we get :

model number: PCGA-BP71A
serial number:
battery type: LION Corp.
OEM info: Sony Corp.

which is rather close to what it should be (except for the "LION Corp." 
???).

So why are these information given in hex dump format ? And why
is this dump so long ? My skill in AML programming is near from
beginner, so I need some help to go further.

Below is the dump that includes the faultly method (UPBI), I suppose it 
should be a
good starting point.

Cheers,
Jacques

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
                    If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1400))) {
                        Store(0x8, \_SB_.PCI0.PIB_.DID_)
                        \_SB_.GSMI(0x8d)
                        Store(\_SB_.PCI0.PIB_.INF1, Local1)
                        And(Local1, 0x1, Local0)
                        If(Local0) {
                            Store(0x1, BP__)
                        }
                        Else {
                            Store(0x0, BP__)
                        }
                        Store(Local1, \_SB_.PCI0.PIB_.EC0_.BATO)
                        And(0xfffe, \_SB_.PCI0.PIB_.EC0_.BATF, 
\_SB_.PCI0.PIB_.EC0_.BATF)
                        If(And(0xc0, \_SB_.PCI0.PIB_.EC0_.BATO, )) {
                            Or(\_SB_.PCI0.PIB_.EC0_.BATF, 0x1, 
\_SB_.PCI0.PIB_.EC0_.BATF)
                        }
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
                    If(LNot(Acquire(\_SB_.PCI0.PIB_.EC0_.MUT0, 0x1400))) {
                        Store(0x8, \_SB_.PCI0.PIB_.DID_)
                        \_SB_.GSMI(0x8d)
                        Store(\_SB_.PCI0.PIB_.INF1, Local1)
                        And(Local1, 0x1, Local0)
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
                Store(Buffer(0xd) {0x0, 0x18, 0x0, 0x0, 0x19, 0x0, 0x0, 
0x0, 0x0, 0x21, 0x0, 0x22, 0x20 }, Local2)
                While(LGreater(Local1, 0x8)) {
                    If(LNot(And(UBIF, VTOB(Local1), ))) {
                        GBFE(Local2, Local1, RefOf(Local3))
                        If(Local3) {
                            If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0xb, 0x16, 
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
                            If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0x9, 0x16, 
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
                    If(LNot(\_SB_.PCI0.PIB_.EC0_.SMRD(0x9, 0x16, 0x1c, 
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
                Store(0x2, \_SB_.PCI0.PIB_.DID_)
                \_SB_.GSMI(0x8d)
                Store(\_SB_.PCI0.PIB_.INF1, Local2)
                If(And(Local2, 0x8000, )) {
                    Or(Local2, 0xffff0000, Local2)
                    Add(Not(Local2, ), 0x1, Local2)
                }
                Store(\_SB_.PCI0.PIB_.INF3, Local3)
                Store(\_SB_.PCI0.PIB_.INF2, Local5)
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
                Store(0x8, \_SB_.PCI0.PIB_.DID_)
                \_SB_.GSMI(0x8d)
                Store(\_SB_.PCI0.PIB_.INF1, Local7)
                If(And(Local7, 0x0c00, )) {
                    If(And(Local7, 0x10, )) {
                    }
                    Else {
                        Or(0x2, Local4, Local4)
                    }
                }
                Else {
                    If(And(Local7, 0x0100, )) {
                        Or(0x1, Local4, Local4)
                    }
                }
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

-- 
 _________________________________
(
)   Jacques GANGLOFF
(   Associate Professor
)   LSIIT / EAVR			
(   Bd Sebastien Brant
)   67400 Illkirch
(   Tel : +33 (0)3 90 24 44 68
)   Fax : +33 (0)3 90 24 44 80
(   http://eavr.u-strasbg.fr
)_________________________________




-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
