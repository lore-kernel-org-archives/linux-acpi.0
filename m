From: "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: RE: Can't get ACPI to work on a Panasonic Toughbook CF-52
Date: Sun, 13 Apr 2008 18:19:36 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC20122C2F2@pdsmsx415.ccr.corp.intel.com>
References: <4801D253.40904@orle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2432 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032AbYDMKTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Apr 2008 06:19:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4801D253.40904@orle.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ralf Orlowski <ralf@orle.de>, linux-acpi@vger.kernel.org

Will you please try to boot the system with the option of "acpi=3Doff" =
and attach the output of acpidump, lspci -vxxx ?
Thanks.

-----Original Message-----
=46rom: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Ralf Orlowski
Sent: 2008=C4=EA4=D4=C213=C8=D5 17:29
To: linux-acpi@vger.kernel.org
Subject: Can't get ACPI to work on a Panasonic Toughbook CF-52

Hello,

I just got a new Panasonic Toughbook CF-52.
I installed the system with debian sid and except of the ACPI-Support=20
the system runs fine under linux.
But so far I had no success to get ACPI working on the system.

Today I installed kernel version 2.6.25-rc9 on the system, because I=20
read, there should be a patch included, that make ACPI work on my=20
system. But so far it does not.

The kernel runs fine with ACPI disabled, but with ACPI enabled the boot=
=20
just stops with a message about ACPI interrupts.

Does anyone know, what I could try, to get ACPI working, or how I could=
=20
find out more about the problem to may be help to find a solution?

Bye

Ralf
--=20
Ralf Orlowski                           voice: +49-8134-935781
Hadersried 27a                          car:   +49-173-5239069
85235 Odelzhausen                       mobil: +49-160-8577361
GERMANY                   E-mail: Ralf@orle.de (PGP available)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
