From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 10:07:31 +0200
Message-ID: <20090716080731.GB8046@one.firstfloor.org>
References: <1247643512.26272.74.camel@rzhang-dt> <87ocrm6xeq.fsf@basil.nowhere.org> <1247710483.26272.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:60245 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZGPIHe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 04:07:34 -0400
Content-Disposition: inline
In-Reply-To: <1247710483.26272.170.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, arjan@linux.intel.com, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Thu, Jul 16, 2009 at 10:14:43AM +0800, Zhang Rui wrote:
> On Wed, 2009-07-15 at 18:41 +0800, Andi Kleen wrote:
> > Zhang Rui <rui.zhang@intel.com> writes:
> > >
> > > Currently, in order to make sure that it won't bring any side eff=
ects,
> > > I only convert the ACPI battery and i8042 to use this framework, =
which reduces
> > > 0.5s+ S3 time(suspend time plus resume time)=EF=BB=BF, from 7.0s =
to less than 6.5s.
> >=20
> > 10.5s+ was intended I guess?
> >=20
> what do you mean?

I am confused by you writing

"reduces <small number> from <much larger number> to <still larger numb=
er>"

So I assumed you dropped a decimal on <small number>


>=20
> the kernel device suspend time is reduced from 3.2s to 2.8s after
> applying this patch set in my test box.
> And I get more optimistic numbers on another laptop, an Eeepc 901,
> from about 2s to 1.6s. And the shutdown time is also reduced 0.4s.


I think I am still confused by your numbers.

How do the 0.5s and the 7.0s relate?

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
