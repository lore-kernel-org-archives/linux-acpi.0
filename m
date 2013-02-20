From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Wed, 20 Feb 2013 09:39:15 +0800
Message-ID: <1361324355.7859.35.camel@liguang.fnst.cn.fujitsu.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360894992-14818-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:44764 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3BTBjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2013 20:39:09 -0500
In-Reply-To: <alpine.DEB.2.02.1302191320410.6322@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com

=E5=9C=A8 2013-02-19=E4=BA=8C=E7=9A=84 13:21 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, 15 Feb 2013, liguang wrote:
>=20
> > srat table should present only on acpi domain,
> > seems mm/ is not the right place for it.
> >=20
> > Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
>=20
> This doesn't apply to Linus' tree nor does it apply to linux-next.  W=
hich=20
> tree are you basing this on?

I did based on linux-next,=20
but it seems without commit 479a99a8e510c8839e0d3d3de8391f8bc61b9760
which you may want to see.
let me see why it missed.



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
