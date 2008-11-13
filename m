From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Devel] Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Thu, 13 Nov 2008 02:24:09 +0000
Message-ID: <20081113022409.GA25298@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de> <20081111005856.GA10535@srcf.ucam.org> <200811121758.39105.trenn@suse.de> <1226542860.15014.187.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57804 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYKMCYS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 21:24:18 -0500
Content-Disposition: inline
In-Reply-To: <1226542860.15014.187.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "me@markdoughty.co.uk" <me@markdoughty.co.uk>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "devel@acpica.org" <devel@acpica.org>

On Thu, Nov 13, 2008 at 10:21:00AM +0800, Zhang Rui wrote:
> =EF=BB=BFI have a test box which suspends well, but always reboots in=
stead of
> resuming when pressing the power button.
> I found that there are two FACS tables on this platform,
> XSDT-->FADT1-->Xfacs------>FACS1
> 	|----->facs-----|
> 			|->FACS2
> RSDT-->FADT2-->facs-----|
> Linux uses XSDT on this platform and sets the waking vector in FACS1
> when suspending. But it seems that the BIOS only cares for the waking
> vector in FACS2, thus it reboots when resuming because the waking vec=
tor
> is not set at all.

That makes it sound like we should be using the 32-bit value in this=20
case as well.

> My original proposal is to install both FADT1.Xfacs and FADT1.facs in=
 to
> the global table list and set the waking vectors on both of them.
> now it seems that switching back to RSDT if multiple valid FACS table=
s
> exists is also a solution for this issue.

Why? If there's a FADT entry in the XSDT we might as well use it - all=20
the machines I've checked contain valid information in the 32-bit entry=
=20
of the FADT there.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
