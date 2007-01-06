From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: Problem with HP Pavillion DV8000
Date: Sat, 6 Jan 2007 10:09:56 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE8E8F3C@mssmsx411>
References: <beb91d720701052012j5dbc94aay9fb8142031a6b7cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34101 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXAFHKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jan 2007 02:10:00 -0500
Content-class: urn:content-classes:message
In-Reply-To: <beb91d720701052012j5dbc94aay9fb8142031a6b7cd@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Salatiel Filho <salatiel.filho@gmail.com>
Cc: linux-acpi@vger.kernel.org

> I`m having a lot of ACPI BATTERY related problems ...

Please look into the bug #7386 and try 'acpi_serialize' flag.

-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Salatiel Filho
Sent: Saturday, January 06, 2007 7:13 AM
To: linux-acpi@vger.kernel.org
Subject: Re: Problem with HP Pavillion DV8000

I`m having a lot of ACPI BATTERY related problems ...

A lot of
Jan  6 00:43:49 localhost kernel: ACPI Error (psargs-0355): [PBST]
Namespace lookup failure, AE_NOT_FOUND
Jan  6 00:43:49 localhost kernel: ACPI Error (psparse-0537): Method
parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
AE_NOT_FOUND
Jan  6 00:43:49 localhost kernel: ACPI Exception (acpi_battery-0207):
AE_NOT_FOUND, Evaluating _BST [20060707]
Jan  6 00:44:19 localhost kernel: ACPI Error (psargs-0355): [PBST]
Namespace lookup failure, AE_NOT_FOUND
Jan  6 00:44:19 localhost kernel: ACPI Error (psparse-0537): Method
parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
AE_NOT_FOUND
Jan  6 00:44:19 localhost kernel: ACPI Exception (acpi_battery-0207):
AE_NOT_FOUND, Evaluating _BST [20060707]
Jan  6 00:44:49 localhost kernel: ACPI Error (psargs-0355): [PBST]
Namespace lookup failure, AE_NOT_FOUND
Jan  6 00:44:49 localhost kernel: ACPI Error (psparse-0537): Method
parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
AE_NOT_FOUND
Jan  6 00:44:49 localhost kernel: ACPI Exception (acpi_battery-0207):
AE_NOT_FOUND, Evaluating _BST [20060707]

is there anyway to fix this ?

I have a HP PAVILLION DV8230us ...
Any help is really appreciated.
Thanks in advice.



--=20
[]'s
Salatiel

"O maior prazer do inteligente =E9 bancar o  idiota
   diante de um  idiota que banca o inteligente".
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
