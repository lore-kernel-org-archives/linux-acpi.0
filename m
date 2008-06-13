From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpi thermal sensors not working, laptop overheating
Date: Fri, 13 Jun 2008 12:19:47 +0100
Message-ID: <20080613111947.GA2443@srcf.ucam.org>
References: <BAY114-W23E452D9A025AF7E6A5225FAAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43717 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbYFMLTv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jun 2008 07:19:51 -0400
Content-Disposition: inline
In-Reply-To: <BAY114-W23E452D9A025AF7E6A5225FAAC0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luke Sharkey <lukesharkey@hotmail.co.uk>
Cc: linux-acpi@vger.kernel.org

On Fri, Jun 13, 2008 at 12:07:45PM +0100, Luke Sharkey wrote:

> Example sensors output:
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +54.0=B0C                                   =20

54 degrees is fine.

> state:                   ok
> temperature:             0 C
> critical (S5):           94 C
> passive:                 90 C: tc1=3D2 tc2=3D5 tsp=3D50 devices=3DCPU=
0=20

Can you attach the output of the acpidump command? The BIOS is=20
presumably reading the temperature without any trouble, given the fan=20
behaviour, so it would be nice to check why Linux isn't picking it up.=20
Do you get the same readings if you don't load the k8temp module? Also,=
=20
make sure no other sensors modules are loaded. They can potentially=20
interfere with ACPI.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
