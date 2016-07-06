From: Wolfram Sang <wsa@the-dreams.de>
Subject: Regression between rc2 and rc6: ACPI EC problems
Date: Wed, 6 Jul 2016 23:14:11 +0900
Message-ID: <20160706141410.GA1430@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

when upgrading from v4.7-rc2 to rc6 on my Dell Mini 9, battery and
temperature status info got bogus. Here is the major change between the
boot logs:

ACPI : EC: EC stopped
ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20160422/evregion-300)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG] (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
ACPI Exception: AE_BAD_PARAMETER, from region _REG, [EmbeddedControl] (20160422/evregion-397)
ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20160422/evregion-300)
ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG] (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
ACPI Exception: AE_BAD_PARAMETER, from region _REG, [EmbeddedControl] (20160422/evregion-397)
ACPI : EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
ACPI : EC: EC started

The only config changes between the kernels were enabling MMC block
devices and DM_CRYPT. Not likely to cause the above, I'd think.

Does that ring a bell for someone? This little machine has only an SSD
without TRIM, so bisecting is not really an option. I can provide more
info and test patches, though.

Thanks,

   Wolfram


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfRIxAAoJEBQN5MwUoCm2Y0oP/3/HS20QA43C8sWKknIFEX0D
jbgibeaCgzaf3vUADiN5/ZyJWjo+WP+ZlRgki75TboqAHueT3KDK/C/XMEuKXPi0
JvT9QtTAw/RfV+0NnTxHcsVloix5pDMGp6mOj0n7toHz2b+WVLcowfe207ll7rQY
Mq+bx20x2b7BRUQDXJA5gtNwBA+PCpghQBHrb+qddfaQPl2H8IxLlVYNe0MhcbDa
owcKtA5Z2j0yiEm4fJauKYQt+ZGDV2FHAQqYSR05K44/+5fwPHqSFv/TEQuGKboz
AxqNXjZShqJRcPO8S9hLh013nhr4XsTIq6sCsTNl+28yJtONJFyaypKpVw9Jw1q4
3yDO76twUr+PLhrKuj+9X7ub/CZTJa0iJasM7ZZ5O6nTqliSjGqvKxZf2Toxxppa
lZ4b9YIRQrQB1yaei1dkN03fBrcGchuAHIbqYPrw0lPlFSGBEi7pK+rKv3HoTG4f
OBsXAUP23SF7jAtpwVOEUdUkpAQN+b04Ml9QXSfBdM8udBdXnxlpmc7WjdrnFfQJ
QJIXYszW2iAEOgzoXLyeffeJ7h38AeXYTkW3BWACu4cX3FbUpu5PRpQKJvKci+bp
werTJ82Sr5CeKxdv6Va8l6Wgu0iAImCTQt9w9KSjVKr/wr7Y5lMlzhdd0sMSukgW
BpTv6ycOofENv0qrz8cA
=zlT3
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
