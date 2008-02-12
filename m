From: Len Brown <lenb@kernel.org>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 15:00:25 -0500
Message-ID: <200802121500.25986.lenb@kernel.org>
References: <200710122357.46851.dl9pf@gmx.de> <200801182329.49567.lenb@kernel.org> <200802121157.33691.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56521 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYBLUAl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 15:00:41 -0500
In-Reply-To: <200802121157.33691.dl9pf@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Tuesday 12 February 2008 05:57, Jan-Simon M=C3=B6ller wrote:
> Sorry for the late reply !
>=20
> Am Samstag 19 Januar 2008 05:29:49 schrieb Len Brown:
> > On Saturday 13 October 2007 04:13, Jan-Simon M=C3=B6ller wrote:
> > > System Information
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 20
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505
> >
> > Jan-Simon,
> > Thanks for the dmidecode output.
> >
> > Did the console dmesg ask you to send it because
> > of OSI(Linux)?
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >
> > Also, please send me the output from acpidump.
> Didn't notice any difference.
> acpidump here:
>=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D9939
>=20
> > thanks,
> > -Len
> >
>=20
> Thanks!

thanks for the acpidump in http://bugzilla.kernel.org/show_bug.cgi?id=3D=
9939

This BIOS makes heavy use of TRAP's into SMM, Windows version-specific =
hooks,
and WMI -- all bad news for Linux.

But OSI(Linux) itself is a NOP on this box, since LINX is set and never=
 referenced, per below.

-Len

       Method (_INI, 0, NotSerialized)
        {
            If (DTSE)
            {
                TRAP (0x47)
            }

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x01, LINX)
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
            }

            If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
            {
                TRAP (0x3D)
            }

            TRAP (0x2B)
            TRAP (0x32)
        }
    }
=2E..
    OperationRegion (GNVS, SystemMemory, 0x7F6DEDBC, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
        LCKF,   8,
        PRM4,   8,
        PRM5,   8,
        P80D,   32,
        LIDS,   8,
        PWRS,   8,
        DBGS,   8,
        LINX,   8,
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
