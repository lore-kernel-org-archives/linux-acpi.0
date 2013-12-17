From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 05/11] drivers: acpi: Include appropriate header file in
 utstate.c
Date: Tue, 17 Dec 2013 12:25:18 -0800
Message-ID: <20131217202518.GA17790@jtriplet-mobl1>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
 <c8f6f6fbcd7de593a726d091f5d0f6a245f6e0f7.1387271324.git.rashika.kheria@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37C7B99F5@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59698 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3LQUZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 15:25:28 -0500
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7B99F5@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Rashika Kheria <rashika.kheria@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, Dec 17, 2013 at 05:35:46PM +0000, Moore, Robert wrote:
> I'm not sure what version of ACPICA you are looking at, but in the ma=
ster git tree for ACPICA, the file accommon.h includes "acutils.h".

This is the version in the latest git tree for the Linux kernel.

- Josh Triplett

> > -----Original Message-----
> > From: Rashika Kheria [mailto:rashika.kheria@gmail.com]
> > Sent: Tuesday, December 17, 2013 1:22 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown; linux-
> > acpi@vger.kernel.org; josh@joshtriplett.org; devel@acpica.org
> > Subject: [PATCH 05/11] drivers: acpi: Include appropriate header fi=
le in
> > utstate.c
> >=20
> > Include appropriate header file acutils.h in acpica/utstate.c becau=
se
> > function acpi_ut_create_pkg_state_and_push() has its prototype decl=
aration
> > in acutils.h. Also, encloses the function in acpica/utstate.c in if=
def
> > condition of ACPI_FUTURE_USAGE.
> >=20
> > This eliminates the following warning in utstate.c:
> > drivers/acpi/acpica/utstate.c:64:1: warning: no previous prototype =
for
> > =E2=80=98acpi_ut_create_pkg_state_and_push=E2=80=99 [-Wmissing-prot=
otypes]
> >=20
> > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> > Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> >  drivers/acpi/acpica/utstate.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/ut=
state.c
> > index 03c4c2f..0920d23 100644
> > --- a/drivers/acpi/acpica/utstate.c
> > +++ b/drivers/acpi/acpica/utstate.c
> > @@ -43,6 +43,7 @@
> >=20
> >  #include <acpi/acpi.h>
> >  #include "accommon.h"
> > +#include "acutils.h"
> >=20
> >  #define _COMPONENT          ACPI_UTILITIES
> >  ACPI_MODULE_NAME("utstate")
> > @@ -60,6 +61,7 @@ ACPI_MODULE_NAME("utstate")
> >   * DESCRIPTION: Create a new state and push it
> >   *
> >=20
> > *******************************************************************=
*******
> > ****/
> > +#ifdef  ACPI_FUTURE_USAGE
> >  acpi_status
> >  acpi_ut_create_pkg_state_and_push(void *internal_object,
> >  				  void *external_object,
> > @@ -79,6 +81,7 @@ acpi_ut_create_pkg_state_and_push(void *internal_=
object,
> >  	acpi_ut_push_generic_state(state_list, state);
> >  	return (AE_OK);
> >  }
> > +#endif
> >=20
> >=20
> > /******************************************************************=
*******
> > ******
> >   *
> > --
> > 1.7.9.5
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
