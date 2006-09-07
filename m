From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: 2.6.18-rc5-mm1
Date: Thu, 07 Sep 2006 10:33:14 -0700
Message-ID: <1157650394.5653.21.camel@keithlap>
References: <20060901015818.42767813.akpm@osdl.org>
	 <44F86282.9010809@gmail.com> <200609051016.40468.bjorn.helgaas@hp.com>
	 <44FEFD6F.4020203@gmail.com>  <20060906200824.4f74f221.akpm@osdl.org>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:23470 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751779AbWIGRdS
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Sep 2006 13:33:18 -0400
In-Reply-To: <20060906200824.4f74f221.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Wed, 2006-09-06 at 20:08 -0700, Andrew Morton wrote:
> On Wed, 06 Sep 2006 18:55:11 +0200
> Maciej Rutecki <maciej.rutecki@gmail.com> wrote:
>=20
> > Bjorn Helgaas napisa=C5=82(a):
> > >=20
> > > This ACPI "unknown exception code" problem is the same one report=
ed here:
> > >   http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg028=
73.html
> > >=20
> > > Basically, we just need to revert this:
> > >   http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/=
2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboar=
d-fix.patch
> > >=20
> > Thanks it works.
> >=20
>=20
> So...  should I drop that patch?

Yes please drop this patch. =20
  I dislike breaking my boxes functionality without a consensus for the
right fix is but it appears to be breaking others.  The discussion abou=
t
what the right fix is ongoing with no definitive direction. At a minimu=
m
this patch will need to be updated.=20

Thanks,
  Keith=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
