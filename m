From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
 detect IPMI system interface
Date: Tue, 08 Jun 2010 21:02:37 -0600
Message-ID: <1276052557.2769.47.camel@zim>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
	 <20100607125213.GA8277@srcf.ucam.org>
	 <1275960531.3718.77.camel@localhost.localdomain>
	 <20100608013453.GA5167@srcf.ucam.org>
	 <1275973808.3718.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:24045 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab0FIDCm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 23:02:42 -0400
In-Reply-To: <1275973808.3718.99.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Tue, 2010-06-08 at 13:10 +0800, ykzhao wrote:
> On Tue, 2010-06-08 at 09:34 +0800, Matthew Garrett wrote:
> > On Tue, Jun 08, 2010 at 09:28:51AM +0800, ykzhao wrote:
> >=20
> > > =EF=BB=BFDoes there exist the ACPI detection mechanism on the mac=
hines you
> > > mentioned? If exists, does it detect the same IPMI interface with=
 the
> > > PCI IPMI detection mechanism?
> >=20
> > What is "the same"? It's not using the same ioport space, certainly=
=2E
>=20
> "The same" means that they will use the same ioport space/address.
> If they use the different ioport space/address, they will be regarded=
 as
> the different IPMI device.
ACPI namespace* should not be enumerating a device that is discoverable
via standard PCI device enumeration so if there are multiple IPMI
devices in a system, where one is enumerated via ACPI namespace and
another is enumerated via PCI they should never be "the same" literal
device.

* I specifically denoted namespace since the ACPI SPMI table, yet
another ACPI based IPMI enumeration mechanism, seems as if it could
denote "the same" literal device.


Matthew's approach, giving a PCI based IPMI device precedence due to it=
s
inclusion of interrupt information, does seem to have merit.

Myron
>=20
> >=20
> > > =EF=BB=BFIf the two mechanisms will detect the same IPMI interfac=
e, I agree with
> > > what you are concerned.  Do you have an idea/thought to set up th=
e
> > > relationship between ACPI and IPMI interface? In order to enable =
that
> > > AML code can access the IPMI, it should know which IPMI interface=
 will
> > > be accessed and create the corresponding user interface. If ACPI
> > > mechanism will fail to register the IPMI interface, maybe it is
> > > difficult to create the correct user interface.
> >=20
> > Well, right now if you change the ordering then the PCI interface w=
ill=20
> > never be exposed. It would be preferable to only expose the ACPI=20
> > interface as a user-visible device if there's no prior device - if =
there=20
> > is, I think the ideal solution would be for it to be an in-kernel o=
nly=20
> > device without a corresponding UI.
>=20
> Sorry that I don't explain it clearly. The concept of "user interface=
"
> in IPMI interface is only a channel that can be used to communicate w=
ith
> the IPMI controller. It has no relationship with whether the IPMI
> interface should be exposed to user space. If one driver wants to
> communicate with one IPMI interface, we should create one "user
> interface" firstly and send the corresponding IPMI message by using t=
he
> "user interface".
>=20
> If one IPMI interface(controller) is already detected by PCI mechanis=
m,
> then ACPI will fail to detect the same IPMI interface. In such case i=
t
> is difficult for ACPI to know which IPMI interface should be accessed
> when the ACPI AML code need to communicate with the IPMI interface.
>=20
> thanks
>    Yakui
>=20
> >=20
>=20


--=20
Myron Stowe                             HP Open Source Linux Lab (OSLL)

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
