From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - FSC AMILO Pi 1556
Date: Mon, 21 Jan 2008 00:17:45 -0500
Message-ID: <200801210017.45123.lenb@kernel.org>
References: <843771192296565@webmail31.yandex.ru> <1079241200774403@webmail33.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56918 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbYAUFR6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 00:17:58 -0500
In-Reply-To: <1079241200774403@webmail33.yandex.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Virus Q <qvirus@yandex.ru>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 15:26, Virus Q wrote:
> Hi, Len!
>=20
> 19.01.08, 07:33, Len Brown (lenb@kernel.org):
>=20
> > On Saturday 13 October 2007 13:29, Virus Q wrote:
> > > System Information
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: AMILO Pi 1556
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: Not Applicable
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 5311A8AF
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 00278868-CD63-0010-9AC8-B203A3B=
3CC32
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
> > >=20
> > > Handle 0x0002, DMI type 2, 8 bytes.
> > > Base Board Information
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: AMILO Pi 1556
> > Thanks for the dmidecode output.
> ...
> > Also, please send me the output from acpidump.
>=20
> Send you a file with the output from acpidump.

Thanks for the acpidump -- it shows that OSI(Linux)
is a NOP on this box b/c the results of the test for
it are immediately over-written anyway.

-Len
--------------
    Scope (_SB)
    {
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
                    Store (0x03E8, OSYS)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
=2E..
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
