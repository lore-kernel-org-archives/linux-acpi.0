From: Emilio Mejia Fernandez de Velasco <emejia-EkmVulN54Sk@public.gmane.org>
Subject: Re: RV: differences between acpidump and disassembling
Date: Mon, 19 Apr 2004 13:09:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404191309.45870.emejia@ieee.org>
References: <000701c425f8$6157aef0$0301a8c0@portatil>
Reply-To: emejia-EkmVulN54Sk@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5N7gAcL4lUM7Om7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000701c425f8$6157aef0$0301a8c0-qXvZZVhXUsA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_5N7gAcL4lUM7Om7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Sergio,=20
Here I send you the files as you asked:
By the way, I have posted a new thread because there is one small differenc=
e=20
respect to the first message that I sent, concerning to the missing=20
parameters in DefinitionBlock when I used acpidump to retrieve the dsdt=20
table.
This was due to an error while compiling the program acpidump. Now I have=20
fixed it and the only difference between the results with acpidump and the=
=20
method that you propose -getting the table from /proc/acpi/dsdt and=20
decompiling- is the missing return package in WAK function.

El Lunes, 19 de Abril de 2004 12:23, escribi=F3:
> -----Mensaje original-----
> De: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> Enviado el: domingo, 18 de abril de 2004 4:58 am
> Para: emejia-EkmVulN54Sk@public.gmane.org
> Asunto: Re: [ACPI] differences between acpidump and disassembling
>
> On Sat, 2004-04-17 at 19:47, Emilio Mej=EDa Fern=E1ndez de Velasco wrote:
> > Hello Sergio,
> > first of all, thank you for answering so soon
> > When I compile the kernel to work with ACPI I choose not to include
>
> local
>
> > APIC. Otherwise it doesn't work at all.
> > If your mean that I should disable acpi, that's how I'm working now.
>
> This is
>
> > the only way I can get a stable machine. The problem is that there are
>
> some
>
> > things that don't work, like the sound card and the network card.
> > When I choose a compilation with ACPI I leave blank the option
> > "Processor type and features ->
> > 		[ ]Local APIC support on uniprocessors"
> > Is this what you mean?
>
> yes , disable APIC support on uniprocessors , SMP and io-APIC,
>
> ACPI Looks good detect all button and don't give errors so it a little
> weird. Please send me,
> grep -i ACPI

I guess you mean grep -i acpi, with lower-case. don't you?
Anyway, I attached the file grep-i_acpi, and another one with the result of=
=20
dmesg | grep -i ACPI, in case you wanted to see when acpi appeared in the=20
bootup sequence. This second option is included in the attached file=20
dmesg_grep-i_ACPI

> and
> cat /proc/acpi/dsdt > acpi_dsdt.dat
> ./iasl  -d acpi_dsdt.dat
> ./iasl -on -tc acpi_dsdt.dsl

Attached is the file acpi_dsdt.dsl which gives no errors and no warnings.=20
Anyway, in this case, the WAK function includes the modification that I=20
added, returning a package with two zeros. This is different when I get the=
=20
asl file from acpidump. Do you think this can be the cause of the blockings?

>
> don't need Looking for DSDT in initrd ... found customized DSDT with
> 15240 bytes!

I don't know what you mean by this. I thought that it finds the customized=
=20
DSDT because I applied a patch from http://gaugusch.at/kernel.shtml
in order to get the the customized dsdt from initrd. Otherwise it would use=
=20
the default one.

>
> > If you mean to disable ACPI instead, that's the way I'm working now,
>
> in this
>
> > case I have to work with APM or the cpu fan will stop.
> > When I choose APM instead of ACPI the system is stable, but there's
>
> some
>
> > hardware that doesn't work, like the network card, the sound card, the
>
> power
>
> > button... But the system is stable
> > My problems start when I want to switch to ACPI, and then I get good
>
> results
>
> > in hardware configuration, but I can only have the computer working
>
> for some
>
> > minutes, and then it freezes.
> > Is this what you meant to say?
> >
> > Thank you
> >
> > >On Sat, 2004-04-17 at 15:59, Emilio Mej=EDa Fern=E1ndez de Velasco wro=
te:
> > >> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> > >
> > >when this happens, my empiric experience says that you should try ,
> > >disable APIC in kernel configuration
> > >or
> > >boot with nolapic option ( that disable apic )
> > >
> > >let me know the result of the test.
> > >
> > >thanks,
> > >--
> > >S=E9rgio M. B.


Thank you very much

Emilio

