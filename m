From: "Joey Lee" <jlee@novell.com>
Subject: Re: MSI GX723 notebook - ACPI problem with Fn keys
Date: Mon, 27 Sep 2010 02:05:57 -0600
Message-ID: <4CA0DD050200002300020E08@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: patrol@sinus.cz
Cc: Thomas Renninger <trenn@novell.com>, linux-acpi@vger.kernel.org

Hi Pavel,=20

=E6=96=BC =E5=85=AD=EF=BC=8C2010-09-25 =E6=96=BC 14:44 +0200=EF=BC=8CPa=
vel Troller =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi!
>   I'm a fresh owner of GX723 notebook by MSI. It looks relatively
> linux-friendly, but I've found some ACPI-related issues.
>   1) Booting 2.6.35.5 kernel natively, the Fn keys (brightness contro=
l,
> video switching) are non-functional and even a single keypress causes=
,
> that ACPI events (like AC adapter status changes or lid switch operat=
ion) are
> not generated anymore. After a while (about 10 minutes), the followin=
g
> lines pop to the system log:
> Sep 25 13:53:18 beam kernel: ACPI Error (psparse-0537): Method parse/=
execution failed [\_SB_.PCI0.SBRG.EC__._QB7] (Node ffff88013fc1ff00), A=
E_AML_INFINITE_LOOP
> Sep 25 13:42:23 beam kernel: ACPI Error (psparse-0537): Method parse/=
execution failed [\_SB_.PCI0.SBRG.EC__._QB8] (Node ffff88013fc1ff20), A=
E_AML_INFINITE_LOOP

In _QB7 and _QB8 have the following infinite while loop:

                        If (_OSI ("Windows 2006"))
                        { =20
                            If (LEqual (^^^P0P2.VGA.VVID, 0x10DE))
                            { =20
                                Store (One, ^^^P0P2.VGA.MSIB)
                                Store (Zero, ^^^P0P2.VGA.MSIM)
                                Store (One, ^^^P0P2.VGA.MSIE) /* defalu=
t
is one */
                                Sleep (0x0A)
                                Notify (^^^P0P2.VGA, 0xCB)
                                While (^^^P0P2.VGA.MSIE)  /* infinite *=
/
                                {
                                    Sleep (0x0A)
                                }
                            }
                        }

The MSIE is just a named object declared in VGA device but it's not any
hardware register. So, kernel's acpi parser is right, it's a infinite
loop.

>   I've dumped and disassembled the DSDT and looked at the above metho=
ds. What
> felt into my eyes immediately, were _OSI("Windows 2006") calls and th=
en
> conditional code execution in these methods. So my next boot was with
> acpi_osi=3D"!Windows 2006" and it fully repaired this problem. Now, t=
he=20
> brightness keys really do regulate brightness (causing no acpi events=
),
> the VGA switcher generates the VGA ACPI event and of course other ACP=
I
> events are being generated without any problems.
>   So, it would be good to either look at the problem and fix it in Li=
nux,
> or put vista to the blacklist for this notebook type (in the case it =
is the
> DSDT bug).

Don't know why MSI do a named object value check in a infinite loop, I
thought it's a workaround in DSDT with Windows Vista's nVIDIA driver fo=
r
brightness control.
Could you please kindly provide the dmidecode dump to me? Then we can
send out patch to put this MSI notebook to blacklist.

>   2) Even with vista string disabled, the following warning is still =
printed
> to the log on every boot:
> Sep 25 14:09:03 beam kernel: ACPI Warning for \_SB_.PCI0.P0P2.VGA_.MX=
MI: Excess arguments - needs 1, found 2 (20100428/nspredef-319)
> Sep 25 14:09:03 beam kernel: ACPI Warning for \_SB_.PCI0.P0P2.VGA_.MX=
MS: Excess arguments - needs 1, found 2 (20100428/nspredef-319)
> It looks like a DSDT bug. I hope it is harmless.
>   I've flashed the BIOS to the latest available (1.11).
>   The DSDT table is attached.
>=20

I thought it should be ok.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
