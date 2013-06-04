From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] xen: remove bm_rld_set of xen_processor_flags
Date: Tue, 04 Jun 2013 16:19:27 +0800
Message-ID: <1370333967.17798.60.camel@liguang.fnst.cn.fujitsu.com>
References: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1370333128-11412-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <51ADBDC402000078000DAF36@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:1118 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab3FDIUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jun 2013 04:20:23 -0400
In-Reply-To: <51ADBDC402000078000DAF36@nat28.tlf.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jeremy Fitzhardinge <jeremy@goop.org>, Liu Jinsong <jinsong.liu@intel.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

=E5=9C=A8 2013-06-04=E4=BA=8C=E7=9A=84 09:13 +0100=EF=BC=8CJan Beulich=E5=
=86=99=E9=81=93=EF=BC=9A
> >>> On 04.06.13 at 10:05, liguang <lig.fnst@cn.fujitsu.com> wrote:
> > bm_rld_set seems obsolete now
> >=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> > ---
> >  include/xen/interface/platform.h |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/include/xen/interface/platform.h=20
> > b/include/xen/interface/platform.h
> > index c57d5f6..7ffff33 100644
> > --- a/include/xen/interface/platform.h
> > +++ b/include/xen/interface/platform.h
> > @@ -240,7 +240,6 @@ struct xen_processor_flags {
> >  	uint32_t bm_check:1;
> >  	uint32_t has_cst:1;
> >  	uint32_t power_setup_done:1;
> > -	uint32_t bm_rld_set:1;
> >  };
> > =20
> >  struct xen_processor_power {
>=20
> Any such patch would need to be submitted against the master copy
> of the header (in the Xen repo), and by recognizing that you'd also
> notice that this is part of a public ABI, and hence can't be removed,
> but at best can be documented as obsolete. Of course you'd first
> need to check whether the hypervisor makes any use of that bit
> when passed down from Dom0.
>=20

Right, this patch mostly likes a reminder,
hoping someone will try it and verify it's fail or OK,
since I can't test this for now.

Sorry and Thanks!


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
