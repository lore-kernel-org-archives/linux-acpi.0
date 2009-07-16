From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 16:30:47 +0800
Message-ID: <1247733047.26272.199.camel@rzhang-dt>
References: <1247643512.26272.74.camel@rzhang-dt>
	 <87ocrm6xeq.fsf@basil.nowhere.org> <1247710483.26272.170.camel@rzhang-dt>
	 <20090716080731.GB8046@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52102 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbZGPI36 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 04:29:58 -0400
In-Reply-To: <20090716080731.GB8046@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Thu, 2009-07-16 at 16:07 +0800, Andi Kleen wrote:
> On Thu, Jul 16, 2009 at 10:14:43AM +0800, Zhang Rui wrote:
> > On Wed, 2009-07-15 at 18:41 +0800, Andi Kleen wrote:
> > > Zhang Rui <rui.zhang@intel.com> writes:
> > > >
> > > > Currently, in order to make sure that it won't bring any side e=
ffects,
> > > > I only convert the ACPI battery and i8042 to use this framework=
, which reduces
> > > > 0.5s+ S3 time(suspend time plus resume time)=C3=AF=C2=BB=C2=BF,=
 from 7.0s to less than 6.5s.

> > >=20
> > > 10.5s+ was intended I guess?
> > >=20
> > what do you mean?
>=20
> I am confused by you writing
>=20
> "reduces <small number> from <much larger number> to <still larger nu=
mber>"
>=20
> So I assumed you dropped a decimal on <small number>
>=20
sorry for my poor English.

I mean the total S3 time (including kernel suspend and kernel resume)
reduces more than 0.5 second.
it takes 7.0s without this patch set and now it takes only 6.5s.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
