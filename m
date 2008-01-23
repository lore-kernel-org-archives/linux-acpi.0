From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode. - Dell Precision WorkStation 390
Date: Wed, 23 Jan 2008 00:19:31 -0500
Message-ID: <200801230019.31969.lenb@kernel.org>
References: <4743F51D.2070507@toulouse.inra.fr> <200801181712.46158.lenb@kernel.org> <479608B8.5050506@toulouse.inra.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54673 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbYAWFTw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 00:19:52 -0500
In-Reply-To: <479608B8.5050506@toulouse.inra.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alain Pollidoro <alain.pollidoro@toulouse.inra.fr>
Cc: linux-acpi@vger.kernel.org

On Tuesday 22 January 2008 10:16, Alain Pollidoro wrote:
>  Hello,
> =20
>  Len Brown a =C3=A9crit=C2=A0:=20
> On Wednesday 21 November 2007 04:06, Alain Pollidoro wrote:
>  =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Dell In=
c. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Precisi=
on WorkStation 390
>    =20
>=20
> With 2.6.22, did you notice any functional difference with "acpi_osi=3D=
!Linux"?
>  =20
>  No.
>  My current kernel is a debian testing 2.6.22-3-686.

thanks for the acpidump.
It loks a lot like the code for the Inspiron 5150.

Does USB work properly both before and after suspend-to disk?
That is the only area where OSI(Linux) looks like it would have an effe=
ct.
Basically, some USB related code in the DSDT becomes a NOP instead of c=
alling SMI.


thanks,
-Len


# ISLI was clearly written to look for Linux:

        Method (ISLI, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Return (One)
                }
                Else
                {
                    Return (Zero)
                }
            }
            Else
            {
                Return (Zero)
            }
        }

# GUSB is the only caller of ISLI

    Method (GUSB, 0, NotSerialized)
    {
        If (ISLI ())
        {
            Return (Zero)
        }
        Else
        {
            Return (SMI2 (0xBA))
        }
    }


# GUSB is invoked at init-time:
    Scope (_SB.PCI0)
    {
        Device (USB0)
        {
            Name (_ADR, 0x001D0000)
            Name (_UID, 0x05)
            Name (_PRW, Package (0x02)
            {
                0x03,
                0x03
            })
            OperationRegion (UPC1, PCI_Config, 0xC1, One)
            Field (UPC1, ByteAcc, NoLock, Preserve)
            {
                LEGK,   8
            }

            Method (_INI, 0, NotSerialized)
            {
                If (HACK ()) {}
                Else
                {
                    Store (LEGK, Local0)
                    And (Local0, 0x60, Local0)
                    Or (Local0, 0x20, Local0)
                    Store (Local0, LEGK)
                }

                GUSB ()
            }

# GUSB is invoked at wakeup from S4 time:

    Method (_WAK, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x04))
        {
            GUSB ()
        }

        If (Or (And (PMS2, One), Or (And (LNot (HACK ()),
            And (GLBT, 0x11)), And (LNot (HACK ()), And (THRP, 0x18
            )))))
        {
            Notify (\_SB.VBTN, 0x02)
        }

        Return (Zero)
    }

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
