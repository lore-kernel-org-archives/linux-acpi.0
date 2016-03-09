From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 0/4] Support persistent memory as reserved type in
 e820/EFI
Date: Wed, 09 Mar 2016 13:34:51 -0700
Message-ID: <1457555691.15454.534.camel@hpe.com>
References: <1457552817-13938-1-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4jxyDSQNC6wQDCOH3OLa-gUdeiOpKo1Pq88Av1joZqUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:49363 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbcCITmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2016 14:42:15 -0500
In-Reply-To: <CAPcyv4jxyDSQNC6wQDCOH3OLa-gUdeiOpKo1Pq88Av1joZqUtw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2016-03-09 at 11:30 -0800, Dan Williams wrote:
> On Wed, Mar 9, 2016 at 11:46 AM, Toshi Kani <toshi.kani@hpe.com> wrot=
e:
=C2=A0:
> > Toshi Kani (4):
> > =C2=A01/4 resource: Change __request_region to inherit from immedia=
te parent
> > =C2=A02/4 resource: Add remove_resource interface
> > =C2=A03/4 resource: Export insert_resource and remove_resource
> > =C2=A04/4 ACPI: Change NFIT driver to insert new resource
> >=20
> > ---
> > =C2=A0drivers/acpi/nfit.c=C2=A0=C2=A0=C2=A0=C2=A0| 48 +++++++++++++=
+++++++++++++++++++++++++++
> > =C2=A0include/linux/ioport.h |=C2=A0=C2=A01 +
> > =C2=A0kernel/resource.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 60
> > +++++++++++++++++++++++++++++++++++++++++++-------
> > =C2=A03 files changed, 101 insertions(+), 8 deletions(-)
>=20
> Hi Toshi, this looks good to me and passes my testing.
>=20
> I'll give it until the end of the day if there is any more feedback
> and otherwise merge it into the pending libnvdimm updates for 4.6.

Great! Thanks Dan!
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
