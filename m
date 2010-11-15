From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: No thermal information on Toshiba Satellite L670
Date: Mon, 15 Nov 2010 08:21:51 +0800
Message-ID: <1289780511.8148.1797.camel@rui>
References: <4CDD5F07.9010102@tvcablenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53180 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab0KOAUU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Nov 2010 19:20:20 -0500
In-Reply-To: <4CDD5F07.9010102@tvcablenet.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Fran=E7ois?= Valenduc <francois.valenduc@tvcablenet.be>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2010-11-12 at 23:36 +0800, Fran=C3=A7ois Valenduc wrote:
> Hello everybody,
>=20
> In don't know if it's the right place to post the following problem b=
ut
> I have a Toshiba Satellite L670 laptop and I can't get any temperatur=
e
> information. The /sys/class/thermal directory contains the files
> cooling_device0 to 4, but not "thermal_zone". I don't know if i'ts
> related but in the output of dmesg |
> grep ACPI, I found the following error:
>=20
> [    0.465758] ACPI: EC: Look up EC in DSDT
> [    0.466331] ACPI Error: No handler for Region [ERAM]
> (ffff8800b6c2dcf0) [EmbeddedControl] (20100702/evregion-369)
> [    0.466471] ACPI Error: Region EmbeddedControl(0x3) has no handler
> (20100702/exfldio-293)
> [    0.466610] ACPI Error (psparse-0537): Method parse/execution fail=
ed
> [\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff8800b6c31208), AE_NOT_EXIST
>=20
what's the kernel version you're running?
does the problem also exists in 2.6.36 or 2.6.37-rc kernel?

please attach the FULL dmesg output after boot and the acpidump output
of your laptop.

thanks,
rui

> The full result is in the attached file. Do you need any more
> information ? I am not subscribed to this list so please answer also =
to
> my e-mail adress.
>=20
> Thanks in advance for your help,
> Fran=C3=A7ois Valenduc
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
