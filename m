From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: Re: 100% of CPU utilization by keventd
Date: Fri, 31 Jan 2003 14:50:31 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E3A8D37.9090908@alvie.com>
References: <20030131135033.GA26660@poulet.zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030131135033.GA26660-iR08WCjiu5SqzqJj4Xwkkg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Cyril Guyot <cyril-Y93EPB1FQwg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Cyril Guyot wrote:

>I am using acpi-20030122 on top of a vanilla linux kernel 2.4.21-pre3;
>on a Toshiba Satellite 5200.
>
>It seems that contrary to kernel-2.4.19 + acpi patch where keventd would
>stay around 0% of CPU utilization, keventd now takes 100% of CPU.
>This behaviour does not happen with kernel 2.4.21-pre3 without ACPI
>patch.
>
>Any idea what the problem could be ?
>
>Also, it seems that kernel-2.5.59 + acpi patch does not boot.
>It will hang at random places during the init process. Booting with
>the acpi=3Doff parameter works.
> =20
>
I have the exact same problem with Satellite 2410. I have done some=20
debugging and reached no conclusion.

Here's the disassembled part of DSDT which I think is relevant:

        Method (_L08, 0, Serialized)
        {
            Store (\_SB.PCI0.PCIB.BRGB, Local0)
            ShiftLeft (Local0, 0x18, Local0)
            Or (Local0, 0x0020B10B, Local0)
            Store (0xAF, \_SB.MEM.IEDI)
            SMBR (0xFF00, Local0, 0x00, 0x00, 0xB2)
            While (LOr (\_SB.MEM.GP50, LOr (\_SB.MEM.GP52, LOr=20
(\_SB.MEM.GP53, LOr (\_SB.MEM.GP54, LOr (\_SB.MEM.GP70, LOr=20
(\_SB.MEM.GP71, LOr (\_SB.MEM.BPFE, \_SB.MEM.SYU2))))))))
            {
                If (\_SB.MEM.GP50)
                {
                    Store (0x00, \_SB.MEM.GP50)
                    Notify (\_SB.ADP1, 0x80)
                    Notify (\_PR.CPU0, 0x80)
                }

                If (\_SB.MEM.GP52)
                {
                    Store (0x00, \_SB.MEM.GP52)
                    If (LEqual (\_SB.MEM.BES1, \_SB.MEM.BT1F))
                    {
                        Notify (\_SB.BAT1, 0x80)
                    }
                    Else
                    {
                        Store (\_SB.MEM.BES1, \_SB.MEM.BT1F)
                        If (\_SB.MEM.BES1)
                        {
                            Notify (\_SB.BAT1, 0x00)
                        }
                        Else
                        {
                            Notify (\_SB.BAT1, 0x01)
                        }
                    }
                }

                If (\_SB.MEM.GP53)
                {
                    Store (0x00, \_SB.MEM.GP53)
                    If (LNot (LEqual (\_SB.MEM.TMP1, \_SB.MEM.AST1)))
                    {
                        Notify (\_TZ.THRM, 0x80)
                    }
                }

                If (\_SB.MEM.GP54)
                {
                    Store (0x00, \_SB.MEM.GP54)
                    If (\_SB.MEM.LANA)
                    {
                        Store (0x00, \_SB.MEM.LANA)
                        Notify (\_SB.PCI0.PCIB.LAN, 0x01)
                    }
                }

                If (\_SB.MEM.GP70)
                {
                    Store (0x00, \_SB.MEM.GP70)
                    If (\_SB.MEM.VALF)
                    {
                        Notify (\_SB.VALD, 0x80)
                    }

                    If (LEqual (\_SB.MEM.HKCD, 0x3D))
                    {
                        TRAP (\_SB.MEM.HKCD)
                    }

                    If (LEqual (\_SB.MEM.DOS2, 0x00))
                    {
                        If (LEqual (\_SB.MEM.HKCD, 0x3F))
                        {
                            If (LEqual (\_SB.MEM.TNVS, 0x00))
                            {
                                Notify (\_SB.PCI0.PCI1.VGA, 0x80)
                            }
                        }
                    }
                }

                If (\_SB.MEM.GP71)
                {
                    Store (0x00, \_SB.MEM.GP71)
                    Notify (\_SB.LID, 0x80)
                }

                If (\_SB.MEM.BPFE)
                {
                    Store (0x00, \_SB.MEM.BPFE)
                    Notify (\_SB.BT, 0x90)
                }

                If (\_SB.MEM.SYU2)
                {
                    Store (0x00, \_SB.MEM.SYU2)
                    Notify (\_PR.CPU0, 0x80)
                }
            }
        }

>Thanks,
>Cyril
>
>
>-------------------------------------------------------
>This SF.NET email is sponsored by:
>SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
>http://www.vasoftware.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
> =20
>


--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
