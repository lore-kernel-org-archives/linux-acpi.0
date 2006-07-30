From: Valdis.Kletnieks@vt.edu
Subject: Re: Generic battery interface
Date: Sun, 30 Jul 2006 04:35:57 -0400
Message-ID: <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz> <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com> <200607281557.k6SFvn09022794@turing-police.cc.vt.edu> <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com> <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
            <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154248557_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:65478
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932268AbWG3Lhv (ORCPT <RFC822;linux-acpi@vger.kernel.org>);
	Sun, 30 Jul 2006 07:37:51 -0400
In-Reply-To: Your message of "Sat, 29 Jul 2006 12:48:51 +0300."
             <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

--==_Exmh_1154248557_2988P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Jul 2006 12:48:51 +0300, Shem Multinymous said:

> The lazy polling approach I described in my last post to Vojtech
> ("block until there's  a new readout or N milliseconds have passed,
> whichever is later") looks like a more general, accurate and efficient
> interface.

That's not good.

If the program says '100ms' because it knows it will need to do a GUI update
then, and you block it for 5 seconds because that's when the next value
update happens, the user is stuck looking at their gkrellm or whatever not
doing anything at all for 4.9 seconds....

This almost forces the use of multiple threads if the program wants to do
its own timer management.

--==_Exmh_1154248557_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzG9tcC3lWbTT17ARAll2AKC9dchdZ+nlNVMYZPXZWbu/6jibMACeOWXZ
EnK1wp9plSXKWkYhCIz/CpU=
=q5MV
-----END PGP SIGNATURE-----

--==_Exmh_1154248557_2988P--
