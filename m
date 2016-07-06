From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression between rc2 and rc6: ACPI EC problems
Date: Wed, 06 Jul 2016 23:28:55 +0200
Message-ID: <2028379.c7e6Pd4oDW@vostro.rjw.lan>
References: <20160706141410.GA1430@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart54373806.A3WWbj6dl9"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62729 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755798AbcGFVYZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2016 17:24:25 -0400
In-Reply-To: <20160706141410.GA1430@tetsubishi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>


--nextPart54373806.A3WWbj6dl9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, July 06, 2016 11:14:11 PM Wolfram Sang wrote:
> Hi,
> 
> when upgrading from v4.7-rc2 to rc6 on my Dell Mini 9, battery and
> temperature status info got bogus. Here is the major change between the
> boot logs:
> 
> ACPI : EC: EC stopped
> ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20160422/evregion-300)
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG] (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> ACPI Exception: AE_BAD_PARAMETER, from region _REG, [EmbeddedControl] (20160422/evregion-397)
> ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20160422/evregion-300)
> ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG] (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> ACPI Exception: AE_BAD_PARAMETER, from region _REG, [EmbeddedControl] (20160422/evregion-397)
> ACPI : EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
> ACPI : EC: EC started
> 
> The only config changes between the kernels were enabling MMC block
> devices and DM_CRYPT. Not likely to cause the above, I'd think.
> 
> Does that ring a bell for someone? This little machine has only an SSD
> without TRIM, so bisecting is not really an option. I can provide more
> info and test patches, though.

There is one commit related directly to EC between -rc2 and -rc6:

dcf15cbded65 ACPI / EC: Fix a boot EC regresion by restoring boot EC support for the DSDT EC

There also are two ACPICA commits in that frame that may be related to it

2f38b1b16d92 ACPICA: Namespace: Fix deadlock triggered by MLC support in dynamic table loading
da4e792550a8 Revert "ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for acpi_hw_write()"

but one of them is a revert, so can you please check dcf15cbded65 and 2f38b1b16d92?

Thanks,
Rafael

--nextPart54373806.A3WWbj6dl9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJXfXgcAAoJEILEb/54YlRxZogP/AkVJas+4VznbAvr7cbALVPg
q5L7QJv8KZLFpKaVZpzxXoNwEnDqMOL/k6A0A8vSjhjOZcQd3n2sCpoPfQs2QSRu
ABgHTSMupE1ns4XAVxnP+HtW0HnV5PbWgfJzwU3n2kY11I50uDkVf8LgMUA4rxEq
kydYBzM8gZyPYCdNbK2ro3ctfa7V0w0geGJaJnzjqvd94NfBC5srxepsxSR8qohQ
EQ5mz34FPE+tJmCnkpa+c20tc82nfMRK3NwinPyMK9hj3cb0WsSp1lBwLs/0PjQb
wmRqLDq3DwLhWOvuWxqqbNb95UK8/XtdvUe0OG774xiECm+E2ESNc+t6vvM5z/+/
6bVeeQcwEv8kDjAaOmtvJA7Bom7zQ0xc0uWOZ3FttGxcFbjrOkBUP+2CX+Wx9mpw
CPDmACAoPhNhkBlewjAzfhUcvzu2aBBJBaxHg16yvsOcC6hEzPRxLCb4ZpOJsHmL
1nc+ReQdnnmHX55kgsPFU+dO+82DjFcVJrO6NQ8c9pyTuVrtjGNRDMqrYR/Jogcx
FrbpYDoVuX0GPZ5Wv2BhIbnvwEAqRhr6bThAlW1aZDuowBb6F4Remjn6iURseR32
ulAI2XY1EaihPyamG4IurlxZ3IFX+Q62MKYrbCIZ4o7kBzLS0h1IzXYyCKoGSKeh
o9z4CTpacBqc3sOv6/qz
=X2Pp
-----END PGP SIGNATURE-----

--nextPart54373806.A3WWbj6dl9--

