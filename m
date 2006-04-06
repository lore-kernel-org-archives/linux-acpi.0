From: "David J. Wallace" <katana@onetel.com>
Subject: Re: ACPI hotkeys and Panasonic R4
Date: Thu, 6 Apr 2006 20:22:58 +0100
Message-ID: <200604062023.06260.katana@onetel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1190137@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3682664.hYDNYcoSpX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ironport1.mynow.co.uk ([81.91.192.235]:20039 "EHLO
	ironport1.mynow.co.uk") by vger.kernel.org with ESMTP
	id S932231AbWDFTXK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Apr 2006 15:23:10 -0400
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1190137@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

--nextPart3682664.hYDNYcoSpX
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 06 April 2006 02:16, Yu, Luming wrote:
> Please try boot option: acpi_generic_hotkey
> Please don't forget apply patchs mentioned at:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D5749#c11
>
> For panasonic , the patch just support :
> echo -n xx > /sys/hotkey/brightness .
>
> If you have other question, please feel free to ask.
>
> --Luming

Thanks for the info. I didn't realise I needed the patch. I applied the pat=
ch=20
and now echo -n xx > /sys/hotkey/brightness allows control of the LCD=20
brightness. Any plans to support any of the other hotkeys?

Now to define some events in event_config.

Thanks again,

David

--nextPart3682664.hYDNYcoSpX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENWqaKsvwCXwmAPgRAltWAJ0SGxySY33PpEltvp0ido4+BX1x6wCcCQ5x
1M1MW/w4PiVQ6sJx1ggGrYM=
=o2wL
-----END PGP SIGNATURE-----

--nextPart3682664.hYDNYcoSpX--
