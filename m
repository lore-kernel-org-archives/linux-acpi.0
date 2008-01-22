From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode to linux-acpi@vger.kernel.org - Sony VGN-SZ38GP_C
Date: Mon, 21 Jan 2008 21:37:22 -0500
Message-ID: <200801212137.22514.lenb@kernel.org>
References: <87ir6eyjt0.fsf@c0nc3pt.com> <200801182259.03692.lenb@kernel.org> <87ve5n8it8.fsf@c0nc3pt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58185 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbYAVChm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 21:37:42 -0500
In-Reply-To: <87ve5n8it8.fsf@c0nc3pt.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Di Marco <dmr@c0nc3pt.com>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 07:27, Alessandro Di Marco wrote:
> Len Brown <lenb@kernel.org> writes:
>=20
>    On Thursday 13 September 2007 05:51, Alessandro Di Marco wrote:
>    > System Information
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: So=
ny Corporation
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: VG=
N-SZ38GP_C
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: J0020Y9=
W
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Serial Number: 2=
8247270-7003707
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID: CEBBB8E0-5=
B3C-11D9-8796-0013A98B94A4
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Wake-up Type: Po=
wer Switch
>    >=20
>    > Handle 0x0002, DMI type 2, 10 bytes
>    > Base Board Information
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: So=
ny Corporation
>    > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: VA=
IO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0
>=20
thanks for the acpidump output.
It is clear that OSI(Linux) is a NOP on the Sony VGN-SZ38GP_C:

            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }

                If (\_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
