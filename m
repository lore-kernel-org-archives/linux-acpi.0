From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Thu, 14 Nov 2013 13:29:56 +0100
Message-ID: <20131114122956.GE13376@pd.tnic>
References: <1384135666-1929-1-git-send-email-gong.chen@linux.intel.com>
 <20131114014924.GA17790@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:32931 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab3KNMaX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Nov 2013 07:30:23 -0500
Content-Disposition: inline
In-Reply-To: <20131114014924.GA17790@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Wed, Nov 13, 2013 at 08:49:24PM -0500, Chen, Gong wrote:
> On Sun, Nov 10, 2013 at 09:07:46PM -0500, Chen, Gong wrote:
> > Date: Sun, 10 Nov 2013 21:07:46 -0500
> > From: "Chen, Gong" <gong.chen@linux.intel.com>
> > To: tony.luck@intel.com, bp@alien8.de
> > Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel=
=2Ecom>
> > Subject: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for=
 APEI
> > X-Mailer: git-send-email 1.8.4.rc3
> >=20
> > We ever used *memcpy* to avoid access alignment issue between
> > firmware and OS. Now we can use a better and standard way
> > to avoid this issue. In the meanwhile, simplify some variable names
> > to avoid the limit of 80 characters per line and use structure
> > assignment instead of unnecessary memcpy. No functional changes.
> >=20
> > v2->v1: Make description information clearer.
> >=20
> Any comments? Boris/Tony?

I get this when building here:

drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_check_gar=E2=80=
=99:
drivers/acpi/apei/apei-base.c:571:8: warning: assignment makes pointer =
from integer without a cast [enabled by default]
  paddr =3D get_unaligned(&reg->address);
        ^
drivers/acpi/apei/apei-base.c: In function =E2=80=98collect_res_callbac=
k=E2=80=99:
drivers/acpi/apei/apei-base.c:716:3: warning: =E2=80=98paddr=E2=80=99 m=
ay be used uninitialized in this function [-Wmaybe-uninitialized]
   return apei_res_add(&resources->iomem, paddr,
   ^
drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_read=E2=80=99:
drivers/acpi/apei/apei-base.c:645:10: warning: =E2=80=98address=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
   status =3D acpi_os_read_memory((acpi_physical_address) address,
          ^
drivers/acpi/apei/apei-base.c: In function =E2=80=98apei_write=E2=80=99=
:
drivers/acpi/apei/apei-base.c:678:10: warning: =E2=80=98address=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
   status =3D acpi_os_write_memory((acpi_physical_address) address,

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
