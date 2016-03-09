From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Tue, 08 Mar 2016 17:04:04 -0700
Message-ID: <1457481844.15454.510.camel@hpe.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
	 <CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
	 <CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
	 <CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
	 <CAPcyv4i2GwujqK=MDJpSKhvufJprmCV4vmQRpS_UP-n1kau+mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:2420 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcCHXL3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 18:11:29 -0500
In-Reply-To: <CAPcyv4i2GwujqK=MDJpSKhvufJprmCV4vmQRpS_UP-n1kau+mg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2016-03-08 at 14:44 -0800, Dan Williams wrote:
> On Tue, Mar 8, 2016 at 2:23 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Tue, Mar 8, 2016 at 12:59 PM, Dan Williams <dan.j.williams@intel=
=2Ecom
> > > wrote:
> > >=20
> > > Here's the usage patch from Toshi [1] (copied below).=C2=A0=C2=A0=
It is indeed a
> > > resource injected by nfit / nvdimm bus implementation.=C2=A0=C2=A0=
We just
> > > happen
> > > to support nfit and libnvdimm as modules.
> > >=20
> > > The goal of these patches is to use the ACPI NFIT data to create =
a
> > > "Persistent Memory" rather than "reserved" resource.=C2=A0=C2=A0T=
his is for
> > > platform-firmware implementations that use E820-Type2 rather than
> > > E820-Type7 to describe pmem.
> >=20
> > So my worry is that there is likely exactly one or two of these kin=
ds
> > of sites.
> >=20
> > Why couldn't they just use insert_resource() and then remove it
> > manually?
>=20
> You mean instead of introducing a devm_insert_resource() as a helpful
> first-class-citizen api, just arrange for the resource to be inserted
> locally?=C2=A0=C2=A0Sure.
>=20
> I assume Toshi was looking to keep the devm semantics like the rest o=
f
> the nfit driver, but we can do that locally with devm_add_action() an=
d
> skip the new general purpose api.

Yes, I prefer the devm semantics. =C2=A0insert_resource() and remove_re=
source()
are not exported interfaces. =C2=A0So, with devm_add_action(), we still=
 need to
introduce built-in exported wrappers for insert/remove_resource(), unle=
ss
we change to export them directly. =C2=A0Since we need to export "somet=
hing", I
think it is better to export their devm interfaces.

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
