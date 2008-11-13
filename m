From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Devel] Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Thu, 13 Nov 2008 11:13:42 +0000
Message-ID: <20081113111342.GB30587@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081111005856.GA10535@srcf.ucam.org> <200811121758.39105.trenn@suse.de> <1226542860.15014.187.camel@rzhang-dt> <20081113022409.GA25298@srcf.ucam.org> <1226564829.15014.225.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47156 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYKMLNz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 06:13:55 -0500
Content-Disposition: inline
In-Reply-To: <1226564829.15014.225.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "me@markdoughty.co.uk" <me@markdoughty.co.uk>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "devel@acpica.org" <devel@acpica.org>

On Thu, Nov 13, 2008 at 04:27:09PM +0800, Zhang Rui wrote:
> On Thu, 2008-11-13 at 10:24 +0800, Matthew Garrett wrote:
> > Why? If there's a FADT entry in the XSDT we might as well use it - =
all=20
> > the machines I've checked contain valid information in the 32-bit e=
ntry=20
> > of the FADT there.
> >=20
> do you mean =EF=BB=BFalways using FADT1.facs and ignore the FADT.Xfac=
s in Linux?

If the value is below 4GB and uses the same resource type as the legacy=
=20
value, I don't see why not.
--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
