From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
	detect IPMI system interface
Date: Thu, 10 Jun 2010 10:34:55 +0800
Message-ID: <1276137295.4564.22.camel@localhost.localdomain>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
	 <20100607125213.GA8277@srcf.ucam.org>
	 <1275960531.3718.77.camel@localhost.localdomain>
	 <20100608013453.GA5167@srcf.ucam.org>
	 <1275973808.3718.99.camel@localhost.localdomain> <4C0F9264.8000008@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25105 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab0FJChy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jun 2010 22:37:54 -0400
In-Reply-To: <4C0F9264.8000008@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

On Wed, 2010-06-09 at 21:08 +0800, Corey Minyard wrote:
> ykzhao wrote:
> > On Tue, 2010-06-08 at 09:34 +0800, Matthew Garrett wrote:
> >  =20
> >> On Tue, Jun 08, 2010 at 09:28:51AM +0800, ykzhao wrote:
> >>
> >>    =20
> >>> =EF=BB=BFDoes there exist the ACPI detection mechanism on the mac=
hines you
> >>> mentioned? If exists, does it detect the same IPMI interface with=
 the
> >>> PCI IPMI detection mechanism?
> >>>      =20
> >> What is "the same"? It's not using the same ioport space, certainl=
y.
> >>    =20
> >
> > "The same" means that they will use the same ioport space/address.
> > If they use the different ioport space/address, they will be regard=
ed as
> > the different IPMI device.
> >
> >  =20
> >>> =EF=BB=BFIf the two mechanisms will detect the same IPMI interfac=
e, I agree with
> >>> what you are concerned.  Do you have an idea/thought to set up th=
e
> >>> relationship between ACPI and IPMI interface? In order to enable =
that
> >>> AML code can access the IPMI, it should know which IPMI interface=
 will
> >>> be accessed and create the corresponding user interface. If ACPI
> >>> mechanism will fail to register the IPMI interface, maybe it is
> >>> difficult to create the correct user interface.
> >>>      =20
> >> Well, right now if you change the ordering then the PCI interface =
will=20
> >> never be exposed. It would be preferable to only expose the ACPI=20
> >> interface as a user-visible device if there's no prior device - if=
 there=20
> >> is, I think the ideal solution would be for it to be an in-kernel =
only=20
> >> device without a corresponding UI.
> >>    =20
> >
> > Sorry that I don't explain it clearly. The concept of "user interfa=
ce"
> > in IPMI interface is only a channel that can be used to communicate=
 with
> > the IPMI controller. It has no relationship with whether the IPMI
> > interface should be exposed to user space. If one driver wants to
> > communicate with one IPMI interface, we should create one "user
> > interface" firstly and send the corresponding IPMI message by using=
 the
> > "user interface".
> >
> > If one IPMI interface(controller) is already detected by PCI mechan=
ism,
> > then ACPI will fail to detect the same IPMI interface. In such case=
 it
> > is difficult for ACPI to know which IPMI interface should be access=
ed
> > when the ACPI AML code need to communicate with the IPMI interface.
> >  =20
> This may all be true, but the IPMI specification clearly gives the=20
> detection order.  It's not a good idea to deviate from that without a=
=20
> very good reason.  I'm not sure this is a good enough reason.

Sorry that I don't pay attention to the discovery order. I relook at th=
e
IPMI spec and find that I am wrong.

>=20
> Also, the bulk of this code clearly has nothing to do with the system=
=20
> interface itself and should be in its own file.  And is there any rea=
son=20
> to tie this to the SMI code, anyway?  There are plenty of systems wit=
h=20
> IPMI and ACPI that use I2C or serial ports.  Can they not use this AC=
PI=20
> function (even though their drivers are not in the mainstream kernel)=
?

My first thought is to put the ACPI-IPMI opregion handler into ACPI
subsystem. But Bjorn suggests that it can be put into the smi code. The=
n
I follow his suggestion.

OK. I will rewrite the code and don't tie the ACPI-IPMI opregion handle=
r
to the smi code.
   =20
>=20
> Can you look and see if there is some other way to detect the ACPI=20
> function on a BMC with some other mechanism?  I think that would be=20
> better all around.  If it's the same BMC, the I can't imagine it matt=
ers=20
> if you send the messages via the PCI-detected or ACPI-detected mechan=
isms.

OK. I will think about it again and try to figure out one solution that
identify the same BMC via PCI-detected or ACPI-detected and avoids
adjusting the discovery order.=20

Thanks for your idea.


>=20
> -corey

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
