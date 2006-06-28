From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Wed, 28 Jun 2006 10:57:44 +0200
Message-ID: <20060628085744.74730@gmx.net>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <20060627000324.b9457fb4.akpm@osdl.org> <20060627073704.GD3438@neo.rr.com>	
 <1151393390.21189.59.camel@sli10-desk.sh.intel.com>	
 <1151409746.44a11e52e7002@imp8-g19.free.fr>
 <1151456568.21189.84.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:23957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161012AbWF1I5q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jun 2006 04:57:46 -0400
In-Reply-To: <1151456568.21189.84.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>, castet.matthieu@free.fr
Cc: bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com


-------- Original-Nachricht --------
Datum: Wed, 28 Jun 2006 09:02:48 +0800
Von: Shaohua Li <shaohua.li@intel.com>
An: castet.matthieu@free.fr
Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources

> On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr wrote:
> > Selon Shaohua Li <shaohua.li@intel.com>:
> >=20
> > >
> >
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommit;h=3Dc4bb6f5ad968540d7f9619565bacd18d7419b85f
> > > Thanks and sorry I didn't find the issue before. We'd better blac=
klist
> > > root bridge. I saw at lest one BIOS (IA64 box) didn't assign corr=
ect
> > > producer/consumer flag to root bridge resources. Blacklist it is =
much
> > > safer.
> >=20
> > Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
> > If not we will have the same problem with others devices...
> >=20
> > I don't think blacklist is the solution : pnpacpi should be able to
> handle all
> > ressources types : we should complete the implementation instead of
> blacklist
> > devices our implementation doesn't support.
> >=20
> > If there are broken ACPI bios, there should be firmware update, a
> patched dsdt
> > or a quirk, but no "quirk and no generic solution".
> >>From my understanding, if the device is really a PNP device its res=
ource
> should not be producer.
> Or could we take this way, merge both patches (both patches are good =
to
> me), which should be safer. Anyway, it doesn't make sense to export r=
oot
> bridge to pnp layer to me.
>=20
> Thanks,
> Shaohua

I tested the patch without blacklisting the PNP resource at the same ti=
me under 2.6.17-rc6-mm*, and did not find any regression.
And I am sure there is a solution also for IA64 architectures without g=
oing  the blacklist path which sounds a bit strange after having done s=
uch a big effort of real good work.
Unfortunately I do not own an IA64 architecture, so I neither cannot te=
st nor understand Shaohua=B4s criticism on that.
Under latest mm-patches (mm1, mm2, mm3 for official release of 2.6.17) =
it is at least impossible for me to give any positive feedback, as all =
three mm-versions are simply unusable. I will feature this in another m=
ail to Andrew.

Cheers

Uwe

--=20


Echte DSL-Flatrate dauerhaft f=FCr 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
