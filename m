From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
	detect IPMI system interface
Date: Tue, 08 Jun 2010 09:28:51 +0800
Message-ID: <1275960531.3718.77.camel@localhost.localdomain>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
	 <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
	 <20100607125213.GA8277@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23048 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0FHBbg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jun 2010 21:31:36 -0400
In-Reply-To: <20100607125213.GA8277@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

On Mon, 2010-06-07 at 20:52 +0800, Matthew Garrett wrote:
> On Mon, Jun 07, 2010 at 05:27:22PM +0800, yakui.zhao@intel.com wrote:
>=20
> > Use the ACPI detection mechanism firstly to detect the IPMI system =
interface
> > so that we can know which IPMI system interface is detected in ACPI=
 namespace and
> > then install the IPMI opregion to enable ACPI to access the BMC con=
troller.
> > But the hardcode detection mechanism is still put in the first orde=
r.
>=20
> This is less than ideal. I've seen several machines where the PCI IPM=
I=20
> device is the only one to provide interrupts, so using the ACPI one a=
nd=20
> refusing to register the PCI one isn't really an option.

=EF=BB=BFDoes there exist the ACPI detection mechanism on the machines =
you
mentioned? If exists, does it detect the same IPMI interface with the
PCI IPMI detection mechanism?

=EF=BB=BFIf the two mechanisms will detect the same IPMI interface, I a=
gree with
what you are concerned.  Do you have an idea/thought to set up the
relationship between ACPI and IPMI interface? In order to enable that
AML code can access the IPMI, it should know which IPMI interface will
be accessed and create the corresponding user interface. If ACPI
mechanism will fail to register the IPMI interface, maybe it is
difficult to create the correct user interface.

Thanks
    Yakui






--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
