From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 1/4] acpi: move x86/mm/srat.c to
 x86/kernel/acpi/srat.c
Date: Tue, 05 Feb 2013 13:45:02 +0800
Message-ID: <1360043102.4449.12.camel@liguang.fnst.cn.fujitsu.com>
References: <1360031838-26898-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <1360031838-26898-2-git-send-email-lig.fnst@cn.fujitsu.com>
	 <alpine.DEB.2.02.1302042131400.31498@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1302042131400.31498@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2013-02-04=E4=B8=80=E7=9A=84 21:35 -0800=EF=BC=8CDavid Rientj=
es=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, 5 Feb 2013, liguang wrote:
>=20
> > srat table should present only on acpi domain,
> > seems mm/ is not the right place for it.
> >=20
> > Reviewed-by: David Rientjes <rientjes@google.com>
>=20
> I certainly didn't review this, please read=20
> Documentation/SubmittingPatches.
>=20
> > Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
>=20
> Couple of issues with this:
>=20
>  - it doesn't include your followup change "acpi: change Makefile for
>    srat.c building" which is required for this to build, please fold =
it in=20
>    and repost,
>=20
>  - there is whitespace damage, we use tabs for indentation in Makefil=
es,
>=20
>  - you're basing your patches on Linus' tree when arch/x86/mm/srat ha=
s
>    changed in linux-next (15 insertions(+), 14 deletions(-)), please=20
>    rebase this on the linux-next tree at git.kernel.org.
>=20
> Otherwise, looks good.

OK, I'll rebase on linux-next.
Thanks!
