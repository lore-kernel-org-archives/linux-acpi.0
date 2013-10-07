From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: Silent warnings about empty body in if/else statement
Date: Mon, 07 Oct 2013 21:39:40 +0200
Message-ID: <1744369.IiGJm7k9Ig@vostro.rjw.lan>
References: <20131007114501.1519f7dd@endymion.delvare> <1618603.cKWE5JWKoC@vostro.rjw.lan> <1381165680.4653.0.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50729 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755316Ab3JGT2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Oct 2013 15:28:01 -0400
In-Reply-To: <1381165680.4653.0.camel@chaos.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Monday, October 07, 2013 07:08:00 PM Jean Delvare wrote:
> Le Monday 07 October 2013 =C3=A0 14:11 +0200, Rafael J. Wysocki a =C3=
=A9crit :
> > On Monday, October 07, 2013 11:45:01 AM Jean Delvare wrote:
> > > When ACPI debugging is disabled, I see warnings like this one:
> > >=20
> > > drivers/i2c/busses/i2c-scmi.c: In function "acpi_smbus_cmi_add_ca=
p":
> > > drivers/i2c/busses/i2c-scmi.c:328:39: warning: suggest braces aro=
und empty body in an "else" statement [-Wempty-body]
> > > drivers/i2c/busses/i2c-scmi.c:338:12: warning: suggest braces aro=
und empty body in an "else" statement [-Wempty-body]
> > >=20
> > > It is caused by ACPI_DEBUG_PRINT (or other similar macros) to res=
olve
> > > to nothing. Make them resolve to the classic "do {} while (0)" co=
nstruct
> > > instead when the compiler likes that, to silent all such warnings=
=2E
> >=20
> > The rule is that ACPICA patches need to go via upstream ACPICA, so =
I CCed
> > the ACPICA maintainers.
>=20
> Thanks Rafael. Maybe MAINTAINERS should be adjusted accordingly.
> Contributors can't guess.

That actually is a good idea.  I think we'll do that.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
