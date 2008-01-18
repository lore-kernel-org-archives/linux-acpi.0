From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output on lenovo 3000 V100
Date: Fri, 18 Jan 2008 16:53:26 -0500
Message-ID: <200801181653.26955.lenb@kernel.org>
References: <475313B1.4080901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38780 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487AbYARVxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 16:53:42 -0500
In-Reply-To: <475313B1.4080901@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Schleehauf <S.Schleehauf@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Sunday 02 December 2007 15:21, Sebastian Schleehauf wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: LENOVO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: 076326G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: LENOVO3000 V=
100

With 2.6.22, did you notice any functional difference with "acpi_osi=3D=
!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=3DLinux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
