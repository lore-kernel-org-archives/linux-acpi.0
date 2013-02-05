From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/5] acpi: move x86/mm/srat.c to x86/kernel/acpi/srat.c
Date: Tue, 05 Feb 2013 09:16:57 +0800
Message-ID: <1360027017.4449.9.camel@liguang.fnst.cn.fujitsu.com>
References: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1359967426-32629-4-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302041142550.10378@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:41005 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753769Ab3BEBRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2013 20:17:14 -0500
In-Reply-To: <alpine.DEB.2.02.1302041142550.10378@chino.kir.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org

=E5=9C=A8 2013-02-04=E4=B8=80=E7=9A=84 11:44 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 4 Feb 2013, liguang wrote:
>=20
> > srat table should present only on acpi domain,
> > seems mm/ is not the right place for it.
> >=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> > ---
> >  arch/x86/kernel/acpi/Makefile |    1 +
> >  arch/x86/mm/Makefile          |    1 -
> >  arch/x86/mm/srat.c            |  191 -----------------------------=
------------
> >  3 files changed, 1 insertions(+), 192 deletions(-)
> >  delete mode 100644 arch/x86/mm/srat.c
> >=20
>=20
> I was excited for a moment because this would have been one great cle=
anup,=20
> but you never readded the code to arch/x86/kernel/acpi.  (You probabl=
y=20
> need to do "git add <newfile>" before generating the patch file.)  I =
do=20
> like the idea of moving it, though, if it's build tested thoroughly.

OK, will git add it.


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
