From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to enable ACPI to access BMC controller
Date: Mon, 19 Jul 2010 08:54:36 -0600
Message-ID: <201007190854.36340.bjorn.helgaas@hp.com>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com> <201007161001.21956.bjorn.helgaas@hp.com> <1279504348.3660.140.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:13549 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933554Ab0GSOyn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jul 2010 10:54:43 -0400
In-Reply-To: <1279504348.3660.140.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Sunday, July 18, 2010 07:52:28 pm ykzhao wrote:
> On Sat, 2010-07-17 at 00:01 +0800, Bjorn Helgaas wrote:
> > On Thursday, July 15, 2010 08:34:35 pm ykzhao wrote:
> > > On Fri, 2010-07-16 at 00:27 +0800, Bjorn Helgaas wrote:
> > > > The ACPI IPMI opregion code deals with an ACPI device, and the
> > > > obvious place where you have that device is the driver "add"
> > > > function, i.e., ipmi_pnp_probe().  That's the point where the
> > > > PNP core will help you out by matching device IDs and handling
> > > > hotplug for you.
=2E..
> > > Yes. The hotplug scenario should be considered. This will be hand=
led
> > > under two places:
> > >    a. the IPMI pnp detection:=20
> > >    b. install opregion handle for the hotplug IPI0001 device
> > >=20
> > > But in fact the acpi_pnp device is enumerated only once at the bo=
ot
> > > time.
> >=20
> > Drivers cannot rely on anything like "the acpi_pnp device is
> > enumerated only once at boot-time."  Device enumeration happens
> > in the ACPI core and PNP core, not in drivers, and drivers can't
> > assume anything about when it happens.
>=20
> =EF=BB=BFYes. But in fact the ACPI pnp device is enumerated only once=
 at the
> boot time.

NO!  You can NOT assume the ACPI PNP device is enumerated once at
boot time.

That may be the way the current implementation behaves, but the
driver interface does not specify that, and it is likely to change.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
