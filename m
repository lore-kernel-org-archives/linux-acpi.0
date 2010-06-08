From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
	detect IPMI system interface
Date: Tue, 8 Jun 2010 02:34:53 +0100
Message-ID: <20100608013453.GA5167@srcf.ucam.org>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com> <1275902842-19895-2-git-send-email-yakui.zhao@intel.com> <1275902842-19895-3-git-send-email-yakui.zhao@intel.com> <20100607125213.GA8277@srcf.ucam.org> <1275960531.3718.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49359 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab0FHBfL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2010 21:35:11 -0400
Content-Disposition: inline
In-Reply-To: <1275960531.3718.77.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

On Tue, Jun 08, 2010 at 09:28:51AM +0800, ykzhao wrote:

> =EF=BB=BFDoes there exist the ACPI detection mechanism on the machine=
s you
> mentioned? If exists, does it detect the same IPMI interface with the
> PCI IPMI detection mechanism?

What is "the same"? It's not using the same ioport space, certainly.

> =EF=BB=BFIf the two mechanisms will detect the same IPMI interface, I=
 agree with
> what you are concerned.  Do you have an idea/thought to set up the
> relationship between ACPI and IPMI interface? In order to enable that
> AML code can access the IPMI, it should know which IPMI interface wil=
l
> be accessed and create the corresponding user interface. If ACPI
> mechanism will fail to register the IPMI interface, maybe it is
> difficult to create the correct user interface.

Well, right now if you change the ordering then the PCI interface will=20
never be exposed. It would be preferable to only expose the ACPI=20
interface as a user-visible device if there's no prior device - if ther=
e=20
is, I think the ideal solution would be for it to be an in-kernel only=20
device without a corresponding UI.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
