From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Wed, 20 Feb 2013 15:05:26 +0800
Message-ID: <1361343926.7859.53.camel@liguang.fnst.cn.fujitsu.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com>
	 <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
	 <1361325113.7859.37.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191802490.14999@chino.kir.corp.google.com>
	 <1361326913.7859.41.camel@liguang.fnst.cn.fujitsu.com>
	 <1361327201.7859.44.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191902470.18957@chino.kir.corp.google.com>
	 <1361330196.7859.51.camel@liguang.fnst.cn.fujitsu.com>
	 <alpine.DEB.2.02.1302192254440.27407@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:45773 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756431Ab3BTHFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2013 02:05:19 -0500
In-Reply-To: <alpine.DEB.2.02.1302192254440.27407@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

=E5=9C=A8 2013-02-19=E4=BA=8C=E7=9A=84 23:00 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 20 Feb 2013, li guang wrote:
>=20
> > Yes, I know there's no new changes in my patch as I said before(not
> > based on lasted), but as I try to apply my patch(1/4), it will do
> > the right work to move current srat.c from arch/x86/mm/ to
> > arch/x86/kernel/acpi/ regardless of what I based is not latest.
> >=20
>=20
> Sorry, but that makes no sense.  Your patch cannot be used cleanly if=
=20
> there have been subsequent changes to a hunk prior to applying it -- =
in=20
> this case the hunk would be the entire file since you're removing it.
>=20
> These patches would also be pushed by the x86 maintainers, who are no=
t=20
> cc'd on this patch, and I think it would be unfair to ask them to mak=
e up=20
> for your inability to generate a bleeding edge patch with linux-next.=
  The=20
> changes already cited in this thread have been in linux-next for almo=
st=20
> two weeks, yet you refuse to rebase on top of them.

OK, I'd like to rebase,
Thanks!


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
