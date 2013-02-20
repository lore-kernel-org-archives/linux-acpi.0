From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Wed, 20 Feb 2013 11:16:36 +0800
Message-ID: <1361330196.7859.51.camel@liguang.fnst.cn.fujitsu.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com>
	 <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
	 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com>
	 <1361326913.7859.41.camel@liguang.fnst.cn.fujitsu.com>
	 <1361327201.7859.44.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191902470.18957@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:31573 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934185Ab3BTDQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 22:16:28 -0500
In-Reply-To: <alpine.DEB.2.02.1302191902470.18957@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

=E5=9C=A8 2013-02-19=E4=BA=8C=E7=9A=84 19:04 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 20 Feb 2013, li guang wrote:
>=20
> > > > No, it doesn't.  From next-20130219, you're missing at least tw=
o patches:
> > > >=20
> > > > 3795e4893203 ("acpi, memory-hotplug: extend movablemem_map rang=
es to the end of node")
> > > > 9a561f4dfd70 ("acpi, memory-hotplug: support getting hotplug in=
fo from SRAT")
> > > >=20
> > > > I'm trying to be patient in reviewing your patches, but please =
double=20
> > > > check your work.
> > >=20
> > > I have to say my latest pull has these commit, and can apply
> > > successfully.
> > > really don't know why you can't apply.
>=20
> You should not be pulling linux-next, you should be fetching.
> >=20
> > I mean although my patches did not based on latest linux-next(miss
> > several commits), but as I can see, they can be applied to latest
> > linux-next (tag next-20130218) successfully.
> >=20
>=20
> next-20130218 is not the latest linux-next as I've already said.  Do =
this:=20
> go to=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next-history.g=
it;a=3Dblob_plain;f=3Darch/x86/mm/srat.c;hb=3DHEAD=20
> and search for handle_movablemem().  That's one of the functions adde=
d in=20
> one of the commits I mentioned and was from February.  Now search you=
r=20
> patch for handle_movablemem().  See a problem?

Yes, I know there's no new changes in my patch as I said before(not
based on lasted), but as I try to apply my patch(1/4), it will do
the right work to move current srat.c from arch/x86/mm/ to
arch/x86/kernel/acpi/ regardless of what I based is not latest.



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
