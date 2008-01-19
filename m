From: Len Brown <lenb@kernel.org>
Subject: Re: By popular demand - dmidecode on Compal H/EL80
Date: Sat, 19 Jan 2008 01:57:09 -0500
Message-ID: <200801190157.09256.lenb@kernel.org>
References: <200707100843.04391.m.jedrasik@gmail.com> <200801181841.29885.lenb@kernel.org> <200801190053.31682.m.jedrasik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47979 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYASG5X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 01:57:23 -0500
In-Reply-To: <200801190053.31682.m.jedrasik@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mateusz Jedrasik <m.jedrasik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 18 January 2008 18:53, Mateusz Jedrasik wrote:
> Saturday 19 of January 2008 00:41:29 napisa=C5=82e=C5=9B(-=C5=82a=C5=9B=
):
> > System Information
> > 	Manufacturer: COMPAL
> > 	Product Name: HEL80I
> > 	Version: -
> > 	Serial Number: 2054228700233
> > 	UUID: 158F767F-3E9F-11DB-B7EC-0016D41DF7E7
> > 	Wake-up Type: Power Switch
> > 	SKU Number:
> > 	Family: Intel
> >
> > Handle 0x0002, DMI type 2, 8 bytes
> > Base Board Information
> > 	Manufacturer: COMPAL
> > 	Product Name: HEL8X
> >
> > Do you notice any functional difference when booting with
> >
>=20
> Yes, with acpi_osi=3D!Linux (it defaults to windows or so then) some =
acpi=20
> messages were spewed, errorous - tho not fatal. If you want, I can po=
st a=20
> dmesg with, and without the acpi_osi parameter.
>=20
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)

Thanks for the acpidump.

Please verify that /proc/acpi/ac makes sense in both cases,
and that you get AC/DC events when you switch between AC and battery.

Please compare the contents of /proc/acpi/battery
in both cases.

Please test brightness control,
via either /proc/acpi/video or /sys/class/backlight
in both cases.

Also, please test hibernate to disk with both params,
and see if /proc/acpi/thermal_zone/* still make sense
before and after.

thanks,
-Len


          Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)

# this store to OSYS is a NOP because it gets over-written
# by the stores below.

                    Store (Zero, ECDY)

# this store to ECDY=20
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    Store (0x07D1, OSYS)
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    Store (0x07D2, OSYS)
                }

                If (_OSI ("Windows 2006"))
                {
                    Store (0x07D6, OSYS)
                }

                If (LLessEqual (OSYS, 0x07D2))
                {
                    TRAP (0x49)
                }

                If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                {
                    TRAP (0x3D)
                }
=2E..
    Name (ECDY, 0x05)

   Method (_WAK, 1, NotSerialized)
=2E..
       If (LEqual (Arg0, 0x04))
        {
# we come here only on wakeup from S4 -- hibernate to disk

            If (DTSE)
            {
                TRAP (0x47)
                If (LAnd (\_SB.PCI0.LPCB.ECOK (), LEqual (ECDY, Zero)))
                {
# this is the ECDY=3D0 Linux case
# I'm guessing this has something to do with the Digital Thermal Sensor

                    If (LGreaterEqual (DTS1, DTS2))
                    {
                        Store (DTS1, \_SB.PCI0.LPCB.EC0.SKTA)
                    }
                    Else
                    {
                        Store (DTS2, \_SB.PCI0.LPCB.EC0.SKTA)
                    }
                }
                Else
                {
                    \_SB.PCI0.LPCB.PHSS (0x10)
                }
            }
        }

=2E..
        Method (_L02, 0, NotSerialized)
        {
            Store (Zero, GPEC)
            If (LAnd (\_SB.PCI0.LPCB.ECOK (), LEqual (ECDY, Zero)))
            {
# again the ECDY=3D0 Linux case is toching DTS1 and DTS2

                If (LGreaterEqual (DTS1, DTS2))
                {
                    Store (DTS1, \_SB.PCI0.LPCB.EC0.SKTA)
                }
                Else
                {
                    Store (DTS2, \_SB.PCI0.LPCB.EC0.SKTA)
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.PHSS (0x10)
            }
        }
=2E..
                        Method (_BCL, 0, NotSerialized)
                        {
                            If (LAnd (^^^^LPCB.ECOK (), LEqual (ECDY, Z=
ero)))

# brightness control sees ECDY=3D0,
# does it work with and without OSI(Linux)?

                            {
                                If (LEqual (OSYS, 0x07D6))
                                {
                                    If (LEqual (^^^^LPCB.EC0.OSTY, Zero=
))
                                    {
                                        Store (One, ^^^^LPCB.EC0.OSTY)
                                    }
                                }
                                Else
                                {
                                    If (LEqual (^^^^LPCB.EC0.OSTY, One)=
)
                                    {
                                        Store (Zero, ^^^^LPCB.EC0.OSTY)
                                    }
                                }
                            }
=2E..
# AC adapter sees ECDY=3D0
              Device (ACAD)
                {
                    Name (_HID, "ACPI0003")
                    Name (_PCL, Package (0x01)
                    {
                        _SB
                    })
                    Method (_PSR, 0, NotSerialized)
                    {
                        If (LAnd (ECOK (), LEqual (ECDY, Zero)))
                        {
                            If (LEqual (OSYS, 0x07D6))
                            {
                                If (LEqual (^^EC0.OSTY, Zero))
                                {
                                    Store (One, ^^EC0.OSTY)
                                }
                            }
                            Else
                            {
                                If (LEqual (^^EC0.OSTY, One))
                                {
                                    Store (Zero, ^^EC0.OSTY)
                                }
                            }
                        }

                        Store (One, ACPW)
                        Return (ACPW)
                    }
                }

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
