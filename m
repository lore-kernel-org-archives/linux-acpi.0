From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: Please test with "acpi_osi=!Linux" / Please send dmidecode to linux-acpi@vger.kernel.org
Date: Fri, 18 Jan 2008 17:34:52 -0500
Message-ID: <200801181734.52764.lenb@kernel.org>
References: <47387CFA.3070705@fb-cs.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51057 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760670AbYARWfK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 17:35:10 -0500
In-Reply-To: <47387CFA.3070705@fb-cs.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Dennis <chris@fb-cs.co.uk>
Cc: linux-acpi@vger.kernel.org

On Monday 12 November 2007 11:19, Chris Dennis wrote:
> System Information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Acer
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: TravelM=
ate 7510

thanks for the two dmesg, but nothing jumps out at me there.

With 2.6.22, did you notice any _functional_ difference with "acpi_osi=3D=
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
