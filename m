From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] lib/uuid.c: eliminate uuid_[bl]e_index arrays
Date: Sun, 05 Jun 2016 17:19:16 +0300
Message-ID: <1465136356.1767.55.camel@linux.intel.com>
References: <20160604051453.3758.qmail@ns.sciencehorizons.net>
	 <1465057748.11800.53.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12756 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcFEOSC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Jun 2016 10:18:02 -0400
In-Reply-To: <1465057748.11800.53.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, George Spelvin <linux@sciencehorizons.net>
Cc: bjorn@mork.no, linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk, rv@rasmusvillemoes.dk, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org

On Sat, 2016-06-04 at 09:29 -0700, Joe Perches wrote:
> (adding acpi folks)


>=20
> Trivially, acpi defines this but doesn't seem to use it.
>=20
> include/acpi/acconfig.h:#define UUID_STRING_LENGTH=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A036=C2=A0=C2=A0/*
> Total length of a UUID string */
>=20
> And Ingo commented last month:
> https://lkml.org/lkml/2016/4/29/69
>=20
> Maybe this __uuid_to_bin function should be made public and
> the acpi version in drivers/acpi/acpica/utuuid.c should be
> removed.

Looks like you missed my first version of (other) series.
http://www.spinics.net/lists/linux-api/msg17518.html


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
