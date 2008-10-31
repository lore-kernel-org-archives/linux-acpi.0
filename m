From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Build error with latest kernel
Date: Fri, 31 Oct 2008 11:42:04 +0800
Message-ID: <1225424524.2665.22.camel@rzhang-dt>
References: <1225377756.3689.5.camel@localhost.localdomain>
	 <1225421122.2665.18.camel@rzhang-dt>
	 <alpine.DEB.0.82.0810310258360.21357@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45440 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbYJaDnA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 23:43:00 -0400
In-Reply-To: <alpine.DEB.0.82.0810310258360.21357@skynet.skynet.ie>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Airlie <airlied@linux.ie>
Cc: Steven Whitehouse <swhiteho@redhat.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mjg@redhat.com" <mjg@redhat.com>

On Fri, 2008-10-31 at 10:58 +0800, Dave Airlie wrote:
> > >=20
> > > There is a build error with the attached config on the latest ups=
tream
> > > Linus kernel.
> > >=20
> > >   CC [M]  drivers/gpu/drm/i915/i915_suspend.o
> > > drivers/gpu/drm/i915/i915_opregion.c: In function =E2=80=98intel_=
opregion_init=E2=80=99:
> > > drivers/gpu/drm/i915/i915_opregion.c:340: error: implicit declara=
tion of
> > > function =E2=80=98register_acpi_notifier=E2=80=99
> > > drivers/gpu/drm/i915/i915_opregion.c: In function =E2=80=98intel_=
opregion_free=E2=80=99:
> > > drivers/gpu/drm/i915/i915_opregion.c:361: error: implicit declara=
tion of
> > > function =E2=80=98unregister_acpi_notifier=E2=80=99
> > > make[4]: *** [drivers/gpu/drm/i915/i915_opregion.o] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > >=20
> > > Looks like the symbols are not defined when ACPI is not configure=
d.
> > >=20
> > Yes, you're right.
> > IGD OpeRegion depends on ACPI.
> > I think we need to introduce a new kernel config option for
> > IGD OpRegion support.
> >=20
> > cc matthew.
>=20
> The fix is queued for Linus already.
>=20
oops, I missed that email thread.
thanks for the quick fix. :)

-rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
