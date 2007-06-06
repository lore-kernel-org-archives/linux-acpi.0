From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: scary warnings
Date: Wed, 06 Jun 2007 03:10:08 +0100
Message-ID: <1181095808.3601.2.camel@monteirov>
References: <1180656688.3779.6.camel@monteirov>
	 <200705312055.05142.lenb@kernel.org>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.netcabo.pt ([212.113.174.28]:50700 "EHLO
	exch01smtp11.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932295AbXFFCK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2007 22:10:29 -0400
In-Reply-To: <200705312055.05142.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: acpi devel <linux-acpi@vger.kernel.org>

On Thu, 2007-05-31 at 20:55 -0400, Len Brown wrote:
> Please open a sighting at bugzilla.kernel.org against ACPI/tables
> and attach the output from acpidump

ok, http://bugzilla.kernel.org/show_bug.cgi?id=3D8590

Best regards ,=20

>=20
> thanks,
> -Len
>=20
> On Thursday 31 May 2007 20:11, Sergio Monteiro Basto wrote:
> > I got this messages warnings, I just found it, after had other prob=
lems
> > not related with ACPI, I am been running with this kernels one or t=
wo
> > months ago, and I don't had problems, just reporting the situation,
> > could be useful anyway.=20
> > Thanks,
> >=20
> > ACPI Warning (tbfadt-0360): Ignoring BIOS FADT r2 C-state control [=
20070126]
> > (...)
> > pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> > ACPI Warning (tbutils-0158): Incorrect checksum in table [  =C3=B0]=
 -  00, should be E7 [20070126]
> > ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B0],=
 must be SSDT or PSDT [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU=
1._PDC] (Node ffff810037cc3b50), AE_BAD_SIGNATURE
> > ACPI Warning (tbutils-0158): Incorrect checksum in table [  =C3=B0]=
 -  00, should be E7 [20070126]
> > ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B0],=
 must be SSDT or PSDT [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU=
2._PDC] (Node ffff810037cc3a50), AE_BAD_SIGNATURE
> > ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Devic=
e is not present [20070126]
> > ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Devic=
e is not present [20070126]
> >=20
--=20
S=C3=A9rgio M.B.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
