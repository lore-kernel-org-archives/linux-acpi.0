From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Thu, 24 Mar 2016 04:00:25 -0700
Message-ID: <1458817225.1762.13.camel@perches.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
	 <1458783966.1762.6.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:43881 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755309AbcCXLAa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 07:00:30 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2016-03-24 at 06:19 +0000, Zheng, Lv wrote:
> From: Joe Perches [mailto:joe@perches.com]
> > Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for=
 20160212
> > release
> >=20
> > On Thu, 2016-03-24 at 09:38 +0800, Lv Zheng wrote:
> > >=20
> > > The patch reduces source code differences between the Linux kerne=
l and the
> > > ACPICA upstream so that the linuxized ACPICA 20160212 release can=
 be
> > > applied with reduced human intervention.
> > In the very first patch fragment:
> > > diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/h=
wregs.c
> > []
> > > @@ -152,7 +152,7 @@ acpi_hw_validate_register(struct
> > acpi_generic_address *reg,
[]
> > > -acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address=
 *reg)
> > > +acpi_status acpi_hw_read(u32 *value, struct acpi_generic_address=
 * reg)
> > The second argument * style appears the opposite of normal style
> > and a different style than the first argument * style.
> [Lv Zheng]=C2=A0
> The file is drivers/acpi/acpica/hwregs.c, which is coming from ACPICA=
 upstream.
> So this is a result of "ACPICA release".
> In other words, this is a result of a "process".
> In order to fix this, things need to be done in "ACPICA release scrip=
ts".
> Which should be done in https://github.com/acpica/acpica/blob/master/=
generate/linux/libacpica.sh.
> Otherwise, "ACPICA release" process will require human intervention.
>=20
> So please leave this patch fragment as is.
> It will be automatically fixed if the "ACPICA release" process is fix=
ed.
> And if you don't leave this fragment as is, the "ACPICA release" proc=
ess will get hurt.
[]
> please ignore "process" issues.
> I need them to be wrong in order not to modify every "process" genera=
ted patches manually.

So why not fix the process script first?

Maybe add something like:

$ grep -E "^typedef\s+\w+\s*\*?\s*acpi_\w+" include/acpi/actypes.h | \
  grep -Eoh "\bacpi_\w+"

to the acpi_types variable in the lindent_single function

> You can find many such kind of indent issues in drivers/acpi/acpica, =
include/acpi, tools/power/acpi.
> They are there for good reasons.
> I'll cleanup such issues from "ACPICA release" process.

Any idea when?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
