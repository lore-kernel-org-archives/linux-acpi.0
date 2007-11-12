From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: *NEW* ACPI driver to support App Hot Startup AKA PNP0C32
Date: Mon, 12 Nov 2007 00:05:34 +0000
Message-ID: <20071112000534.e0489eca.miknix@gmail.com>
References: <20071110014448.471e384b.miknix@gmail.com>
	<200711100321.22500.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43569 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbXKKX5K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Nov 2007 18:57:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so666799ugc
        for <linux-acpi@vger.kernel.org>; Sun, 11 Nov 2007 15:57:09 -0800 (PST)
In-Reply-To: <200711100321.22500.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 10 Nov 2007 03:21:21 +0000
Carlos Corbacho <carlos@strangeworlds.co.uk> wrote:

> Angelo,
> 
> On Saturday 10 November 2007 01:44:48 Angelo Miguel Arrifano wrote:
> > If the laptop is turned off and a hot button is pressed, the
> > computer turns on and boots. This module gets a notification from
> > ACPI which button was pressed. Then the driver writes to the proc
> > fs which button was pressed allowing userspace apps to read that
> > files and behave accordingly. Proc files are also writable.
> 
> Please use sysfs, not proc (even if you aren't considering submitting this 
> upstream) - /proc/acpi is deprecated and going away (slowly but surely).
> 
> -Carlos
> -- 
> E-Mail: carlos@strangeworlds.co.uk
> Web: strangeworlds.co.uk
> GPG Key ID: 0x23EE722D

Thanks! The driver is now using sysfs.
What should I do to submit the driver properly to upstream?

Best regards,
- -- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey online

- - -
Boys, you have ALL been selected to LEAVE th' PLANET in 15 minutes!!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHN5jONahyoD2SuwsRAnz4AKDlpmU8geaaR27s/gXX1KaE3/CFMACg4i9B
842nLwYkmvcH9FlmydSngjU=
=UtSO
-----END PGP SIGNATURE-----
