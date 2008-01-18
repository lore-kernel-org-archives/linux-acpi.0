From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode.
Date: Fri, 18 Jan 2008 17:12:46 -0500
Message-ID: <200801181712.46158.lenb@kernel.org>
References: <4743F51D.2070507@toulouse.inra.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34325 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762933AbYARWNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 17:13:08 -0500
In-Reply-To: <4743F51D.2070507@toulouse.inra.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alain Pollidoro <alain.pollidoro@toulouse.inra.fr>
Cc: linux-acpi@vger.kernel.org

On Wednesday 21 November 2007 04:06, Alain Pollidoro wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Dell In=
c. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Precisi=
on WorkStation 390

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
