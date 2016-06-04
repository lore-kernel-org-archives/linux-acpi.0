From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/2] lib/uuid.c: eliminate uuid_[bl]e_index arrays
Date: Sat, 04 Jun 2016 09:29:08 -0700
Message-ID: <1465057748.11800.53.camel@perches.com>
References: <20160604051453.3758.qmail@ns.sciencehorizons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160604051453.3758.qmail@ns.sciencehorizons.net>
Sender: linux-kernel-owner@vger.kernel.org
To: George Spelvin <linux@sciencehorizons.net>, andriy.shevchenko@linux.intel.com
Cc: bjorn@mork.no, linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk, rv@rasmusvillemoes.dk, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

(adding acpi folks)

On Sat, 2016-06-04 at 01:14 -0400, George Spelvin wrote:
> Both input and output code is simplified if we use a mapping from bin=
ary
> UUID index to ASCII UUID position.=A0=A0This lets us combine hyphen-s=
kipping
> and endian-swapping into one table.
>=20
> This significantly simplifies __uuid_to_bin(), which was using *two*
> lookup tables.

Seems sensible, thanks.

Trivially, acpi defines this but doesn't seem to use it.

include/acpi/acconfig.h:#define UUID_STRING_LENGTH=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A036=A0=A0/* Total length of a UUID string */

And Ingo commented last month:
https://lkml.org/lkml/2016/4/29/69

Maybe this __uuid_to_bin function should be made public and
the acpi version in drivers/acpi/acpica/utuuid.c should be
removed.
