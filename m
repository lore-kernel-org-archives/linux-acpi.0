From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Buggy DSDT on Dell Latitude E5400
Date: Mon, 15 Dec 2008 09:22:06 +0800
Message-ID: <1229304126.2993.22.camel@rzhang-dt>
References: <20081214022125.GA29259@zen>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44176 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbYLOBXJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Dec 2008 20:23:09 -0500
In-Reply-To: <20081214022125.GA29259@zen>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@ens-lyon.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, sebatien,

please file a bug report at bugzilla.kernel.org
and attach the output of acpidump there.
BTW: you can get the acpidump using the latest
pmtools at:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
rui

On Sun, 2008-12-14 at 10:21 +0800, S=C3=A9bastien Hinderer wrote:
> Dear all,
>=20
> On a recently bought Dell Latitude E5400 laptop with Debian unstable
> installed, the fan is constantly working.
> This happens although the temperature reported by acpi -v is around 3=
0
> degrees Celcius, and although top reports a CPU usage around 1%.
>=20
> Moreover, when the installed Windows XP is started and the machine is
> left untouched, the fan remains turned off all the time.
>=20
> Are these symptoms the consequence of a buggy DSDT which Windows
> overrides ?=20
> In that case, how can the problem be fixed ?
> Is it necessary to disassemble and study the DSDT, or is it possible =
to
> somehow fetch the working one presumably used by Windows XP ?
>=20
> Any help / suggestion warmly appreciated.
> Kind regards,
> Sebastien.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
