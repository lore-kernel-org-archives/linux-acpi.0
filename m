From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [rebased-again][PATCH 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 26 Feb 2013 09:01:04 +0800
Message-ID: <1361840464.2262.25.camel@liguang.fnst.cn.fujitsu.com>
References: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1361759917-5195-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302251450160.4488@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:9660 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757644Ab3BZBCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2013 20:02:01 -0500
In-Reply-To: <alpine.DEB.2.02.1302251450160.4488@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

=E5=9C=A8 2013-02-25=E4=B8=80=E7=9A=84 14:51 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 25 Feb 2013, liguang wrote:
>=20
> > srat table should present only on acpi domain,
> > seems mm/ is not the right place for it.
> >=20
> > Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
>=20
> You're still missing 01a178a94e8e ("acpi, memory-hotplug: support get=
ting=20
> hotplug info from SRAT") that was merged at the end of last week.  In=
stead=20
> of continuing to rebase perhaps it would be better at this point to a=
sk=20
> the x86 maintainers to just do the patch for you?

maybe I have to ask them to help generate this patch,
I pulled latest since 25th, Feb, and re-generate this patch,
and it did have the commit you've pointed out.
Thanks!

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
