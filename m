From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/16] Thermal: Make Thermal trip points writeable
Date: Mon, 23 Jul 2012 12:25:29 +0200
Message-ID: <201207231225.29376.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <201207192227.13357.rjw@sisk.pl> <1343031745.1682.328.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:52405 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GWKTo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jul 2012 06:19:44 -0400
In-Reply-To: <1343031745.1682.328.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

On Monday, July 23, 2012, Zhang Rui wrote:
> On =E5=9B=9B, 2012-07-19 at 22:27 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 19, 2012, Zhang Rui wrote:
> > > From: Durgadoss R <dugardoss.r@intel.com>
[...]
> > >  	if (trips > THERMAL_MAX_TRIPS || trips < 0)
> > >  		return ERR_PTR(-EINVAL);
> > > =20
> > > +	if (flag >> trips)
> > > +		return ERR_PTR(-EINVAL);
> >=20
> > I'm not sure if this check is necessary.  Does it actually matter i=
s someone
> > passes ones in the unused bit positions?
> >=20
> I do not think we can trust this value if the caller even wants to se=
t
> writable mask for a non-exist trip point.

OK, so perhaps we can merge the two conditionals into one?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
