From: Frank Seidel <fseidel@suse.de>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Tue, 24 Oct 2006 11:05:47 +0200
Message-ID: <200610241105.52562.fseidel@suse.de>
References: <20061020092547.519734000@neutrino.suse.de> <1161529793.12599.36.camel@sublime.site> <200610230934.12775.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4757053.tQQ9aO3CzB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:23217 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030228AbWJXJFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Oct 2006 05:05:55 -0400
In-Reply-To: <200610230934.12775.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

--nextPart4757053.tQQ9aO3CzB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 23 October 2006 17:34, Bjorn Helgaas wrote:
> I think the current tree contains a merge error in asus_acpi_init().
> It says:
>
> 	if (!asus_hotk_found) {
> 		...
> 		return result;
>
> But "result" is always zero at this point (it came from
> acpi_bus_register_driver(), which returns either zero or a negative
> error value).
>
> My original change:
> =20
> http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco
>mmitdiff;h=3D578b333bfe8eb1360207a08a53c321822a8f40f3 contained:
>
> 	if (!asus_hotk_found) {
> 		...
> 		return -ENODEV;
>
> which is what we want.  I think the -ENODEV got lost when resolving
> conflicts with the "propagate correct return value" patches that
> happened at about the same time.
After some more testings and digging through the code.. i
agree with you that this is way to go (for now).
So, i sadfully now have to vote against my own patch ;-)

Len, please don't commit it. As Bjorn wrote, fixing the asus_acpi module
with return -ENODEV is the better solution.

Thanks,
=46rank

--nextPart4757053.tQQ9aO3CzB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFPddwlizSENHXK2gRAsBXAJ9fATB+MBFgl0gi8OtxvUEIr3TRiACeMSkv
jR2PITOPCGVkAGtqCrMyJuE=
=vD/G
-----END PGP SIGNATURE-----

--nextPart4757053.tQQ9aO3CzB--
