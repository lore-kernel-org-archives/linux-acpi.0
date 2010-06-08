From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
	detect IPMI system interface
Date: Tue, 08 Jun 2010 13:10:08 +0800
Message-ID: <1275973808.3718.99.camel@localhost.localdomain>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
	 <20100607125213.GA8277@srcf.ucam.org>
	 <1275960531.3718.77.camel@localhost.localdomain>
	 <20100608013453.GA5167@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63437 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab0FHFMw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jun 2010 01:12:52 -0400
In-Reply-To: <20100608013453.GA5167@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

On Tue, 2010-06-08 at 09:34 +0800, Matthew Garrett wrote:
> On Tue, Jun 08, 2010 at 09:28:51AM +0800, ykzhao wrote:
>=20
> > =EF=BB=BFDoes there exist the ACPI detection mechanism on the machi=
nes you
> > mentioned? If exists, does it detect the same IPMI interface with t=
he
> > PCI IPMI detection mechanism?
>=20
> What is "the same"? It's not using the same ioport space, certainly.

"The same" means that they will use the same ioport space/address.
If they use the different ioport space/address, they will be regarded a=
s
the different IPMI device.

>=20
> > =EF=BB=BFIf the two mechanisms will detect the same IPMI interface,=
 I agree with
> > what you are concerned.  Do you have an idea/thought to set up the
> > relationship between ACPI and IPMI interface? In order to enable th=
at
> > AML code can access the IPMI, it should know which IPMI interface w=
ill
> > be accessed and create the corresponding user interface. If ACPI
> > mechanism will fail to register the IPMI interface, maybe it is
> > difficult to create the correct user interface.
>=20
> Well, right now if you change the ordering then the PCI interface wil=
l=20
> never be exposed. It would be preferable to only expose the ACPI=20
> interface as a user-visible device if there's no prior device - if th=
ere=20
> is, I think the ideal solution would be for it to be an in-kernel onl=
y=20
> device without a corresponding UI.

Sorry that I don't explain it clearly. The concept of "user interface"
in IPMI interface is only a channel that can be used to communicate wit=
h
the IPMI controller. It has no relationship with whether the IPMI
interface should be exposed to user space. If one driver wants to
communicate with one IPMI interface, we should create one "user
interface" firstly and send the corresponding IPMI message by using the
"user interface".

If one IPMI interface(controller) is already detected by PCI mechanism,
then ACPI will fail to detect the same IPMI interface. In such case it
is difficult for ACPI to know which IPMI interface should be accessed
when the ACPI AML code need to communicate with the IPMI interface.

thanks
   Yakui

>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
