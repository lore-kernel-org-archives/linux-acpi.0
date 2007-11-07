From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: *New* HP dv6000 series backlight driver.
Date: Wed, 7 Nov 2007 19:56:19 +0000
Message-ID: <20071107195619.8599c6a5.miknix@gmail.com>
References: <20070911171927.572087e0.miknix@gmail.com>
	<20071022004144.6e4240de.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__7_Nov_2007_19_56_19_+0000_2FNVLVXlWmWi1D.3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:15187 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbXKGTsA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2007 14:48:00 -0500
Received: by an-out-0708.google.com with SMTP id b36so335151ana
        for <linux-acpi@vger.kernel.org>; Wed, 07 Nov 2007 11:47:59 -0800 (PST)
In-Reply-To: <20071022004144.6e4240de.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--Multipart=_Wed__7_Nov_2007_19_56_19_+0000_2FNVLVXlWmWi1D.3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

With help of acer_ec.pl I could find HP dv6535ep brightness register.
I made a driver for controlling the screen brightness using the backlight backend.

It's my very first kernel driver. I hope the code is not too ugly : \

Hoping some advices,
Thanks!
- -- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey online

- - -
You roll my log, and I will roll yours.
		-- Lucius Annaeus Seneca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHMhhgNahyoD2SuwsRApuxAKDJOOREB+L3uRtSBIhpMQNzVkCKMwCgoUre
IgBlClwfpXhw3o/xup6Je3w=
=+vNE
-----END PGP SIGNATURE-----

--Multipart=_Wed__7_Nov_2007_19_56_19_+0000_2FNVLVXlWmWi1D.3
Content-Type: application/x-gzip;
 name="dv6000_bl.c.gz"
Content-Disposition: attachment;
 filename="dv6000_bl.c.gz"
Content-Transfer-Encoding: base64

H4sICBkXMkcAA2R2NjAwMF9ibC5jAI1VbW/iRhD+DL9iStUrRIRAomuvx/Vah5gEiQAykGukStZi
r/EKs2vtriHodP+9s2veHMhdERJ4d+aZZ5558dVFGS4AwtVvzWbTnyWNAC7hYbQ9AEUlowpmJFgk
bB5rCCVbUYk++RegI9KNtFfVTg2um83fweFzmghwpGQR4QI+LdmCs5e/50vCMIBYft453xJFQxAc
tFAxmxGfBCmzN24HPDpnSlOpIGQqEBgWbddMxxDTJAURAQmo9GnQSJMd4CRmClIp5pIsAf9GklJQ
ItJrImkbNiKDgHBAJISWbJZpCkwD4eGVkLAUIYs2FggPMx5SCTqmgCSWygQ0D/eDKdxTTiVJYJTN
EhZAnwWUKwoEY5sTFSPTWQ5kXLqGxXjLAroCkYlmgreBYjoYBHNT+AzXuyBbxDoIaVGqRBvyEkRq
HGvIeAMJ0QffxlsSHDINgXGLHosUk4oRE9NcsySBGYVM0ShL6hYDreFLb/IwnE7AGTzDF8fznMHk
uW31F3hLVzTHYss0YaYwRErC9QYzsBCPrtd5QB/nttfvTZ4xEej2JgN3PIbu0AMHRo436XWmfceD
0dQbDcduA2BMDTFqEb4jdGSLhVqGVGNPqX3yz1hghQSTEGKyoljogGLDhkAgwEb9cQ0tCkkEn+et
po/UbAOLgAtdh7Vk2DhanFbX+h8qXIceDxp1eP8HTCgqRWGUYNfWYZwZhJubZh1uhdLG8tEBaF63
Wq3L1g1OEUzHzr6mw7vhR/vvQYgFzOzAcaoUZOlVKNYcFnSjDKEgJjh9RxYN69aDUPBfNepBkmQD
Cy7WJhmkr4xIu0Ez7WlSUmSZi7yORZLnBMWV0MhxuzhMgeBaiuQvDLLEgCh2lubikT103m0pNk5k
xi/jnPH5Fhebckle2DJbgkopDS30Vbn8c0gjxincPdnddNv3n1xv3BsOSpVmo9mqnDG4c8cdqPxw
fVVg7zvyhh2/N5i4XtfpuPsILQzPeJBkIYVPCePZy9WCSk6TRvz55AbXRpbQczeMM33uXG9SlPDM
xZ7puUuzHM15+XF4N+27vjPFCfWqlR/v20qtvXMyEnm90QSzrBaFO9j0ex13MHarlftR37iWry7A
SZSoQ/PFvTHjsGIh6kqwmqHdBlFEA41F28nqdm77nntv7K+t+xO2AYH8VuVTtS263TjYnyw0DWqn
NsBNR+b5gMkNxCgIlQ04xX9y+o/OPxjlfbd87q43wLtms1zG4BqHHDdhFuhDP/giVYd3n48zS9pv
2oZ0hTsCLo7s6QrF2TkwjtaJP6faP4xf9U2Y3L9W/louZR9ghZvoT7hsIV6JRVUa+DiqYbWafaht
86nDOzSq1cqlUiox1qJa2TP5CB3CcTOZ+Q7xpSeWqMJP/3JTvJKkOpPcRGiXv53QVUjXnGT/j2rO
ze6/IjnzkNtdfsYGSVXjIIIh/fW7vPcL9UB7x9toUvpWLtEEt/P+tFnIZSVYeFRH+sJ01ZztKBdK
VjvJ0M/4blG9MjXlyCPaeEfS+b4Z7qOg5vEQ9EyqvyhY/aIwu/rrjVU/WXE2cIEKdscJ7T3pSpz6
uTWCD6b9fh1QKvPZPr0rNrnRF2XpjX3X816lXHurUvatmjfZdqkf7VVLaFe518QNh+K5rVAtL2zB
etc8uByOpggxChP/Sh3MqFEcO6PW61Fsn/hkKf7QbftD7nOYh0Ptt92W7/m80MW6YybbS5tYMU+8
/A+gBcPsZgsAAA==

--Multipart=_Wed__7_Nov_2007_19_56_19_+0000_2FNVLVXlWmWi1D.3--
