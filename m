From: Valdis.Kletnieks@vt.edu
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 15:53:40 -0400
Message-ID: <31067.1250279620@turing-police.cc.vt.edu>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <Pine.LNX.4.64.0908131724370.8831@sister.anvils> <1250213336.2987.3.camel@minggr.sh.intel.com>
            <200908141044.51799.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1250279620_9206P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60737 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbZHNTym (ORCPT
	<RFC822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 15:54:42 -0400
In-Reply-To: Your message of "Fri, 14 Aug 2009 10:44:50 MDT."
             <200908141044.51799.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

--==_Exmh_1250279620_9206P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Aug 2009 10:44:50 MDT, Bjorn Helgaas said:

> I don't quite understand how this oops happens, though.  It seems that
> we crashed in this path:
> 
>   acpi_device_probe
>     acpi_bus_driver_init
>       driver->ops.add  (calls acpi_video_bus_add)
>     acpi_device_install_notify_handler
>       hid = acpi_device_hid(device)
>       strcmp(hid, ACPI_BUTTON_HID_POWERF))
>         *** OOPS, hid == NULL ***
> 
> But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
> ("LNXVIDEO"), and acpi_device_set_id() already does synthesize
> that HID, so acpi_device_hid() should have been valid.  So why
> did we oops?

When I tripped over it, acpi_device_set_id() *wasn't* synthesizing an HID,
it was explicitly setting a NULL pointer.

--==_Exmh_1250279620_9206P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFKhcDEcC3lWbTT17ARAskyAKDVEW6Ck6qXYoc8Tf59sH/eLdebigCfcoYK
ksctPsAweTL9k+lI/BSuDVI=
=aCj7
-----END PGP SIGNATURE-----

--==_Exmh_1250279620_9206P--
