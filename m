From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 0/10] drivers/acpi/asus_acpi.c updates [RESEND]
Date: Fri, 30 Jun 2006 20:49:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16D9D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3739 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751201AbWGAAtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 20:49:09 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-acpi@vger.kernel.org

W3000 patch reverted
1-10 from this series applied.

Karol,
Shall I expect an updated W3000 patch from you?

thanks,
-Len

>-----Original Message-----
>From: Karol Kozimor [mailto:sziwan@hell.org.pl]=20
>Sent: Friday, June 30, 2006 6:59 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org
>Subject: [PATCH 0/10] drivers/acpi/asus_acpi.c updates [RESEND]
>
>Hi,
>
>The following batch of patches update the asus_acpi driver to=20
>version 0.30
>through the following changes:
>
>Readd WLED for S1N
>Rework model detection for more flexibility and less oopses
>Resolve confusion, "bluetooth" entry controls both the internal adapte=
r
>  *and* its LED
>Added support for L5D
>Added support for W5A (patch from Fernando A. P. Gomes)
>Added support for A4759GUH (A4G, patch from Giuseppe Rota)
>Added support for W3400N
>Added support for W1N LED display (thx =C9ric BURGHARD)
>Added support for A3000G
>Fix M6R/M6N mismerge
>
>Please apply.
>Best regards,
>
>--=20
>Karol 'sziwan' Kozimor
>sziwan@hell.org.pl
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
