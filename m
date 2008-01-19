From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Benq joybook s31
Date: Fri, 18 Jan 2008 22:38:14 -0500
Message-ID: <200801182238.14461.lenb@kernel.org>
References: <1188647577.7619.2.camel@corvax-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58587 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761669AbYASDic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:38:32 -0500
In-Reply-To: <1188647577.7619.2.camel@corvax-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corvax@corvax.ru
Cc: linux-acpi@vger.kernel.org

On Saturday 01 September 2007 07:52, Dmitry Marin wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: BenQ
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: Joybook S31
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: 9H00P11R0364406335DHT300
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 80F9339B-D064-0010-B856-00163691CDB=
5
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: BenQ
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: Joybook S31

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
