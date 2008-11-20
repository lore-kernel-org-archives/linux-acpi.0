From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return Package
	type mismatch at index 9
Date: Thu, 20 Nov 2008 08:59:48 +0800
Message-ID: <1227142788.15014.260.camel@rzhang-dt>
References: <492493FD.7020501@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57003 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbYKTBAo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Nov 2008 20:00:44 -0500
In-Reply-To: <492493FD.7020501@freemail.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Please attach the acpidump output.
you can use the latest pmtools here:
http://www.lesswatts.org/downloads/#acpi

thanks,
rui

On Thu, 2008-11-20 at 06:32 +0800, N=C3=A9meth M=C3=A1rton wrote:
> Hi,
>=20
> I am running Linux kernel 2.6.28-rc5. I get the following warning mes=
sage
> during boot in dmesg:
>=20
> [   21.425678] ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return =
Package type mismatch at index 9 - found Buffer, expected String [20080=
926]
>=20
> What does it mean? Is it a serious problem?
>=20
> The laptop is a Clevo D410J. The dmesg attached.
>=20
> Regards,
>=20
> 	M=C3=A1rton N=C3=A9meth
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
