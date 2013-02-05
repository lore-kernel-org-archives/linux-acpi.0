From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: APEI: ERST table in ACPI NVS not supported
Date: Mon, 4 Feb 2013 20:56:54 -0500
Message-ID: <20130205015654.GA26774@gchen.bj.intel.com>
References: <5108100B.9040907@linux.vnet.ibm.com>
 <20130204092018.GA22035@gchen.bj.intel.com>
 <510FEA90.8060503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51272 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab3BEB5n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2013 20:57:43 -0500
Content-Disposition: inline
In-Reply-To: <510FEA90.8060503@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Max Asbock <masbock@linux.vnet.ibm.com>
Cc: gong.chen@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2013 at 09:06:24AM -0800, Max Asbock wrote:
> Date:	Mon, 04 Feb 2013 09:06:24 -0800
> From: Max Asbock <masbock@linux.vnet.ibm.com>
> To: gong.chen@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com,
>  naveen.n.rao@in.ibm.com
> Subject: Re: APEI: ERST table in ACPI NVS not supported
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130108
>  Thunderbird/10.0.12
>=20
> On 02/04/2013 01:20 AM, Chen Gong wrote:
> >On Tue, Jan 29, 2013 at 10:08:11AM -0800, Max Asbock wrote:
> >
> >
> >we have systems that declare the memory range for ERST in ACPI NVS.
> >Because ACPI NVS is marked 'busy' by e820_reserve_resources() the
> >call to request_mem_region(erst_erange.base, erst_erange.size, "APEI
> >ERST") made from erst_init() fails and we get:
> >ERST: Can not request iomem region<0x        7e91f000-0x
> >7e920c00>  for ERST.
> >
> >I did notice that quite some effort was made to add code to avoid
> >resource conflicts between APEI and ACPI NVS. But ERST still goes
> >straight to request_mem_region() which is bound to fail. I am
> >assuming this should go through apei_resources_request() instead or
> >I am missing something?
> >
> >If my understanding is right, after ERST resource is requested via
> >apei_resources_request and when requesting error log address range,
> >you meet an NVS conflict, right?
> >
> >If so, NVS must be excluded. But I'm afraid if error range is
> >separated into two parts thus some errors will be lost. Would you
> >please paste errage address range and conflicted NVS range?
> ACPI NVS is:
>=20
> [    0.000000] BIOS-e820: [mem
> 0x000000007e6a5000-0x000000007ebc5fff] ACPI NVS
>=20
> ERST erange is:
>=20
> 0x7e91f000-0x7e920c00
>=20
> which is a single range entirely within ACPI NVS.
>=20
> thanks,
> Max
>=20
If so, ERST erange can't be allocated. It looks like a BIOS bug.
I think your concern is meaningful but as I said, erange means
the whole ERST table entries, which means any overlap will cause
part of error records are lost. So the safest way is to refuse
the allocation for such type of range.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREGbmAAoJEI01n1+kOSLHy7cQAJL4xSSKgbMfKfr8uptcsuwH
eyJ3LgJWNhLnItF7yVK8UMMrxg4Cm1DuqdmF10OANuzyb4Xuj5mJ8gNHZAb0Rcna
fXn2UF6BgoN7IBwr/aON/5yMMXIetkVhcVlyzlB9KTBUKedgWhInFT8fvRqkYHQ3
Wo5bLZp2OFJ3hYcOqrdg87n5/IMVh20zkEf+wChxW5Ewv53+VDvquKMNHyDLsoTg
pnPJX0hzMPPCsqjSWbYwjzjCMoV/K69NtBesGb2diE/xfPNQh1nyPGH3Q8G8+QiH
5yQarF2lF9dlekTCJjyXCIoLSaz3cNrQhZ1W819yeS7GsFyW/dQAh3PHQEtGekpN
i0D+sAHWJ6r2FDOd0vQd9TNNOnDuBxmbU/lOvnMfIogtWWcQ6JSzUEsb35cJsv6s
LDRja15gMEfjydS/i2iNvka0rlaPhTfVr7s9YLoG5pzfTTBVj531ykscnwfldWuu
Qhky6WPov5nFCaXXXkZhAhF96Zy48zQYprhg3TJ+eSLIi9wV7P9FSaM2C79Pjg+K
gA1Jx2RM5dGqqjRSes+fCGSMe4RiG6lDdM+7Zx9VOJlnJqVrNImJdTzO+6CGUm4A
x30/JosA8GWsTD3NNxiCY68rZoOJTMlwq/gqRA9LELRIGclf2NHeMIga/WX/+rDn
Oa4gItw2l/rX1QT7BHIC
=AIWw
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