--Boundary-00=_5N7gAcL4lUM7Om7
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="acpi_dsdt.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="acpi_dsdt.dsl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20030918
 *
 * Disassembly of acpi_dsdt.dat, Mon Apr 19 12:38:33 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "PTL_ACPI", 100925440)
{
    Scope (_PR)
    {
        Processor (CPU0, 0x01, 0x00008010, 0x06) {}
    }

    Name (_S0, Package (0x02)
    {
        Zero, 
        Zero
    })
    Name (_S1, Package (0x02)
    {
        0x04, 
        0x04
    })
    Name (_S4, Package (0x02)
    {
        0x02, 
        0x02
    })
    Name (_S5, Package (0x02)
    {
        0x02, 
        0x02
    })
    Name (UBH1, Buffer (0x05)
    {
        0x00, 0x00, 0x00, 0x00, 0x00
    })
    CreateByteField (UBH1, Zero, HA04)
    CreateByteField (UBH1, One, HA20)
    CreateByteField (UBH1, 0x02, HA21)
    CreateByteField (UBH1, 0x03, HA22)
    CreateByteField (UBH1, 0x04, HA23)
    Name (UBH2, Buffer (0x05)
    {
        0x00, 0x00, 0x00, 0x00, 0x00
    })
    CreateByteField (UBH2, Zero, HB04)
    CreateByteField (UBH2, One, HB20)
    CreateByteField (UBH2, 0x02, HB21)
    CreateByteField (UBH2, 0x03, HB22)
    CreateByteField (UBH2, 0x04, HB23)
    Method (_PTS, 1, NotSerialized)
    {
        If (LNot (LEqual (Arg0, 0x05)))
        {
            BEEP (One)
        }

        Store (Zero, \_SB.PCI0.PM.GO18)
        If (LEqual (Arg0, One))
        {
            \_SB.VIAX (0x88)
        }

        If (LEqual (Arg0, 0x03))
        {
            \_SB.VIAX (0x80)
            Store (\_SB.PCI0.USB0.UA04, HA04)
            Store (\_SB.PCI0.USB0.UA20, HA20)
            Store (\_SB.PCI0.USB0.UA21, HA21)
            Store (\_SB.PCI0.USB0.UA22, HA22)
            Store (\_SB.PCI0.USB0.UA23, HA23)
            Store (\_SB.PCI0.USB1.UB04, HB04)
            Store (\_SB.PCI0.USB1.UB20, HB20)
            Store (\_SB.PCI0.USB1.UB21, HB21)
            Store (\_SB.PCI0.USB1.UB22, HB22)
            Store (\_SB.PCI0.USB1.UB23, HB23)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.PCI0.PIB.PMWT (0xB8, Zero)
            \_SB.VIAX (0x81)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (Zero, \_SB.PCI0.PM.THON)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (One, \_SB.PCI0.PM.GO18)
        If (LEqual (Arg0, One))
        {
            \_SB.VIAX (0x89)
        }

        If (LEqual (Arg0, 0x03))
        {
            \_SB.VIAX (0x82)
            Store (One, \_SB.BAT0.FSTA)
            Store (One, \_SB.BAT0.FBIF)
            Store (HA04, \_SB.PCI0.USB0.UA04)
            Store (HA20, \_SB.PCI0.USB0.UA20)
            Store (HA21, \_SB.PCI0.USB0.UA21)
            Store (HA22, \_SB.PCI0.USB0.UA22)
            Store (HA23, \_SB.PCI0.USB0.UA23)
            Store (HB04, \_SB.PCI0.USB1.UB04)
            Store (HB20, \_SB.PCI0.USB1.UB20)
            Store (HB21, \_SB.PCI0.USB1.UB21)
            Store (HB22, \_SB.PCI0.USB1.UB22)
            Store (HB23, \_SB.PCI0.USB1.UB23)
            Notify (\_SB.PWRB, 0x02)
        }

        If (LEqual (Arg0, 0x04))
        {
            \_SB.VIAX (0x83)
            Store (One, \_SB.BAT0.FSTA)
            Store (One, \_SB.BAT0.FBIF)
            Notify (\_SB.PWRB, 0x02)
        }

        BEEP (One)
        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Scope (_TZ)
    {
        PowerResource (PFAN, 0x00, 0x0000)
        {
            Method (_ON, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO17)
                Store (One, \_SB.PCI0.PM.GO16)
            }

            Method (_OFF, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO17)
                Store (Zero, \_SB.PCI0.PM.GO16)
            }

            Method (_STA, 0, NotSerialized)
            {
                XOr (\_SB.PCI0.PM.GO17, One, Local7)
                Return (Local7)
            }
        }

        Device (FAN)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_PSC, Zero)
            Method (_PS0, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO16)
                Store (Zero, \_SB.PCI0.PM.GO17)
                Store (Zero, _PSC)
            }

            Method (_PS1, 0, NotSerialized)
            {
                Store (Zero, \_SB.PCI0.PM.GO16)
                Store (One, _PSC)
            }

            Method (_PS3, 0, NotSerialized)
            {
                Store (One, \_SB.PCI0.PM.GO17)
                Store (0x03, _PSC)
            }

            Name (_PR0, Package (0x01)
            {
                PFAN
            })
        }

        ThermalZone (THRM)
        {
            Name (CRTV, 0x52)
            Name (COLM, Zero)
            Name (F_ON, Zero)
            Name (T_ON, Zero)
            Name (Z000, Zero)
            Name (Z001, Zero)
            Name (AC0H, 0x3C)
            Name (PSVV, 0x48)
            Method (_AC0, 0, Serialized)
            {
                Add (AC0H, 0x0111, Local0)
                Multiply (Local0, 0x0A, Local0)
                Return (Local0)
            }

            Name (_AL0, Package (0x01)
            {
                FAN
            })
            Method (_PSV, 0, NotSerialized)
            {
                Add (PSVV, 0x0111, Local0)
                Multiply (Local0, 0x0A, Local0)
                Return (Local0)
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Method (_CRT, 0, NotSerialized)
            {
                Add (CRTV, 0x0111, Local0)
                Multiply (Local0, 0x0A, Local0)
                Return (Local0)
            }

            Method (_SCP, 1, NotSerialized)
            {
                Store (Arg0, COLM)
                If (LEqual (Arg0, Zero))
                {
                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, Zero))
                    {
                        Store (0x37, Z000)
                        Store (0x3C, F_ON)
                        Store (0x47, Z001)
                        Store (0x4B, T_ON)
                    }

                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, One))
                    {
                        Store (0x37, Z000)
                        Store (0x3C, F_ON)
                        Store (0x44, Z001)
                        Store (0x48, T_ON)
                    }

                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, 0x02))
                    {
                        Store (0x2D, Z000)
                        Store (0x32, F_ON)
                        Store (0x40, Z001)
                        Store (0x44, T_ON)
                    }

                    Store (F_ON, AC0H)
                    Store (T_ON, PSVV)
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, Zero))
                    {
                        Store (0x37, Z000)
                        Store (0x3C, F_ON)
                        Store (0x47, Z001)
                        Store (0x4B, T_ON)
                    }

                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, One))
                    {
                        Store (0x37, Z000)
                        Store (0x3C, F_ON)
                        Store (0x44, Z001)
                        Store (0x48, T_ON)
                    }

                    If (LEqual (\_SB.PCI0.PIB.RTC.CPUT, 0x02))
                    {
                        Store (0x2D, Z000)
                        Store (0x32, F_ON)
                        Store (0x40, Z001)
                        Store (0x44, T_ON)
                    }

                    Store (T_ON, AC0H)
                    Store (F_ON, PSVV)
                }

                Notify (THRM, 0x81)
                Notify (THRM, 0x80)
            }

            Method (_TMP, 0, NotSerialized)
            {
                SHOW ("THRM_TMP")
                Store (\_SB.PCI0.PIB.PMRD (0xE7), Local0)
                Multiply (Local0, 0x0A, Local0)
                Add (Local0, 0x0AAA, Local0)
                If (LEqual (Local0, 0x0AAA))
                {
                    Return (0x0B72)
                }
                Else
                {
                    Return (Local0)
                }

                SHOW ("THRM_TMP Return")
                SHOW (Local0)
                Return (Local0)
            }

            Name (_TC1, 0x04)
            Name (_TC2, 0x03)
            Name (_TSP, 0x0258)
            Name (MODE, Zero)
            Name (FANX, Zero)
            Name (TRLX, Zero)
        }
    }

    Scope (_SI)
    {
        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, One))
            {
                Store ("SI_Working", Debug)
            }

            If (LEqual (Arg0, Zero))
            {
                Store (Zero, \_SB.PCI0.PM.GPI1)
                Store (One, \_SB.PCI0.PM.GPS1)
                Store (Zero, \_SB.PCI0.PM.THON)
                And (\_SB.PCI0.PIB.PMRD (0xAD), 0xFE, Local5)
                \_SB.PCI0.PIB.PMWT (0xAD, Local5)
                And (\_SB.PCI0.PIB.PMRD (0xAF), 0xFC, Local5)
                \_SB.PCI0.PIB.PMWT (0xAF, Local5)
                \_SB.PCI0.PIB.PMWT (0xA8, Zero)
                \_SB.PCI0.PIB.PMWT (0xA9, Zero)
                \_SB.PCI0.PIB.PMWT (0xAA, Zero)
                \_SB.PCI0.PIB.PMWT (0xAB, Zero)
                \_SB.PCI0.PIB.PMWT (0xAC, Zero)
                \_SB.PCI0.PIB.PMWT (0xAD, Zero)
                \_SB.PCI0.PIB.PMWT (0xAE, Zero)
                \_SB.PCI0.PIB.PMWT (0xAF, Zero)
                \_SB.VIAX (0x8A)
                Store ("S5 Shutdown", Debug)
            }

            If (LEqual (Arg0, 0x02))
            {
                Store ("SI_Waking", Debug)
            }

            If (LEqual (Arg0, 0x04))
            {
                Store (Zero, \_SB.PCI0.PM.GPI1)
                Store (One, \_SB.PCI0.PM.GPS1)
                Store (Zero, \_SB.PCI0.PM.THON)
                And (\_SB.PCI0.PIB.PMRD (0xAD), 0xFE, Local5)
                \_SB.PCI0.PIB.PMWT (0xAD, Local5)
                And (\_SB.PCI0.PIB.PMRD (0xAF), 0xFC, Local5)
                \_SB.PCI0.PIB.PMWT (0xAF, Local5)
                \_SB.PCI0.PIB.PMWT (0xA8, Zero)
                \_SB.PCI0.PIB.PMWT (0xA9, Zero)
                \_SB.PCI0.PIB.PMWT (0xAA, Zero)
                \_SB.PCI0.PIB.PMWT (0xAB, Zero)
                \_SB.PCI0.PIB.PMWT (0xAC, Zero)
                \_SB.PCI0.PIB.PMWT (0xAD, Zero)
                \_SB.PCI0.PIB.PMWT (0xAE, Zero)
                \_SB.PCI0.PIB.PMWT (0xAF, Zero)
                \_SB.VIAX (0x8A)
                Store ("Sleeping with context saved to non volatile storage", Debug)
            }

            If (LEqual (Arg0, 0x03))
            {
                Store ("Sleeping. Used to indicate system state S1, S2 or S3", Debug)
            }
        }
    }

    Scope (_GPE)
    {
        Mutex (GLCK, 0x00)
        Method (_L00, 0, NotSerialized)
        {
            Acquire (GLCK, 0xFFFF)
            \_SB.VIAX (0x84)
            Release (GLCK)
        }

        Method (_L01, 0, NotSerialized)
        {
            Acquire (GLCK, 0xFFFF)
            Store (\_SB.PCI0.PIB.PMRD (0xAB), Local0)
            Store (\_SB.PCI0.PIB.PMRD (0xAD), Local4)
            Store (Local4, Debug)
            If (And (Local4, One, Local3))
            {
                If (LEqual (\_TZ.THRM.COLM, Zero))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xE7), Local4)
                    Store (Local4, Debug)
                    Store (\_SB.PCI0.PIB.PMRD (0xE4), Local5)
                    Store (Local5, Debug)
                    If (LNot (LLess (Local4, Local5)))
                    {
                        If (LEqual (Local5, \_TZ.THRM.F_ON))
                        {
                            HION ()
                            \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z000)
                            \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.T_ON)
                        }
                        Else
                        {
                            If (LEqual (Local5, \_TZ.THRM.T_ON))
                            {
                                Store (\_TZ.THRM.Z001, \_TZ.THRM.PSVV)
                                \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z001)
                                \_SB.PCI0.PIB.PMWT (0xE4, 0x52)
                                Notify (\_TZ.THRM, 0x81)
                                Notify (\_TZ.THRM, 0x80)
                            }
                            Else
                            {
                                Notify (\_TZ.THRM, 0x81)
                            }
                        }
                    }
                    Else
                    {
                        Store (\_SB.PCI0.PIB.PMRD (0xE5), Local5)
                        Store (Local5, Debug)
                        If (LNot (LGreater (Local4, Local5)))
                        {
                            If (LEqual (Local5, \_TZ.THRM.Z000))
                            {
                                \_TZ.PFAN._OFF ()
                                \_SB.PCI0.PIB.PMWT (0xE5, Zero)
                                \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.F_ON)
                            }
                            Else
                            {
                                If (LEqual (Local5, \_TZ.THRM.Z001))
                                {
                                    HION ()
                                    Store (\_TZ.THRM.T_ON, \_TZ.THRM.PSVV)
                                    \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z000)
                                    \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.T_ON)
                                    Notify (\_TZ.THRM, 0x81)
                                    Notify (\_TZ.THRM, 0x80)
                                }
                            }
                        }
                    }
                }
                Else
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xE7), Local4)
                    Store (Local4, Debug)
                    Store (\_SB.PCI0.PIB.PMRD (0xE4), Local5)
                    Store (Local5, Debug)
                    If (LNot (LLess (Local4, Local5)))
                    {
                        If (LEqual (Local5, \_TZ.THRM.F_ON))
                        {
                            \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z000)
                            \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.T_ON)
                            Store (\_TZ.THRM.Z000, \_TZ.THRM.PSVV)
                            Notify (\_TZ.THRM, 0x81)
                            Notify (\_TZ.THRM, 0x80)
                        }
                        Else
                        {
                            If (LEqual (Local5, \_TZ.THRM.T_ON))
                            {
                                \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z001)
                                \_SB.PCI0.PIB.PMWT (0xE4, 0x52)
                                HION ()
                                Notify (\_TZ.THRM, 0x80)
                            }
                            Else
                            {
                                Notify (\_TZ.THRM, 0x81)
                            }
                        }
                    }
                    Else
                    {
                        Store (\_SB.PCI0.PIB.PMRD (0xE5), Local5)
                        Store (Local5, Debug)
                        If (LNot (LGreater (Local4, Local5)))
                        {
                            If (LEqual (Local5, \_TZ.THRM.Z000))
                            {
                                \_SB.PCI0.PIB.PMWT (0xE5, Zero)
                                \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.F_ON)
                                \_TZ.PFAN._OFF ()
                                Store (\_TZ.THRM.F_ON, \_TZ.THRM.PSVV)
                                Notify (\_TZ.THRM, 0x81)
                                Notify (\_TZ.THRM, 0x80)
                            }
                            Else
                            {
                                If (LEqual (Local5, \_TZ.THRM.Z001))
                                {
                                    \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z000)
                                    \_SB.PCI0.PIB.PMWT (0xE4, \_TZ.THRM.T_ON)
                                    \_TZ.PFAN._OFF ()
                                }
                                Else
                                {
                                    \_SB.PCI0.PIB.PMWT (0xE5, \_TZ.THRM.Z001)
                                    \_SB.PCI0.PIB.PMWT (0xE4, 0x52)
                                    \_TZ.PFAN._ON ()
                                }
                            }
                        }
                    }
                }

                And (\_SB.PCI0.PIB.PMRD (0xAD), 0xFE, Local5)
                \_SB.PCI0.PIB.PMWT (0xAD, Local5)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
                And (\_SB.PCI0.PIB.PMRD (0xAE), 0xFE, Local5)
                \_SB.PCI0.PIB.PMWT (0xAE, Local5)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
                And (\_SB.PCI0.PIB.PMRD (0xAF), 0xFC, Local5)
                \_SB.PCI0.PIB.PMWT (0xAF, Local5)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
            }

            If (And (Local0, One, Local3))
            {
                \_SB.ACAD._PSR ()
                If (LEqual (\_SB.ACAD.ACFG, One))
                {
                    \_TZ.THRM._SCP (Zero)
                }
                Else
                {
                    \_TZ.THRM._SCP (One)
                }

                Notify (\_SB.ACAD, 0x80)
                And (\_SB.PCI0.PIB.PMRD (0xAB), 0xFE, Local2)
                \_SB.PCI0.PIB.PMWT (0xAB, Local2)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
            }

            If (And (Local0, 0x02, Local3))
            {
                Store (\_SB.PCI0.PIB.PMRD (0xA1), Local1)
                Store (\_SB.PCI0.PIB.PMRD (0xF1), Local4)
                If (LNot (LEqual (And (Local1, One, Local3), And (Local4, One, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    If (LEqual (And (Local1, One), One))
                    {
                        Store (0x1F, \_SB.BAT0.BSTA)
                    }
                    Else
                    {
                        Store (0x0F, \_SB.BAT0.BSTA)
                    }

                    Store (One, \_SB.BAT0.FBIF)
                    Notify (\_SB.BAT0, 0x81)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x02, Local3), And (Local4, 0x02, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x04, Local3), And (Local4, 0x04, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x81)
                }

                If (LNot (LEqual (And (Local1, 0x08, Local3), And (Local4, 0x08, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x10, Local3), And (Local4, 0x10, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x20, Local3), And (Local4, 0x20, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x40, Local3), And (Local4, 0x40, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                If (LNot (LEqual (And (Local1, 0x80, Local3), And (Local4, 0x80, Local5))))
                {
                    Store (\_SB.PCI0.PIB.PMRD (0xA1), Local6)
                    \_SB.PCI0.PIB.PMWT (0xF1, Local6)
                    Notify (\_SB.BAT0, 0x80)
                }

                And (\_SB.PCI0.PIB.PMRD (0xAB), 0xFD, Local2)
                \_SB.PCI0.PIB.PMWT (0xAB, Local2)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
            }

            Release (GLCK)
        }

        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.CRD0, 0x02)
            Notify (\_SB.PCI0.CRD1, 0x02)
            Notify (\_SB.PCI0.MPCI, 0x02)
            Notify (\_SB.PCI0.MPC2, 0x02)
            Notify (\_SB.PCI0, 0x02)
            Notify (\_SB.PWRB, 0x02)
        }

        Method (_L08, 0, NotSerialized)
        {
            Acquire (GLCK, 0xFFFF)
            Store (\_SB.PCI0.PIB.PMRD (0xAC), Local0)
            Store (Local0, Debug)
            If (And (Local0, 0x10, Local3))
            {
                Store ("*** GPIOA EVENT ***", Debug)
                Store (\_SB.PCI0.PIB.PMRD (0xA8), Local1)
                If (And (Local1, One, Local2))
                {
                    Store ("*** GPIOA Bit0 EVENT ***", Debug)
                    Store (\_SB.PCI0.PIB.PMRD (0xB7), Local3)
                    If (And (Local3, One, Local6))
                    {
                        Store ("*** Lid Open ***", Debug)
                        And (Local3, 0xFE, Local3)
                        \_SB.PCI0.PIB.PMWT (0xB7, Local3)
                        Store (One, \_SB.LID.LIDF)
                    }
                    Else
                    {
                        Store ("*** Lid Close ***", Debug)
                        Or (Local3, One, Local3)
                        \_SB.PCI0.PIB.PMWT (0xB7, Local3)
                        Store (Zero, \_SB.LID.LIDF)
                    }

                    And (Local1, 0xFE, Local1)
                    \_SB.PCI0.PIB.PMWT (0xA8, Local1)
                    Notify (\_SB.LID, 0x80)
                    If (\_SB.LID.LIDF)
                    {
                        Notify (\_SB.PWRB, 0x02)
                    }
                }

                And (Local0, 0xEF, Local0)
                \_SB.PCI0.PIB.PMWT (0xAC, Local0)
                \_SB.PCI0.PIB.PMWT (0xF0, Zero)
            }

            Release (GLCK)
        }

        Method (_L09, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB0, 0x02)
        }
    }

    OperationRegion (VGAM, SystemMemory, 0x000C0002, One)
    Field (VGAM, ByteAcc, NoLock, Preserve)
    {
        VGA1,   8
    }

    Scope (_SB)
    {
        Mutex (VSMX, 0x00)
        Method (VIAX, 1, Serialized)
        {
            Store ("--------- VIA SOFTWARE SMI PMIO 2Fh ------------", Debug)
            Acquire (VSMX, 0xFFFF)
            Store (Arg0, ^PCI0.PM.BCMD)
            Release (VSMX)
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, Zero)
            Name (_BBN, Zero)
            OperationRegion (NB00, PCI_Config, Zero, 0x0100)
            Field (NB00, ByteAcc, NoLock, Preserve)
            {
                Offset (0x5F), 
                EADD,   8
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000CBFFF,
                    0x00000000,
                    0x0002C000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00018000)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00100000,
                    0xFFF7FFFF,
                    0x00000000,
                    0xFFF00000)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRES, 0x46, VMAX)
                CreateDWordField (CRES, 0x4E, VLEN)
                ShiftLeft (VGA1, 0x09, Local0)
                Add (Local0, 0x000BFFFF, VMAX)
                Add (Local0, 0x00020000, VLEN)
                CreateDWordField (CRES, 0x76, TCMM)
                CreateDWordField (CRES, 0x82, TOMM)
                Multiply (EADD, 0x01000000, Local0)
                Store (Local0, TCMM)
                Subtract (0xFFF80000, TCMM, TOMM)
                Return (CRES)
            }

            Name (_PRT, Package (0x0A)
            {
                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    PIB.LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    Zero, 
                    PIB.LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    One, 
                    PIB.LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    PIB.LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    PIB.LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    PIB.LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    Zero, 
                    PIB.LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    Zero, 
                    PIB.LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000CFFFF, 
                    One, 
                    PIB.LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x000DFFFF, 
                    Zero, 
                    PIB.LNKA, 
                    Zero
                }
            })
            Device (PIB)
            {
                Name (_ADR, 0x00070000)
                OperationRegion (IRQR, PCI_Config, Zero, 0x88)
                Field (IRQR, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x48), 
                        ,   2, 
                    EUSB,   1, 
                    Offset (0x50), 
                    FDDA,   2, 
                    LPDA,   2, 
                    Offset (0x51), 
                    FDIQ,   4, 
                    LPIQ,   4, 
                    SAIQ,   4, 
                    SBIQ,   4, 
                    Offset (0x55), 
                        ,   4, 
                    PIRA,   4, 
                    PIRB,   4, 
                    PIRC,   4, 
                        ,   4, 
                    PIRD,   4, 
                    USBA,   2, 
                    A97A,   2, 
                    Offset (0x81), 
                    PDC1,   8, 
                    PDC2,   8, 
                    PDC3,   8, 
                    PDC4,   8, 
                    EP3C,   1, 
                    EN3C,   1, 
                    EACF,   1, 
                    EMCF,   1, 
                    ESB1,   1
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, One)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (PIRA, Zero))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFA, One, IRA1)
                        CreateByteField (BUFA, 0x02, IRA2)
                        Store (PIRA, Local0)
                        If (LGreater (Local0, Zero))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRA2)
                            }
                            Else
                            {
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRA1)
                            }
                        }

                        Return (BUFA)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, One, IRA1)
                        CreateByteField (Arg0, 0x02, IRA2)
                        If (LGreater (IRA2, Zero))
                        {
                            FindSetLeftBit (IRA2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRA1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, PIRA)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, PIRB)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (PIRB, Zero))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFB, One, IRB1)
                        CreateByteField (BUFB, 0x02, IRB2)
                        Store (PIRB, Local0)
                        If (LGreater (Local0, Zero))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRB2)
                            }
                            Else
                            {
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRB1)
                            }
                        }

                        Return (BUFB)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, One, IRB1)
                        CreateByteField (Arg0, 0x02, IRB2)
                        If (LGreater (IRB2, Zero))
                        {
                            FindSetLeftBit (IRB2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRB1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, PIRB)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, PIRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (PIRC, Zero))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFC, One, IRC1)
                        CreateByteField (BUFC, 0x02, IRC2)
                        Store (PIRC, Local0)
                        If (LGreater (Local0, Zero))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local0)
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRC2)
                            }
                            Else
                            {
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, IRC1)
                            }
                        }

                        Return (BUFC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, One, IRC1)
                        CreateByteField (Arg0, 0x02, IRC2)
                        If (LGreater (IRC2, Zero))
                        {
                            FindSetLeftBit (IRC2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRC1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, PIRC)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Store (Zero, PIRD)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (PIRD, Zero))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUFD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared) {}
                        })
                        CreateByteField (BUFD, One, IRD1)
                        CreateByteField (BUFD, 0x02, IRD2)
                        Store (PIRD, Local0)
                        If (LGreater (Local0, Zero))
                        {
                            If (LGreater (Local0, 0x07))
                            {
                                Subtract (Local0, 0x08, Local2)
                                Store (One, Local1)
                                ShiftLeft (Local1, Local2, Local3)
                                Store (Local3, IRD2)
                            }
                            Else
                            {
                                Store (One, Local1)
                                ShiftLeft (Local1, Local0, Local2)
                                Store (Local2, IRD1)
                            }
                        }

                        Return (BUFD)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, One, IRD1)
                        CreateByteField (Arg0, 0x02, IRD2)
                        If (LGreater (IRD2, Zero))
                        {
                            FindSetLeftBit (IRD2, Local0)
                            Decrement (Local0)
                            Add (Local0, 0x08, Local0)
                        }
                        Else
                        {
                            FindSetLeftBit (IRD1, Local0)
                            Decrement (Local0)
                        }

                        Store (Local0, PIRD)
                    }
                }

                Device (DMA1)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8) {4}
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode10, 0x0070, 0x0070, 0x01, 0x06)
                        IRQNoFlags () {8}
                    })
                    OperationRegion (XCMS, SystemIO, 0x72, 0x02)
                    Field (XCMS, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x95), 
                            ,   6, 
                        CPUT,   2, 
                            ,   6, 
                        PS2M,   2
                    }
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQNoFlags () {2}
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x10)
                        IRQNoFlags () {13}
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQNoFlags () {0}
                    })
                }

                Device (SPKR)
                {
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (SMEM, ResourceTemplate ()
                        {
                            Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                            Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                        })
                        Return (SMEM)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                    })
                }

                OperationRegion (VSIO, SystemIO, 0x03F0, 0x02)
                Field (VSIO, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8, 
                    DATA,   8
                }

                IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xE2), 
                    CRE2,   8, 
                    CRE3,   8, 
                    Offset (0xE6), 
                    CRE6,   8, 
                    CRE7,   8, 
                    CRE8,   8, 
                    Offset (0xEE), 
                    CREE,   8
                }

                Method (ENCG, 0, NotSerialized)
                {
                    Store (One, EN3C)
                }

                Method (EXCG, 0, NotSerialized)
                {
                    Store (Zero, EN3C)
                }

                Device (FDC0)
                {
                    Name (_HID, EisaId ("PNP0700"))
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x06)
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x01)
                        IRQNoFlags () {}
                        DMA (Compatibility, NotBusMaster, Transfer8) {}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (EP3C))
                        {
                            Return (Zero)
                        }

                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0x10, Local0)
                        If (Local0)
                        {
                            Store (CRE3, Local1)
                            EXCG ()
                            If (LEqual (Local1, Zero))
                            {
                                Return (0x0D)
                            }

                            Return (0x0F)
                        }

                        EXCG ()
                        Return (0x0D)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (Zero, CRE3)
                        EXCG ()
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LEqual (And (_STA (), 0x04), Zero))
                        {
                            Return (RSRC)
                        }

                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x0A, DALO)
                        CreateByteField (BUF0, 0x0B, DAHI)
                        CreateByteField (BUF0, 0x0C, DRLO)
                        CreateByteField (BUF0, 0x0D, DRHI)
                        CreateByteField (BUF0, 0x11, IRQL)
                        CreateByteField (BUF0, 0x14, DMAV)
                        Store (DATA, Local0)
                        And (Local0, 0x20, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (0x70, IOLO)
                            Store (0x03, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            Store (0x77, DALO)
                            Store (0x03, DAHI)
                            Store (DALO, DRLO)
                            Store (DAHI, DRHI)
                        }

                        Store (FDIQ, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Store (FDDA, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, DMAV)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F0, 0x03F0, 0x01, 0x06)
                            IO (Decode16, 0x03F7, 0x03F7, 0x01, 0x01)
                            IRQNoFlags () {6}
                            DMA (Compatibility, NotBusMaster, Transfer8) {2}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateWordField (Arg0, 0x11, IRQL)
                        CreateByteField (Arg0, 0x14, DMAV)
                        ENCG ()
                        Store (CRE2, Local1)
                        And (Local1, 0xEF, Local1)
                        Store (Local1, CRE2)
                        If (LEqual (IOLO, 0xF0))
                        {
                            Store (0xF0, Local0)
                        }
                        Else
                        {
                            Store (0x70, Local0)
                        }

                        ShiftRight (Local0, 0x02, Local0)
                        And (Local0, 0xFC, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE3)
                        FindSetRightBit (IRQL, Local0)
                        Decrement (Local0)
                        Store (Local0, FDIQ)
                        FindSetRightBit (DMAV, Local0)
                        Decrement (Local0)
                        Store (Local0, FDDA)
                        Store (CRE2, Local1)
                        Or (Local1, 0x10, Local1)
                        Store (Local1, CRE2)
                        EXCG ()
                    }
                }

                Device (UAR1)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, One)
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                        IRQNoFlags () {}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (EP3C))
                        {
                            Return (Zero)
                        }

                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0x04, Local0)
                        If (Local0)
                        {
                            Store (CRE7, Local1)
                            EXCG ()
                            If (LEqual (Local1, Zero))
                            {
                                Return (0x0D)
                            }

                            Return (0x0F)
                        }

                        EXCG ()
                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        And (_STA (), 0x04, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Return (RSRC)
                        }

                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE7, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0xC0, Local1)
                        ShiftRight (Local1, 0x06, Local1)
                        And (Local0, 0x3F, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IOLO)
                        Store (Local1, IOHI)
                        Store (IOLO, IORL)
                        Store (IOHI, IORH)
                        EXCG ()
                        Store (SAIQ, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0xFB, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        And (Local0, 0xFE, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE7)
                        FindSetRightBit (IRQL, Local0)
                        Decrement (Local0)
                        Store (Local0, SAIQ)
                        Store (CRE2, Local0)
                        Or (Local0, 0x04, Local0)
                        Store (Local0, CRE2)
                        EXCG ()
                    }
                }

                Device (UAR2)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x02)
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                        IRQNoFlags () {}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (EP3C))
                        {
                            Return (Zero)
                        }

                        ENCG ()
                        Store (CREE, Local0)
                        And (Local0, 0x38, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Store (CRE2, Local0)
                            And (Local0, 0x08, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                EXCG ()
                                Return (Zero)
                            }

                            Store (CRE8, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                EXCG ()
                                Return (0x0D)
                            }

                            EXCG ()
                            Return (0x0F)
                        }

                        EXCG ()
                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        And (_STA (), 0x04, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Return (RSRC)
                        }

                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE8, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0xC0, Local1)
                        ShiftRight (Local1, 0x06, Local1)
                        And (Local0, 0x3F, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IOLO)
                        Store (Local1, IOHI)
                        Store (IOLO, IORL)
                        Store (IOHI, IORH)
                        EXCG ()
                        Store (SBIQ, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0xF7, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        And (Local0, 0xFE, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE8)
                        FindSetRightBit (IRQL, Local0)
                        Decrement (Local0)
                        Store (Local0, SBIQ)
                        Store (CRE2, Local0)
                        Or (Local0, 0x08, Local0)
                        Store (Local0, CRE2)
                        EXCG ()
                    }
                }

                Device (IRDA)
                {
                    Name (_HID, EisaId ("PNP0510"))
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                        IRQNoFlags () {}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (EP3C))
                        {
                            Return (Zero)
                        }

                        ENCG ()
                        Store (CREE, Local0)
                        And (Local0, 0x38, Local0)
                        If (LEqual (Local0, 0x08))
                        {
                            Store (CRE2, Local0)
                            And (Local0, 0x08, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                EXCG ()
                                Return (Zero)
                            }

                            Store (CRE8, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                EXCG ()
                                Return (0x0D)
                            }

                            EXCG ()
                            Return (0x0F)
                        }

                        EXCG ()
                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (Zero, CRE8)
                        EXCG ()
                        Store (Zero, SBIQ)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        And (_STA (), 0x04, Local0)
                        If (LEqual (Local0, Zero))
                        {
                            Return (RSRC)
                        }

                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE8, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0xC0, Local1)
                        ShiftRight (Local1, 0x06, Local1)
                        And (Local0, 0x3F, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IOLO)
                        Store (Local1, IOHI)
                        Store (IOLO, IORL)
                        Store (IOHI, IORH)
                        EXCG ()
                        Store (SBIQ, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                            IRQNoFlags () {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0xF7, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        And (Local0, 0xFE, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE8)
                        FindSetRightBit (IRQL, Local0)
                        Decrement (Local0)
                        Store (Local0, SBIQ)
                        Store (CRE2, Local0)
                        Or (Local0, 0x08, Local0)
                        Store (Local0, CRE2)
                        EXCG ()
                    }
                }

                Device (LPT)
                {
                    Name (PIOM, Buffer (One)
                    {
                        0x00
                    })
                    CreateByteField (PIOM, Zero, LPTM)
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (EP3C)
                        {
                            ENCG ()
                            Store (CRE2, Local0)
                            And (Local0, 0x03, Local0)
                            If (LEqual (Local0, One))
                            {
                                EXCG ()
                                Return (Zero)
                            }

                            If (LEqual (Local0, 0x03))
                            {
                                EXCG ()
                                Return (Zero)
                            }
                            Else
                            {
                                If (LNot (LEqual (Local0, 0x03)))
                                {
                                    Store (Local0, LPTM)
                                }

                                Store (CRE6, Local0)
                                EXCG ()
                                If (LEqual (Local0, Zero))
                                {
                                    Return (0x0D)
                                }
                                Else
                                {
                                    Return (0x0F)
                                }
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (Zero, CRE6)
                        EXCG ()
                        Store (Zero, LPIQ)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x01, 0x00)
                            IRQNoFlags () {}
                        })
                        If (LEqual (_STA (), 0x0F))
                        {
                            CreateByteField (BUF0, 0x02, IOLO)
                            CreateByteField (BUF0, 0x03, IOHI)
                            CreateByteField (BUF0, 0x04, IORL)
                            CreateByteField (BUF0, 0x05, IORH)
                            CreateByteField (BUF0, 0x07, RGLN)
                            CreateByteField (BUF0, 0x09, IRQL)
                            ENCG ()
                            Store (CRE6, Local0)
                            Store (Local0, Local1)
                            And (Local1, 0xC0, Local1)
                            ShiftRight (Local1, 0x06, Local1)
                            And (Local0, 0x3F, Local0)
                            ShiftLeft (Local0, 0x02, Local0)
                            Store (Local0, IOLO)
                            Store (Local1, IOHI)
                            Store (IOLO, IORL)
                            Store (IOHI, IORH)
                            Store (CRE6, Local0)
                            If (LNot (LEqual (LPTM, 0x02)))
                            {
                                If (LEqual (Local0, 0xEF))
                                {
                                    Store (0x04, RGLN)
                                }
                                Else
                                {
                                    Store (0x08, RGLN)
                                }
                            }
                            Else
                            {
                                Store (0x08, RGLN)
                            }

                            EXCG ()
                            Store (LPIQ, Local0)
                            Store (One, Local1)
                            ShiftLeft (Local1, Local0, IRQL)
                        }

                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x08)
                            IRQNoFlags () {5}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x08)
                            IRQNoFlags () {5}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                            IRQNoFlags () {7}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                            IRQNoFlags () {5}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE2, Local0)
                        Or (Local0, 0x03, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE6)
                        FindSetRightBit (IRQL, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, LPIQ)
                        Store (CRE2, Local0)
                        And (Local0, 0xFC, Local0)
                        Store (LPTM, Local1)
                        Or (Local0, Local1, Local1)
                        Store (Local1, CRE2)
                        EXCG ()
                    }
                }

                Device (ECP)
                {
                    Name (_HID, EisaId ("PNP0401"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (EP3C))
                        {
                            Return (Zero)
                        }

                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0x03, Local0)
                        If (LEqual (Local0, One))
                        {
                            Store (CRE6, Local1)
                            EXCG ()
                            If (LNot (LEqual (Local1, Zero)))
                            {
                                Return (0x0F)
                            }

                            Return (0x0D)
                        }

                        EXCG ()
                        Return (Zero)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (Zero, CRE6)
                        EXCG ()
                        Store (Zero, LPDA)
                        Store (Zero, LPIQ)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x0000, 0x0000, 0x01, 0x04)
                            IO (Decode16, 0x0000, 0x0000, 0x01, 0x04)
                            IRQNoFlags () {}
                            DMA (Compatibility, NotBusMaster, Transfer8) {}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x0A, DALO)
                        CreateByteField (BUF0, 0x0B, DAHI)
                        CreateByteField (BUF0, 0x0C, DRLO)
                        CreateByteField (BUF0, 0x0D, DRHI)
                        CreateByteField (BUF0, 0x11, IRQL)
                        CreateByteField (BUF0, 0x14, DMAC)
                        ENCG ()
                        Store (CRE6, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0xC0, Local1)
                        ShiftRight (Local1, 0x06, Local1)
                        And (Local0, 0x3F, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IOLO)
                        Store (Local1, IOHI)
                        Add (Local1, 0x04, Local1)
                        Store (IOLO, IORL)
                        Store (IOHI, IORH)
                        Store (IOLO, DALO)
                        Store (Local1, DAHI)
                        Store (DALO, DRLO)
                        Store (DAHI, DRHI)
                        EXCG ()
                        Store (LPIQ, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Store (LPDA, Local0)
                        Store (One, Local1)
                        ShiftLeft (Local1, Local0, DMAC)
                        Return (BUF0)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IO (Decode16, 0x0378, 0x0378, 0x01, 0x04)
                            IO (Decode16, 0x0778, 0x0778, 0x01, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFn (0x01, 0x01)
                        {
                            IO (Decode16, 0x0278, 0x0278, 0x01, 0x04)
                            IO (Decode16, 0x0678, 0x0678, 0x01, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        StartDependentFn (0x02, 0x02)
                        {
                            IO (Decode16, 0x03BC, 0x03BC, 0x01, 0x04)
                            IO (Decode16, 0x07BC, 0x07BC, 0x01, 0x04)
                            IRQNoFlags () {5,7}
                            DMA (Compatibility, NotBusMaster, Transfer8) {1,3}
                        }
                        EndDependentFn ()
                    })
                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x11, IRQL)
                        CreateByteField (Arg0, 0x14, DMAC)
                        ENCG ()
                        Store (CRE2, Local0)
                        Or (Local0, 0x03, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE6)
                        FindSetRightBit (IRQL, Local0)
                        If (Local0)
                        {
                            Decrement (Local0)
                        }

                        Store (Local0, LPIQ)
                        FindSetRightBit (DMAC, Local0)
                        Decrement (Local0)
                        Store (Local0, LPDA)
                        Store (CRE2, Local0)
                        And (Local0, 0xFC, Local0)
                        Or (Local0, One, Local0)
                        Store (Local0, CRE2)
                        EXCG ()
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (^^RTC.PS2M, Zero))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                OperationRegion (PMIF, SystemIO, 0x68, 0x08)
                Field (PMIF, ByteAcc, NoLock, Preserve)
                {
                    PMUD,   8, 
                    Offset (0x04), 
                    PMUC,   8, 
                    Offset (0x08)
                }

                Mutex (ELCK, 0x00)
                Method (WIBF, 0, NotSerialized)
                {
                    Store (0x0009FFFF, Local6)
                    Noop
                    Noop
                    Store (PMUC, Local2)
                    And (Local2, 0x22, Local2)
                    If (And (Local2, 0x20, Local3))
                    {
                        Return (One)
                    }

                    And (Local2, 0x02, Local2)
                    While (LAnd (LNot (LEqual (Local2, Zero)), LNot (LEqual (Local6, Zero))))
                    {
                        Noop
                        Noop
                        Store (PMUC, Local2)
                        Decrement (Local6)
                        If (And (Local2, 0x20, Local3))
                        {
                            Return (One)
                        }

                        And (Local2, 0x02, Local2)
                    }

                    Return (Zero)
                }

                Method (WOBF, 0, NotSerialized)
                {
                    Store (0x009FFFFF, Local6)
                    Noop
                    Noop
                    Store (PMUC, Local3)
                    And (Local3, 0x21, Local3)
                    If (And (Local3, 0x20, Local2))
                    {
                        Return (One)
                    }

                    While (LAnd (LEqual (Local3, Zero), LNot (LEqual (Local6, Zero))))
                    {
                        Noop
                        Noop
                        Store (PMUC, Local3)
                        And (Local3, 0x21, Local3)
                        If (And (Local3, 0x20, Local2))
                        {
                            Return (One)
                        }

                        Decrement (Local6)
                    }

                    Return (Zero)
                }

                Method (RCMD, 2, NotSerialized)
                {
                    Store (Arg0, Local0)
                    Store (Arg1, Local1)
                    Store (Local0, PMUC)
                    If (WIBF ())
                    {
                        Return (One)
                    }

                    Store (Local1, PMUD)
                    If (WOBF ())
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (WCMD, 2, NotSerialized)
                {
                    Store (Arg0, Local0)
                    Store (Arg1, Local1)
                    Store (Local0, PMUC)
                    If (WIBF ())
                    {
                        Return (One)
                    }

                    Store (Local1, PMUD)
                    If (WIBF ())
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (PMRD, 1, NotSerialized)
                {
                    Acquire (ELCK, 0xFFFF)
                    Store (Arg0, Local0)
                    Store (0x03E8, Local6)
                    Store (PMUC, Local1)
                    And (Local1, 0x13, Local1)
                    While (LAnd (LNot (LEqual (Local1, Zero)), LNot (LEqual (Local6, Zero))))
                    {
                        Sleep (One)
                        Store (PMUC, Local1)
                        And (Local1, 0x13, Local1)
                        If (And (Local1, One, Local2))
                        {
                            Store (PMUD, Local3)
                        }

                        Decrement (Local6)
                    }

                    While (RCMD (0x80, Local0))
                    {
                        Noop
                        Noop
                        Store (PMUC, Local5)
                        If (And (Local5, One, Local2))
                        {
                            Store (PMUD, Local5)
                        }
                    }

                    Store (PMUD, Local4)
                    Release (ELCK)
                    Return (Local4)
                }

                Method (PMWT, 2, NotSerialized)
                {
                    Acquire (ELCK, 0xFFFF)
                    Store (Arg0, Local0)
                    Store (0x03E8, Local6)
                    Store (PMUC, Local1)
                    And (Local1, 0x13, Local1)
                    While (LAnd (LNot (LEqual (Local1, Zero)), LNot (LEqual (Local6, Zero))))
                    {
                        Sleep (One)
                        Store (PMUC, Local1)
                        And (Local1, 0x13, Local1)
                        Decrement (Local6)
                    }

                    While (WCMD (0x81, Local0))
                    {
                        Noop
                        Noop
                        Store (PMUC, Local5)
                        If (And (Local5, One, Local2))
                        {
                            Store (PMUD, Local5)
                        }
                    }

                    Store (Arg1, PMUD)
                    Release (ELCK)
                }
            }

            Device (PPB)
            {
                Name (_ADR, 0x00010000)
                Name (_PRT, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        ^PIB.LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        ^PIB.LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        ^PIB.LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        ^PIB.LNKD, 
                        Zero
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, Zero)
                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (Arg0, SWIT)
                    }

                    Name (_DOD, Package (0x02)
                    {
                        0x00010100, 
                        0x00010110
                    })
                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Name (_DCS, 0x1F)
                        Name (_DGS, One)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Or (And (GDGS, One), ShiftLeft (And (Arg0, One), One), GDGS)
                            If (And (Arg0, 0xC0000000))
                            {
                                Store (GDGS, GDCS)
                                If (LEqual (And (Arg0, 0x40000000), Zero))
                                {
                                    Store (GDCS, Local0)
                                    Store (And (Local0, One), ^^LCD._DCS)
                                    Store (ShiftRight (And (Local0, 0x02), One), _DCS)
                                }
                            }
                        }
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Name (_DCS, 0x1F)
                        Name (_DGS, One)
                        Method (_DSS, 1, NotSerialized)
                        {
                            Or (And (GDGS, 0x02), And (Arg0, One), GDGS)
                            If (And (Arg0, 0xC0000000))
                            {
                                Store (GDGS, GDCS)
                                If (LEqual (And (Arg0, 0x40000000), Zero))
                                {
                                    Store (GDCS, Local0)
                                    Store (And (Local0, One), _DCS)
                                    Store (ShiftRight (And (Local0, 0x02), One), ^^CRT._DCS)
                                }
                            }
                        }
                    }

                    Name (SWIT, One)
                    Name (GDCS, 0x02)
                    Name (GDGS, 0x02)
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x00070002)
                OperationRegion (SB72, PCI_Config, Zero, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    UA04,   8, 
                    Offset (0x20), 
                    UA20,   8, 
                    UA21,   8, 
                    UA22,   8, 
                    UA23,   8, 
                    Offset (0x3C), 
                    U0IR,   4
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (^^PIB.EUSB)
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    One
                })
            }

            Device (USB1)
            {
                Name (_ADR, 0x00070003)
                OperationRegion (SB72, PCI_Config, Zero, 0xC2)
                Field (SB72, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    UB04,   8, 
                    Offset (0x20), 
                    UB20,   8, 
                    UB21,   8, 
                    UB22,   8, 
                    UB23,   8, 
                    Offset (0x3C), 
                    U1IR,   4
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (^^PIB.ESB1)
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x09, 
                    One
                })
            }

            Device (PM)
            {
                Name (_ADR, 0x00070004)
                OperationRegion (SB74, PCI_Config, Zero, 0x0100)
                Field (SB74, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x44), 
                    PIR0,   8, 
                    PIR8,   8
                }

                OperationRegion (PMIO, SystemIO, 0x8000, 0x50)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                        ,   4, 
                    THON,   1, 
                    Offset (0x20), 
                        ,   1, 
                    GPS1,   1, 
                    Offset (0x22), 
                        ,   1, 
                    GPI1,   1, 
                    Offset (0x28), 
                        ,   7, 
                    PIRS,   1, 
                    Offset (0x2A), 
                        ,   7, 
                    PIEN,   1, 
                    Offset (0x2C), 
                        ,   7, 
                    LPOL,   1, 
                    Offset (0x2F), 
                    BCMD,   8, 
                    Offset (0x48), 
                    EXMI,   1, 
                        ,   2, 
                    LIDI,   1, 
                    Offset (0x4A), 
                    GI16,   1, 
                    GI17,   1, 
                    GI18,   1, 
                    GI19,   1, 
                    Offset (0x4E), 
                    GO16,   1, 
                    GO17,   1, 
                    GO18,   1, 
                    GO19,   1, 
                    GO20,   1
                }

                OperationRegion (SMIO, SystemIO, 0x8080, 0x07)
                Field (SMIO, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    SSTS,   8, 
                    CTLR,   8, 
                    CMDR,   8, 
                    ADDR,   8, 
                    DAT0,   8, 
                    DAT1,   8
                }
            }

            Device (AUDI)
            {
                Name (_ADR, 0x00070005)
                OperationRegion (SB75, PCI_Config, Zero, 0x85)
                Field (SB75, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x3C), 
                    ACIR,   4
                }
            }

            Device (MPC2)
            {
                Name (_ADR, 0x00050000)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x04
                })
            }

            Device (MPCI)
            {
                Name (_ADR, 0x00060000)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x04
                })
            }

            Device (CRD0)
            {
                Name (_ADR, 0x000C0000)
                OperationRegion (Z002, PCI_Config, 0xA4, 0x04)
                Field (Z002, DWordAcc, Lock, Preserve)
                {
                    PWST,   2, 
                    Offset (0x01), 
                    PMEN,   1, 
                        ,   6, 
                    PMST,   1
                }

                Method (_INI, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PSC, 0, NotSerialized)
                {
                    Return (PWST)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PS2, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    One
                })
            }

            Device (CRD1)
            {
                Name (_ADR, 0x000C0001)
                OperationRegion (Z003, PCI_Config, 0xA4, 0x04)
                Field (Z003, DWordAcc, Lock, Preserve)
                {
                    PWST,   2, 
                    Offset (0x01), 
                    PMEN,   1, 
                        ,   6, 
                    PMST,   1
                }

                Method (_INI, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PSC, 0, NotSerialized)
                {
                    Return (PWST)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PS2, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (Zero, PWST)
                }

                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    One
                })
            }

            Device (IEEE)
            {
                Name (_ADR, 0x000D0000)
                OperationRegion (Z004, PCI_Config, Zero, 0x50)
                Field (Z004, DWordAcc, Lock, Preserve)
                {
                    Offset (0x04), 
                        ,   1, 
                    PCIC,   2, 
                    Offset (0x48), 
                    PWRS,   2, 
                    Offset (0x49), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1
                }

                Method (_INI, 0, NotSerialized)
                {
                    Store (Zero, PWRS)
                    Store (Zero, PMEE)
                    Store (Zero, PMES)
                    Store (0x03, PCIC)
                }

                Method (_PSC, 0, NotSerialized)
                {
                    Return (PWRS)
                }

                Method (_PS0, 0, NotSerialized)
                {
                    Store (Zero, PWRS)
                    Store (Zero, PMEE)
                    Store (Zero, PMES)
                    Store (Zero, PWRS)
                    Store (0x03, PCIC)
                }

                Method (_PS2, 0, NotSerialized)
                {
                    Store (Zero, PWRS)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (Zero, PWRS)
                }

                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    One
                })
            }
        }

        Mutex (PSMX, 0x00)
        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Name (INIT, One)
            Name (ACFG, Zero)
            Method (_PSR, 0, NotSerialized)
            {
                SHOW ("ACAD_PSR")
                Acquire (PSMX, 0xFFFF)
                And (One, ^^PCI0.PIB.PMRD (0xA0), Local0)
                Store (Local0, ACFG)
                Store (Local0, INIT)
                Release (PSMX)
                SHOW ("ACAD_PSR Return")
                SHOW (ACFG)
                Return (ACFG)
            }

            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, One)
            Method (_STA, 0, NotSerialized)
            {
                If (FSTA)
                {
                    Acquire (PSMX, 0xFFFF)
                    And (^^PCI0.PIB.PMRD (0xA1), One, Local0)
                    Release (PSMX)
                    If (LEqual (Local0, Zero))
                    {
                        Store (0x0F, BSTA)
                    }
                    Else
                    {
                        Store (0x1F, BSTA)
                    }

                    Store (Zero, FSTA)
                }

                Return (BSTA)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (FBIF)
                {
                    And (^^PCI0.PIB.PMRD (0xA1), One, Local0)
                    If (Local0)
                    {
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                        IVBS ()
                    }

                    Store (Zero, FBIF)
                }

                SHOW ("BAT0_BIF_RETURN:")
                SHOW (PBIF)
                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                SHOW ("BAT0_BST")
                UPBS ()
                SHOW ("BAT0_BST_RETURN:")
                SHOW (PBST)
                Return (PBST)
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (Ones, Index (PBIF, One))
                Store (Ones, Index (PBIF, 0x02))
                Store (Ones, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("Bad", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (Zero, Index (PBST, Zero))
                Store (Ones, Index (PBST, One))
                Store (Ones, Index (PBST, 0x02))
                Store (Ones, Index (PBST, 0x03))
            }

            Method (UPBI, 0, NotSerialized)
            {
                Acquire (PSMX, 0xFFFF)
                Store (0x78, Index (PBIF, One))
                Store (0x64, Index (PBIF, 0x02))
                Store (0x2580, Index (PBIF, 0x04))
                Store ("A340", Index (PBIF, 0x09))
                If (LEqual (^^PCI0.PIB.PMRD (0x16), Zero))
                {
                    Store ("PC-VP-WP21/OP-570-74002 PC-VP-WP25", Index (PBIF, 0x09))
                    Store ("", Index (PBIF, 0x0A))
                    Store ("NiMH", Index (PBIF, 0x0B))
                }
                Else
                {
                    Store ("PC-VP-WP22/OP-570-74001", Index (PBIF, 0x09))
                    Store ("", Index (PBIF, 0x0A))
                    Store ("Lion", Index (PBIF, 0x0B))
                }

                Store ("FIC ", Index (PBIF, 0x0C))
                Release (PSMX)
                Return (PBIF)
            }

            Method (UPBS, 0, NotSerialized)
            {
                Acquire (PSMX, 0xFFFF)
                Store (^^PCI0.PIB.PMRD (0x1A), Local0)
                Store (^^PCI0.PIB.PMRD (0x1B), Local1)
                Multiply (Local1, 0x0100, Local2)
                Or (Local2, Local0, Local3)
                Store (Local3, Index (PBST, Zero))
                Store (^^PCI0.PIB.PMRD (0xA4), Local0)
                Store (Local0, Index (PBST, 0x02))
                Store (0x2580, Index (PBST, 0x03))
                Release (PSMX)
                Return (PBST)
            }

            Name (_PCL, Package (0x01)
            {
                _SB
            })
            Name (BSTA, 0x1F)
            Name (FBIF, One)
            Name (FSTA, One)
            Name (GGFG, Zero)
            Name (PBIF, Package (0x0D)
            {
                Zero, 
                0x78, 
                0x64, 
                One, 
                0x2580, 
                0x08, 
                0x03, 
                One, 
                One, 
                "???", 
                "???", 
                "???", 
                "???"
            })
            Name (PBST, Package (0x04)
            {
                One, 
                Ones, 
                0x64, 
                0x2580
            })
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (LIDF, One)
            Method (_LID, 0, NotSerialized)
            {
                SHOW ("LID_LID Return:")
                SHOW (LIDF)
                Return (LIDF)
            }

            Name (_PRW, Package (0x02)
            {
                0x08, 
                One
            })
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Method (_STA, 0, NotSerialized)
            {
                Return (0x0F)
            }
        }
    }

    Method (SHOW, 1, NotSerialized)
    {
        Store ("__________________________________", Debug)
        Store ("", Debug)
        Store (Arg0, Debug)
        Store ("__________________________________", Debug)
    }

    Method (BEEP, 1, NotSerialized)
    {
        Store (Zero, Local0)
        While (LLess (Local0, Arg0))
        {
            \_SB.VIAX (0x87)
            Increment (Local0)
        }
    }

    Method (HION, 0, NotSerialized)
    {
        Store (Zero, \_SB.PCI0.PM.GO17)
        Store (One, \_SB.PCI0.PM.GO16)
    }
}


