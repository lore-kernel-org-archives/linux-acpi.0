From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from Dell Vostro 1000
Date: Fri, 18 Jan 2008 17:06:18 -0500
Message-ID: <200801181706.18640.lenb@kernel.org>
References: <3a082f0c0711201915p3f10ec66mc6d8f024da8f363d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43038 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760933AbYARWGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 17:06:32 -0500
In-Reply-To: <3a082f0c0711201915p3f10ec66mc6d8f024da8f363d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaakan Shorter <jaakanshorter@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 20 November 2007 22:15, Jaakan Shorter wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Dell In=
c.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Vostro =
=C2=A0 1000

No difference in the dmesg jump out at me.

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
