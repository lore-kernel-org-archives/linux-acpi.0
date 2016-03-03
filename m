From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Thu, 03 Mar 2016 16:48:48 -0700
Message-ID: <1457048928.15454.117.camel@hpe.com>
References: <1456959056-12316-1-git-send-email-toshi.kani@hpe.com>
	 <1456959056-12316-4-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4iBg0fsaAM-fnHaDir6mosLM-gwr+VU_doTsYU6st-yyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:53885 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758374AbcCCW4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 17:56:07 -0500
In-Reply-To: <CAPcyv4iBg0fsaAM-fnHaDir6mosLM-gwr+VU_doTsYU6st-yyQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2016-03-03 at 14:45 -0800, Dan Williams wrote:
> On Wed, Mar 2, 2016 at 2:50 PM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
=C2=A0:
> >=20
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index effb6ee..b1a3394 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -1449,6 +1449,75 @@ void __devm_release_region(struct device *de=
v,
> > struct resource *parent,
> > =C2=A0EXPORT_SYMBOL(__devm_release_region);
> >=20
> > =C2=A0/*
> > + * Remove function for devm_insert_resource() and
> > devm_remove_resource().
> > + */
> > +static void devm_resource_remove(struct device *dev, void *ptr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource **r =3D =
ptr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0remove_resource(*r);
> > +}
> > +
>=20
> Maybe call this __devm_remove_resource?=C2=A0=C2=A0I think this makes=
 it clearer
> that it is a private helper function.=C2=A0=C2=A0I was initially conf=
used about
> the difference between devm_resource_remove and devm_remove_resource.

Will do. =C2=A0I followed the naming convention of devm_resource_releas=
e() in
the same file, but I agree that this is confusing.

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
