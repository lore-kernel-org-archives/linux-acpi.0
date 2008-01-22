From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Acer Aspire 5050)
Date: Mon, 21 Jan 2008 23:55:26 -0500
Message-ID: <200801212355.26301.lenb@kernel.org>
References: <1195031290.6446.1.camel@ITmanager> <200801212133.32483.lenb@kernel.org> <47955F6E.1090208@neptuneconcept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53646 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbYAVE4K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 23:56:10 -0500
In-Reply-To: <47955F6E.1090208@neptuneconcept.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philippe Didier <pdidier@neptuneconcept.com>
Cc: linux-acpi@vger.kernel.org

On Monday 21 January 2008 22:13, Philippe Didier wrote:
> I  managed to boot with acpi_osi=3D!Linux (and not =3DLinux as you wr=
ote=20
> before). I send you an extract of my /var/log/messages ... look at th=
e=20
> first and the last line. It seems that the option is here but the BIO=
S=20
> is still doing its way,,,

> Jan 22 09:46:26 IT-Manager kernel: [ =C2=A0 =C2=A00.000000] Kernel co=
mmand line: root=3DUUID=3Da19a083e-69cd-4384-a52a-b70a43d4235a ro quiet=
 splash acpi_osi=3D!Linux=20
> Jan 22 09:46:26 IT-Manager kernel: [ =C2=A0 =C2=A00.000000] ACPI: Dis=
abled _OSI(Linux)

This means that your cmdline override worked.
It also means that OSI(Linux) was enabled, which means you were running=
 2.6.22.

> Jan 22 09:46:26 IT-Manager kernel: [ =C2=A0 =C2=A00.652000] ACPI: Sys=
tem BIOS is requesting _OSI(Linux)
> Jan 22 09:46:26 IT-Manager kernel: [ =C2=A0 =C2=A00.652000] ACPI: Ple=
ase test with "acpi_osi=3D!Linux"

this also means that you are running 2.6.22, which had OSI(Linux) enabl=
ed by default
and wasn't smart enough to change the line above when there was a cmdli=
ne override.

2.6.23 is just as dumb, but with the opposite polarity:-)

The patch for 2.6.24 will be a little more clever, and I'll
probably send it to 2.6.23.stable as well...


thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
