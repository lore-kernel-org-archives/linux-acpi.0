From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: APEI: ERST table in ACPI NVS not supported
Date: Mon, 4 Feb 2013 04:20:18 -0500
Message-ID: <20130204092018.GA22035@gchen.bj.intel.com>
References: <5108100B.9040907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48259 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab3BDJVV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2013 04:21:21 -0500
Content-Disposition: inline
In-Reply-To: <5108100B.9040907@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Max Asbock <masbock@linux.vnet.ibm.com>
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 10:08:11AM -0800, Max Asbock wrote:
> Date: Tue, 29 Jan 2013 10:08:11 -0800
> From: Max Asbock <masbock@linux.vnet.ibm.com>
> To: gong.chen@linux.intel.com, ying.huang@intel.com
> CC: linux-acpi@vger.kernel.org, masbock@linux.vnet.ibm.com
> Subject: APEI: ERST table in ACPI NVS not supported
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130108
>  Thunderbird/10.0.12
>=20
> Hi,
>=20
> we have systems that declare the memory range for ERST in ACPI NVS.
> Because ACPI NVS is marked 'busy' by e820_reserve_resources() the
> call to request_mem_region(erst_erange.base, erst_erange.size, "APEI
> ERST") made from erst_init() fails and we get:
> ERST: Can not request iomem region <0x        7e91f000-0x
> 7e920c00> for ERST.
>=20
> I did notice that quite some effort was made to add code to avoid
> resource conflicts between APEI and ACPI NVS. But ERST still goes
> straight to request_mem_region() which is bound to fail. I am
> assuming this should go through apei_resources_request() instead or
> I am missing something?
>=20

If my understanding is right, after ERST resource is requested via
apei_resources_request and when requesting error log address range,
you meet an NVS conflict, right?

If so, NVS must be excluded. But I'm afraid if error range is
separated into two parts thus some errors will be lost. Would you
please paste errage address range and conflicted NVS range?

> thanks,
> Max
>=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD31SAAoJEI01n1+kOSLHXU4P/0JqYvbzU9c737781SleoLJO
O+kvVRwY0LC0s67UlII1LW7qYNF8liI1n4CPn5ku2x2VTbIoJxWKONH/EUrGQYZm
n6pGq3UagSCwCUznof1j0aQz17yodEf08bWMCGiEGRIcdo+zHc881iB4UP1qIL11
5bMjIroujhDQuA1HOpbKZh6/Orb4AY6tihmm5VSZneOuetqTwYVEpNmMY0Kiqrae
fHOdmdslsaHYfDj1gHkvnoDb66sYDGHQ8fcj+B8PMAa8a4FZd+JiiNEBI5aL6dqs
VhRwV7+U9tDZvylhkW3QSbQi2iRaOSEX8qe+vXk46FwqAnNL0XgYHayehg/wO1H7
00s59URBfve+C7ZRDulPTGSwVN7+aGupbJOlvjAncxeScCRONZyhfq51kNjjpxRe
leObuAz+ujY+MKUh6SPcqe1dvoGcVl5li03p1DF6Zc+VLZX4/3VmmM45w7zGwP/z
U7kmYWBvRNocRPVofIzWDfdz9/Natfbk9dny+YMOzQdoq7Rp8hzDdxQqJIbmL9v1
jBpNccEPrJg0ztPz4rHgqEj4Wvx/gAHGKViB23SoqkRR5CjmqTWDYiqEZ/tEtMHP
lwvfWJX4OGVFad94twuHEpruKjzFTmacy1HEA+mLSWYV8Neh3uVKXQ/VoUwhyREE
uwlLQwKgOlYlvE60W+Ye
=ENup
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
