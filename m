From: Len Brown <lenb@kernel.org>
Subject: Re: DMIDECODE , HP Pavilion dv9540US
Date: Fri, 18 Jan 2008 23:56:48 -0500
Message-ID: <200801182356.49065.lenb@kernel.org>
References: <47252A49.4020108@projetofedora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59302 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762823AbYASE5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:57:02 -0500
In-Reply-To: <47252A49.4020108@projetofedora.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauricio Pretto <mauricio@projetofedora.org>
Cc: linux-acpi@vger.kernel.org

On Sunday 28 October 2007 20:33, Mauricio Pretto wrote:
> System Information
> =A0 =A0 =A0 =A0 =A0Manufacturer: Hewlett-Packard
> =A0 =A0 =A0 =A0 =A0Product Name: HP Pavilion dv9500 Notebook PC
> =A0 =A0 =A0 =A0 =A0Version: Rev 1
> =A0 =A0 =A0 =A0 =A0Serial Number: CNF7301MNP
> =A0 =A0 =A0 =A0 =A0UUID: 434E4637-3330-314D-4E50-001B24718C0D
> =A0 =A0 =A0 =A0 =A0Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 =A0SKU Number: GA336UA#ABA
> =A0 =A0 =A0 =A0 =A0Family: 103C_5335KV
>=20
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
> =A0 =A0 =A0 =A0 =A0Manufacturer: Quanta
> =A0 =A0 =A0 =A0 =A0Product Name: 30CB

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

in particular, please test the sound and wifi

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
