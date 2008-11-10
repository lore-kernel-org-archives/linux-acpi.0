From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Namespace lookup failure error on QuadCore E5420
Date: Mon, 10 Nov 2008 09:32:49 +0800
Message-ID: <1226280769.15014.21.camel@rzhang-dt>
References: <20081109134804.GA32033@frix.fri.uniza.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65503 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755447AbYKJBe7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Nov 2008 20:34:59 -0500
In-Reply-To: <20081109134804.GA32033@frix.fri.uniza.sk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Strazovec <bubak@frix.fri.uniza.sk>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2008-11-09 at 21:48 +0800, Peter Strazovec wrote:
> I have problem with Namespace lookup failure error on E5420.=20
> ( ACPI Error (psargs-0358): [CS03] Namespace lookup failure, AE_NOT_F=
OUND )
> Thus acpi not functional (cpufrequ via p-states, etc...).
>=20
ACPI is enabled on your system, except the cpu c-state.

=46irst please download the latest pmtools at
http://www.lesswatts.org/projects/acpi/utilities.php

and then please run
"./acpidump > acpidump.log"
"./acpidump --addr 0xcfe5f800 --length 0xd8 > cpu0cst"
=EF=BB=BF"./acpidump --addr 0xcfe5f900 --length 0xd8 > cpu1cst"
=EF=BB=BF"./acpidump --addr 0xcfe5fa00 --length 0xd8 > cpu2cst"
=EF=BB=BF"./acpidump --addr 0xcfe5fb00 --length 0xd8 > cpu3cst"
and attach all these files.

Btw, how do you know p-state is not functional?
the p-state sysfs I/F (/sys/devices/system/cpu/cpuX/cpufreq/)doesn't
work for you?

thanks,
rui

> Does anyone know about some patch or some hint?
>=20
> CONFIG_ACPI_DEBUG=3Dy, CONFIG_ACPI_DEBUG_FUNC_TRACE=3Dy,
> dmesg, interrupts and cpuinfo attached.
>=20
> thanks
> Pete

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
