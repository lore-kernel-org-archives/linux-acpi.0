From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - MacBook2,1
Date: Mon, 21 Jan 2008 01:02:46 -0500
Message-ID: <200801210102.46993.lenb@kernel.org>
References: <413515090710060238x4af5f54fsd558841153480b42@mail.gmail.com> <200801182321.56923.lenb@kernel.org> <479391F7.7080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43712 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbYAUGDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 01:03:06 -0500
In-Reply-To: <479391F7.7080602@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: admin.samae@gmail.com
Cc: linux-acpi@vger.kernel.org

On Sunday 20 January 2008 13:24, eeva wrote:
> Len Brown a =C3=A9crit :
> > On Saturday 06 October 2007 12:05, Samae wrote:
> >> System Information
> >>     Manufacturer: Apple Inc.
> >>     Product Name: MacBook2,1
> >>     Version:  1.0
> >>     Serial Number: W87311YWZ5X
> >>     UUID: 61F9E18A-38B2-B440-A87E-7457DF18863C
> >>     Wake-up Type: Power Switch
> >>     SKU Number: System SKUNumber
> >>     Family: MacBook
> >>
> >> Handle 0x0002, DMI type 2, 16 bytes
> >> Base Board Information
> >>     Manufacturer: Apple Inc.
> >>     Product Name: Mac-F4208CAA
> >=20
> >=20
> > Thanks for the dmidecode output.
> >=20
> > Do you notice any functional difference when booting with
> >=20
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >=20
> > Also, please send me the output from acpidump.
> >=20
> > thanks,
> > -Len
> >=20
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> >=20
>=20
> I haven't notice any difference when booting with one or the other=20
> kernel. I send you the output of acpidump.
> pmtools wasn't reachable so I built it with an archlinux PKGBUILD. it=
=20
> worked nicely.
>=20

acpi_osi=3DLinux is a NOP on the MacBook2,1 because it only
compares OSYS to Darwin.  Everything else is treated the same.


thanks,
-Len

            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Darwin"))
                {
                    Store (0x2710, OSYS)
                }
                Else
                {
                    If (_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }
                    Else
                    {
                        Store (0x07D1, OSYS)
                    }
                }
            }
            Else
            {
                Store (0x07D0, OSYS)
            }
=2E....
    Method (OSDW, 0, NotSerialized)
    {
        If (LEqual (OSYS, 0x2710))
        {
            Return (0x01)
        }
        Else
        {
            Return (0x00)
        }
    }
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
