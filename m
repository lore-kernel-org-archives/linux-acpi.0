From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Wed, 20 Feb 2013 10:21:53 +0800
Message-ID: <1361326913.7859.41.camel@liguang.fnst.cn.fujitsu.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com>
	 <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
	 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:10356 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933999Ab3BTCVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 21:21:46 -0500
In-Reply-To: <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

=E5=9C=A8 2013-02-19=E4=BA=8C=E7=9A=84 18:08 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 20 Feb 2013, li guang wrote:
>=20
> > > > This doesn't apply to Linus' tree nor does it apply to linux-ne=
xt.  Which=20
> > > > tree are you basing this on?
> > >=20
> > > I did based on linux-next,=20
> > > but it seems without commit 479a99a8e510c8839e0d3d3de8391f8bc61b9=
760
> > > which you may want to see.
> > > let me see why it missed.
> >=20
> > I pulled latest for linux-next
> > and can apply my patches smoothly.
> >=20
>=20
> No, it doesn't.  From next-20130219, you're missing at least two patc=
hes:
>=20
> 3795e4893203 ("acpi, memory-hotplug: extend movablemem_map ranges to =
the end of node")
> 9a561f4dfd70 ("acpi, memory-hotplug: support getting hotplug info fro=
m SRAT")
>=20
> I'm trying to be patient in reviewing your patches, but please double=
=20
> check your work.

I have to say my latest pull has these commit, and can apply
successfully.
really don't know why you can't apply.


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
