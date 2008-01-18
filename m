From: Len Brown <lenb@kernel.org>
Subject: Re: Dell Optiplex GX620 BIOS A11 dmidecode kernel 2.6.22
Date: Fri, 18 Jan 2008 18:34:20 -0500
Message-ID: <200801181834.20589.lenb@kernel.org>
References: <20070709094914.273BC11484@nebuchadnezzar.smejdil.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34302 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbYARXeh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 18:34:37 -0500
In-Reply-To: <20070709094914.273BC11484@nebuchadnezzar.smejdil.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Semler <cijoml@compare.cz>
Cc: linux-acpi@vger.kernel.org

On Monday 09 July 2007 05:49, Michal Semler wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Dell Inc.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: OptiPlex GX620
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: Not Specified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: JLG4Q2J
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 44454C4C-4C00-1047-8034-CAC04F51324=
A
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch=20
>=20
> Handle 0x0200, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Dell Inc.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: 0FH884

Michal, I didn't see an acpidump in that e-mail, can you send it to me?

also, do you notice any _functional_ difference after booting with
"acpi_osi=3DLinux"
vs
"acpi_osi=3D!Linux"?

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
