From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPICA: Silent warnings about empty body in if/else
 statement
Date: Mon, 07 Oct 2013 19:08:00 +0200
Message-ID: <1381165680.4653.0.camel@chaos.site>
References: <20131007114501.1519f7dd@endymion.delvare>
	 <1618603.cKWE5JWKoC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab3JGRI5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Oct 2013 13:08:57 -0400
In-Reply-To: <1618603.cKWE5JWKoC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>

Le Monday 07 October 2013 =C3=A0 14:11 +0200, Rafael J. Wysocki a =C3=A9=
crit :
> On Monday, October 07, 2013 11:45:01 AM Jean Delvare wrote:
> > When ACPI debugging is disabled, I see warnings like this one:
> >=20
> > drivers/i2c/busses/i2c-scmi.c: In function "acpi_smbus_cmi_add_cap"=
:
> > drivers/i2c/busses/i2c-scmi.c:328:39: warning: suggest braces aroun=
d empty body in an "else" statement [-Wempty-body]
> > drivers/i2c/busses/i2c-scmi.c:338:12: warning: suggest braces aroun=
d empty body in an "else" statement [-Wempty-body]
> >=20
> > It is caused by ACPI_DEBUG_PRINT (or other similar macros) to resol=
ve
> > to nothing. Make them resolve to the classic "do {} while (0)" cons=
truct
> > instead when the compiler likes that, to silent all such warnings.
>=20
> The rule is that ACPICA patches need to go via upstream ACPICA, so I =
CCed
> the ACPICA maintainers.

Thanks Rafael. Maybe MAINTAINERS should be adjusted accordingly.
Contributors can't guess.


Thanks,
--=20
Jean Delvare
Suse L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
