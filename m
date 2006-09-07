From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Wed, 6 Sep 2006 20:08:24 -0700
Message-ID: <20060906200824.4f74f221.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
	<44F86282.9010809@gmail.com>
	<200609051016.40468.bjorn.helgaas@hp.com>
	<44FEFD6F.4020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:31937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751807AbWIGDJN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 23:09:13 -0400
In-Reply-To: <44FEFD6F.4020203@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Keith Mannthey <kmannth@us.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Wed, 06 Sep 2006 18:55:11 +0200
Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Bjorn Helgaas napisa=C5=82(a):
> >=20
> > This ACPI "unknown exception code" problem is the same one reported=
 here:
> >   http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg02873=
=2Ehtml
> >=20
> > Basically, we just need to revert this:
> >   http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.=
6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-=
fix.patch
> >=20
> Thanks it works.
>=20

So...  should I drop that patch?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
