From: Frank Seidel <fseidel@suse.de>
Subject: Re: [patch] ACPI: asus_acpi: return -ENODEV when no device found
Date: Thu, 26 Oct 2006 11:22:41 +0200
Message-ID: <200610261122.46254.fseidel@suse.de>
References: <20061020092547.519734000@neutrino.suse.de> <200610241105.52562.fseidel@suse.de> <200610251358.25379.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1414107.VFSizyEsmt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:65243 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422809AbWJZJWu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Oct 2006 05:22:50 -0400
In-Reply-To: <200610251358.25379.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

--nextPart1414107.VFSizyEsmt
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 October 2006 21:58, Bjorn Helgaas wrote:
> This driver is for non-hot-pluggable hardware.  Therefore, if the
> hardware isn't present, we want to return -ENODEV so a module load
> will fail.
>
> We previously returned "result" from the acpi_bus_register_driver()
> call. Registering the driver usually succeeds even if no devices are
> present, because the ACPI core allows you to load a driver before a
> device is hot-added.
>
> Someday the kernel will expose enough information so user-space can
> tell what ACPI drivers should be loaded.  But the kernel doesn't do
> that yet, so distros have to load this driver always and rely on the
> -ENODEV causing the load to fail if the hardware isn't found.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Frank Seidel <fseidel@suse.de>

--nextPart1414107.VFSizyEsmt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFQH5mlizSENHXK2gRAhL7AKCVGFS//DTtgDGV4AJ7Gx7T6t/CZwCfSkAs
9gApGz/XlJhzALeHbkC5e8M=
=NN57
-----END PGP SIGNATURE-----

--nextPart1414107.VFSizyEsmt--
