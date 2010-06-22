From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.35-rc3 regression: IBM Maia system is unbootable [ACPI related?]
Date: Tue, 22 Jun 2010 16:28:13 +0200
Message-ID: <201006221628.14038.maciej.rutecki@gmail.com>
References: <1277136189.10998.63.camel@mulgrave.site>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39124 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab0FVO2U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2010 10:28:20 -0400
In-Reply-To: <1277136189.10998.63.camel@mulgrave.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On poniedzia=C5=82ek, 21 czerwca 2010 o 18:03:09 James Bottomley wrote:
> The system in question has a set of root bridges, with the CD rom (wh=
ich
> is seen) being on bus 0 and the SCSI controller, which doesn't show u=
p
> being on bus 1 (with several other things on busses > 1).
>=20
> The system uses ACPI to detect the multiple bridges, so it seems that
> this failure in 2.6.35-rc3:
>=20
> ACPI: Core revision 20100428
> ACPI Error: Hardware did not enter ACPI mode (20100428/evxfevnt-103)
> ACPI Warning: AcpiEnable failed (20100428/utxface-147)
> ACPI: Unable to enable ACPI
>=20
> Means that we can't detect any PCI bus other than 0 and thus the syst=
em
> won't boot.
>=20
> The full dmesgs for a successful (2.6.34) and failed (2.6.35-rc3) boo=
t
> are below.
>=20
> James

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D16271
for your bug report, please add your address to the CC list in there, t=
hanks!

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
