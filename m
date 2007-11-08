From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: *New* HP dv6000 series backlight driver.
Date: Thu, 8 Nov 2007 19:10:59 +0000
Message-ID: <20071108191059.d527c870.miknix@gmail.com>
References: <20070911171927.572087e0.miknix@gmail.com>
	<20071022004144.6e4240de.miknix@gmail.com>
	<20071107195619.8599c6a5.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:34997 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761004AbXKHTCm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 14:02:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so405692ugc
        for <linux-acpi@vger.kernel.org>; Thu, 08 Nov 2007 11:02:40 -0800 (PST)
In-Reply-To: <20071107195619.8599c6a5.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

After getting more into it, I've added support to some more stuff on the HP dv6500 laptops.

SUPORTED DEVICES:
* This is known to work on the dv6535ep (I think it may work on other dv6500 models):
  - CPU Temperature reading.
  - Backlight driver (hotkeys not working, yet).
  - LID status.
  - WIFI button status.

I've uploaded the driver and some information to my personal server (very bandwidth limited):
http://miknix.homelinux.com/dv6k_laptop/

I hope other HP dv6500 users like it :)
- -- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey online

- - -
Why won't you let me kiss you goodnight?  Is it something I said?
		-- Tom Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHM18/NahyoD2SuwsRAvFrAKCJ6a9q07hDneUK4ifPmqr2g20DFgCdFWvY
od9gzT7RJG8QNsuzCrh047Q=
=oXKG
-----END PGP SIGNATURE-----
