From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
	detection
Date: Fri, 22 May 2009 10:03:08 +0800
Message-ID: <1242957788.32574.42.camel@rzhang-dt>
References: <20090513115734.338b7d55@jbarnes-g45>
	 <1242264144.3773.415.camel@localhost.localdomain>
	 <20090519171545.GA17801@srcf.ucam.org>
	 <1242896273.32574.10.camel@rzhang-dt> <20090521093418.3f1a03d5@jbarnes-g45>
	 <4A15FE57.7040002@linux.intel.com>  <20090522012611.GA3136@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63062 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZEVCCe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 22:02:34 -0400
In-Reply-To: <20090522012611.GA3136@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Fu Michael <michael_fu@linux.intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-05-22 at 09:26 +0800, Matthew Garrett wrote:
> On Fri, May 22, 2009 at 09:22:31AM +0800, Fu Michael wrote:
> > Jesse Barnes wrote:
> >> So is that two acks for the patch?  If so, should it be split or c=
an it
> >> just go in through the i915 driver tree?
> >>
> >> Len?  (Patch attached for reference.)
> >>
> >> Thanks,
> >>  =20
> > Jesse, Just talked with Rui,  the above status is based on "BIOS up=
grade =20
> > or FW fix is acceptable as a bug fix solution". are you ok with thi=
s? :) =20
> > Many lid status has to be fixed via action such as DSDT upgrade...
>=20
> Really? As I said, I'd be surprised if this is in any way common. Wha=
t's=20
> the exact problem description?
>=20
for example,
http://bugzilla.kernel.org/show_bug.cgi?id=3D13263
=EF=BB=BF=EF=BB=BFhttp://bugzilla.kernel.org/show_bug.cgi?id=3D5809
=EF=BB=BFhttp://bugzilla.kernel.org/show_bug.cgi?id=3D5904
and=20
https://bugs.launchpad.net/ubuntu/+bug/34389

thanks,
rui



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