--Boundary-00=_5N7gAcL4lUM7Om7
Content-Type: text/plain;
  charset="iso-8859-1";
  name="grep-i_acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="grep-i_acpi"

 BIOS-e820: 0000000016ff0000 - 0000000016fffc00 (ACPI data)
 BIOS-e820: 0000000016fffc00 - 0000000017000000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7030
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x16ffba62
ACPI: FADT (v001 VT8603 TWISTER  0x06040000 PTL  0x000f4240) @ 0x16fffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x16fffbd8
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: root=/dev/hda2 ro acpi=force noapic acpi_os_name="Microsoft Windows XP"
ACPI: Looking for DSDT in initrd ... found customized DSDT with 15240 bytes!
ACPI: Subsystem revision 20040326
ACPI: Overriding _OS definition
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
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
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
ACPI: Thermal Zone [THRM] (72 C)
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x0000000000000049
[ACPI Debug] Integer: 0x0000000000000032
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x0000000000000048
[ACPI Debug] Integer: 0x0000000000000044
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "BAT0_BST"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x10, "BAT0_BST_RETURN:"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] Package: Size 0x04 Elements Ptr - d6f38ac8
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x10, "BAT0_BIF_RETURN:"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] Package: Size 0x0D Elements Ptr - d6fecf48
[ACPI Debug] String: Length 0x22, "__________________________________"

