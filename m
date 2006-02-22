From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Date: Wed, 22 Feb 2006 07:50:22 +0100
Message-ID: <1140591022.4813.7.camel@deep-space-9.dsnet>
References: <43FA5293.4070807@ed-soft.at> <p73ek1w4x3a.fsf@verdi.suse.de>
	 <20060221125919.5085de5f.akpm@osdl.org>  <200602212209.07586.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:5385 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751342AbWBVGu0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 01:50:26 -0500
In-Reply-To: <200602212209.07586.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, hostmaster@ed-soft.at, Bjorn Helgaas <bjorn.helgaas@hp.com>

Le mardi 21 f=E9vrier 2006 =E0 22:09 +0100, Andi Kleen a =E9crit :
> On Tuesday 21 February 2006 21:59, Andrew Morton wrote:

> > OK, thanks.  I don't think we actually know who is trying to unmap =
some
> > memory which acpi didn't map.
> >=20
> > Edgar, can you please describe the bug which you're trying to fix?
>=20
> I think the bug is clear - the logic in acpi_os_unmap_memory needs to=
 match=20
> what acpi_os_map_memory() does for EFI. In particular this means not =
calling
> iounmap.
>=20
> He probably has a EFI system where this caused troubles.

This EFI system is the new Intel Core Duo based Apple iMac (Edgar
described the process of booting Linux on this pretty box at=20
http://www.mactel-linux.org/)

In particular, the iounmap problem is visible in the logs at
http://www.mactel-linux.org/wiki/Dmesg

Stelian.
--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
