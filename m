From: Len Brown <lenb@kernel.org>
Subject: Re: scary warnings
Date: Thu, 31 May 2007 20:55:04 -0400
Message-ID: <200705312055.05142.lenb@kernel.org>
References: <1180656688.3779.6.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42572 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbXFAAzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 20:55:18 -0400
In-Reply-To: <1180656688.3779.6.camel@monteirov>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: acpi devel <linux-acpi@vger.kernel.org>

Please open a sighting at bugzilla.kernel.org against ACPI/tables
and attach the output from acpidump

thanks,
-Len

On Thursday 31 May 2007 20:11, Sergio Monteiro Basto wrote:
> I got this messages warnings, I just found it, after had other proble=
ms
> not related with ACPI, I am been running with this kernels one or two
> months ago, and I don't had problems, just reporting the situation,
> could be useful anyway.=20
> Thanks,
>=20
> ACPI Warning (tbfadt-0360): Ignoring BIOS FADT r2 C-state control [20=
070126]
> (...)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> ACPI Warning (tbutils-0158): Incorrect checksum in table [  =C3=B0] -=
  00, should be E7 [20070126]
> ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B0], m=
ust be SSDT or PSDT [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1.=
_PDC] (Node ffff810037cc3b50), AE_BAD_SIGNATURE
> ACPI Warning (tbutils-0158): Incorrect checksum in table [  =C3=B0] -=
  00, should be E7 [20070126]
> ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B0], m=
ust be SSDT or PSDT [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2.=
_PDC] (Node ffff810037cc3a50), AE_BAD_SIGNATURE
> ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device =
is not present [20070126]
> ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device =
is not present [20070126]
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