--Boundary-00=_5N7gAcL4lUM7Om7
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg_grep-i_ACPI"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_grep-i_ACPI"

 BIOS-e820: 0000000016ff0000 - 0000000016fffc00 (ACPI data)
 BIOS-e820: 0000000016fffc00 - 0000000017000000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7030
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x16ffba62
ACPI: FADT (v001 VT8603 TWISTER  0x06040000 PTL  0x000f4240) @ 0x16fffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x16fffbd8
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: root=/dev/hda2 ro acpi=force noapic acpi_os_name="Microsoft Windows XP"
ACPI: Looking for DSDT in initrd ... found customized DSDT with 15240 bytes!
ACPI: Subsystem revision 20040326
ACPI: Overriding _OS definition
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
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
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
ACPI: Thermal Zone [THRM] (72 C)
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x0000000000000049
[ACPI Debug] Integer: 0x0000000000000032
[ACPI Debug] Integer: 0x0000000000000001
[ACPI Debug] Integer: 0x0000000000000048
[ACPI Debug] Integer: 0x0000000000000044
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x22, "__________________________________"
[ACPI Debug] String: Length 0x00, ""
[ACPI Debug] String: Length 0x08, "THRM_TMP"
[ACPI Debug] String: Length 0x22, "__________________________________"

--Boundary-00=_5N7gAcL4lUM7Om7--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
